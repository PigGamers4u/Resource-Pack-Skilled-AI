# Materials

Source: Bedrock Wiki (wiki.bedrock.dev/visuals/materials), flagged there
as an "expert" topic — approach with caution, expect content-log errors
and long load times while iterating.

## What materials control

Materials configure which shader and which render states/settings are
used to draw a given part of the game. Most game elements are hard-coded
to a specific material and cannot be reassigned. **Only entities and
particles** support assigning, removing, or overriding materials.
Anything beyond that (changing a hard-coded element's material, or
writing fully custom shader code) is unsupported/experimental territory
— be explicit with the user about that distinction before going further.

## File location & syntax

`RP/materials/<name>.material`:

```json
{
  "materials": {
    "version": "1.0.0",
    "<new_material_id>:<base_material_id>": {
      "<defines/states/other settings>": "..."
    }
  }
}
```

- No namespaces in material IDs — plain names only.
- `<new>:<base>` means "create `<new>` by inheriting all settings from
  `<base>`, then apply the overrides below."

## Reading an inheritance chain (example: villagers)

```json
"villager_v2_masked:entity_multitexture_masked": {
  "depthFunc": "LessEqual"
}
```

`villager_v2_masked` builds on `entity_multitexture_masked`, which builds
on `entity_alphatest`:

```json
"entity_multitexture_masked:entity_alphatest": {
  "+defines": ["MASKED_MULTITEXTURE"],
  "+samplerStates": [
    { "samplerIndex": 0, "textureWrap": "Clamp" },
    { "samplerIndex": 1, "textureWrap": "Clamp" }
  ]
}
```

...which builds on `entity_nocull`, then `entity`, then finally
`entity_static` — the root of the chain, which is where the actual
`vertexShader`/`fragmentShader` paths and `vertexFields` live (no further
`:base` after its name, meaning it's the bottom):

```json
"entity_static": {
  "vertexShader": "shaders/entity.vertex",
  "fragmentShader": "shaders/entity.fragment",
  "vertexFields": [
    { "field": "Position" },
    { "field": "Normal" },
    { "field": "UV0" }
  ],
  "msaaSupport": "Both"
}
```

## The `+` prefix matters

A key prefixed with `+` (`+defines`, `+states`, `+samplerStates`, etc.)
**appends** to whatever was inherited. The same key **without** the `+`
**replaces** the inherited list entirely. Confusing the two is a common
source of "why did my override wipe out the base behavior" bugs.

## Version note: 1.16.100+ custom material inheritance

As of engine 1.16.100, a **custom** material inheriting from another
custom material via `<new>:<base>` throws a content log error. Workaround:
define the material fully standalone using a trailing colon with nothing
after it:

```json
{
  "materials": {
    "version": "1.0.0",
    "prefix:window_glass:": {
      "+states": ["Blending"],
      "defines": ["ENABLE_FOG", "ENABLE_LIGHT", "USE_ONLY_EMISSIVE"]
    }
  }
}
```

This may mean re-declaring values that used to come for free via
inheritance from another custom material — call this out to the user
rather than silently dropping fields.

## Practical guidance

- Before writing a material from scratch, find and adapt an existing
  vanilla one (via a `bedrock-samples` mirror or `references/`) — the
  inheritance chains are deep and easy to get subtly wrong blind.
- Iterate incrementally and test after each small change; this format is
  known to cause crashes and long loading times when wrong.
- Don't propose reassigning materials for anything other than entities
  or particles — it isn't supported for blocks/items/UI.
