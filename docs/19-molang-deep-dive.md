# Molang Deep Dive

Source: Microsoft Learn's Molang Syntax Guide and Practical Molang
documents. Molang is a small C-like expression language embedded in
Bedrock JSON files (animations, animation controllers, render
controllers, particles) for fast, data-driven runtime calculation.

## Syntax basics

- A single expression with no `;` implicitly returns its value:
  `math.sin(query.anim_time * 1.23)`
- Multi-statement expressions need `;` after each statement, and the
  final statement should be `return <value>;` — omitting `return` makes
  the whole expression evaluate to `0.0`:
  ```
  temp.moo = math.sin(query.anim_time * 1.23);
  temp.baa = math.cos(query.life_time + 2.0);
  return temp.moo * temp.moo + temp.baa;
  ```
- Molang is case-insensitive except inside string literals.

## Variable scopes (lifetimes)

| Prefix | Alias | Lifetime | Notes |
|---|---|---|---|
| `temp.` | `t.` | current expression execution only | technically global to the whole expression's execution, not just one block scope — reused names across sub-scopes can leak values |
| `variable.` | `v.` | life of the entity | not saved across world reload or despawn |
| `context.` | `c.` | current expression, read-only | provided by the game/behavior in that specific context |
| `query.` | `q.` | read-only entity/game property access | the main way to read game state |

### Public variables

An entity variable is private by default. To let *other* entities read
it, mark it `"public"` in the client entity file and default-initialize
it:

```json
"scripts": {
  "variables": { "variable.oink": "public" },
  "initialize": ["variable.oink = 0;"]
}
```

## Values

- All numbers are floats; booleans are `0.0`/`1.0`.
- Errors (divide by zero, missing variable, null actor reference, etc.)
  generally resolve to `0.0` rather than throwing.
- Array indices are cast to int; negative indices clamp to `0`, indices
  past the end **wrap around** (not an error).
- Supported value types beyond numbers/strings: Geometry, Texture,
  Material, Actor Reference, Actor Reference Array, Struct.
- **`material`, `texture`, and `geometry` typed values are only usable in
  render controllers** — not in animation files or animation controllers.

## Structs and the arrow operator

Structs are implicitly defined by usage (no declaration needed), letting
you pass grouped data around:

```
v.location.x = 1;
v.location.y = 2;
v.location.z = 3;
v.another_mobs_location = v.another_mob_set_elsewhere->v.location;
```

`->` reads a *public* variable/struct off a different actor reference.

## Strings

Single-quoted (`'minecraft:pig'`), support only `==`/`!=`, no escape
characters, empty string is `''`.

## Conditionals

- `A ? B` — run `B` only if `A` is true (no else-branch; if `A` is false,
  nothing happens — don't assume this is the same as a full ternary).
- `A ? B : C` — full ternary; returns `B` if `A` else `C`.
- Nested ternaries without parentheses were mis-parsed before engine
  version 1.18.20 — check `min_engine_version` if behavior looks wrong on
  an older-targeted pack.

## Loops

```
loop(<count>, <expression>);
```

- Max loop count is 1024 for safety; loops can nest.
- `break` exits the innermost active loop/`for_each` early.
- `continue` skips to the next iteration.
- `for_each` iterates over an actor reference array.

## Null-coalescing operator (`??`)

```
variable.x = (variable.y ?? 1.2) + 0.3;
```

Returns the left side if it resolves to a valid number/entity reference,
otherwise the right side (a default). Works only for `variable.`/
`temp.`/`context.` holding numbers or entity references — **not** for
`material`/`texture`/`geometry`, which must resolve validly or throw a
content error.

## Practical patterns

### Pre-computing values in `pre_animation`

Client entity files can run Molang in `scripts.pre_animation` right
before animations/render controllers process each frame — a good place
to compute a value once and reuse it in multiple animation files:

```json
"scripts": {
  "pre_animation": [
    "variable.wing_flap = ((math.sin(query.wing_flap_position * 57.3) + 1) * query.wing_flap_speed);"
  ]
}
```

### Passing parameters to animations

```json
"animate": [
  "general",
  { "move": "query.modified_move_speed" },
  { "baby_transform": "query.is_baby" }
]
```

### Animation controller transitions

```json
"controller.animation.wolf.sitting": {
  "initial_state": "default",
  "states": {
    "default": {
      "animations": ["wolf_leg_default"],
      "transitions": [{ "sitting": "query.is_sitting" }]
    },
    "sitting": {
      "animations": ["wolf_sitting"],
      "transitions": [{ "default": "!query.is_sitting" }]
    }
  }
}
```

### Render controller array + resource-reference Molang

```json
{
  "format_version": "1.8.0",
  "render_controllers": {
    "controller.render.fox": {
      "arrays": {
        "textures": { "Array.skins": ["Texture.red", "Texture.arctic"] }
      },
      "geometry": "Geometry.default",
      "part_visibility": [
        { "leg*": "!query.is_sleeping" },
        { "head": "!query.is_sleeping" },
        { "head_sleeping": "query.is_sleeping" }
      ],
      "materials": [{ "*": "Material.default" }],
      "textures": ["Array.skins[query.variant]"]
    }
  }
}
```

- `Array.skins[query.variant]` picks a texture by index; boolean queries
  are `0.0`/`1.0` so they work directly as a 2-element array index.
- Bone-name matching in `materials` supports wildcards: `foo*` (starts
  with), `*foo` (ends with), `*foo*` (contains), `*` alone (all bones —
  useful as a default before more specific overrides).
- Going out of array bounds never errors: negative clamps to element 0,
  too-large wraps around (10-element array, index 10 -> element 0, index
  15 -> element 4).

### Particle Molang

Particle components frequently use `math.random(...)` for lifetime/size
variance and reference variables set earlier in the same effect (e.g. a
`ParticleAge`/`ParticleRandom1` pattern for fade/size-over-life curves).

## Versioned behavior

Molang behavior is gated by the pack's `min_engine_version` — bug fixes
and precedence changes only apply once a pack targets that version or
higher, so two loaded packs can have different Molang behavior active at
once. If an expression evaluates unexpectedly, check whether a versioned
change (operator precedence, ternary associativity, a renamed query)
explains it before assuming the expression is wrong.
