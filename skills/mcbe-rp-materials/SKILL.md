---
name: mcbe-rp-materials
description: Use for .material files under RP/materials/ — the inheritance-based shader/render-state configuration system for entities and particles (defines, states, shaders, samplerStates). Load this when the user wants to customize how an entity or particle is rendered at a low level, or asks about "materials" specifically (distinct from Texture Sets/PBR and distinct from custom shaders).
---

# MCBE RP Materials

Read `../../docs/18-materials.md`.

## What this is (and isn't)

`.material` files configure the actual render/shader settings Bedrock
uses for entities and particles — think of them as "which shader program
and which GPU render states" rather than "which texture." Only entities
and particles can have their material reassigned or removed; most other
game elements are hard-coded to a specific material. This is a genuinely
advanced, fragile system — set expectations with the user up front:
mistakes here can cause crashes, content-log errors, or long load times.

This is **not** the same as:
- **Texture Sets / PBR** (`mcbe-rp-vibrant-visuals`) — those configure
  per-pixel material *properties* (metalness/roughness/etc.), not the
  shader pipeline itself.
- **Custom shaders** — an old, no-longer-officially-supported
  experimental feature for writing your own shader code from scratch.
  If the user specifically wants that (rather than tuning existing
  materials), tell them plainly it's unsupported/legacy territory and
  confirm that's really what they're asking for before going further.

## Syntax

```json
{
  "materials": {
    "version": "1.0.0",
    "<new_material_id>:<base_material_id>": {
      "+defines": ["SOME_FLAG"],
      "+samplerStates": [
        { "samplerIndex": 0, "textureWrap": "Clamp" }
      ]
    }
  }
}
```

- No namespaces are used in material IDs — just a plain name.
- The `<new>:<base>` syntax means "define `<new>`, inheriting everything
  from `<base>`, then apply the overrides in this block." Chains of
  inheritance are common (e.g. a mob-specific material builds on
  `entity_multitexture_masked`, which builds on `entity_alphatest`, which
  builds on `entity_nocull`, which builds on `entity`, which builds on
  `entity_static` — the actual bottom of the chain, holding the real
  `vertexShader`/`fragmentShader` paths).
- A `+` prefix on a key (e.g. `+defines`, `+states`, `+samplerStates`)
  **appends** to the inherited list rather than replacing it; omitting
  the `+` replaces it outright — this distinction is easy to miss and
  causes silently-wrong inherited behavior.

## Version-specific gotcha (1.16.100+)

As of engine 1.16.100, inheriting from another material using the
`<new>:<base>` syntax in a **custom** (non-vanilla) material can throw a
content log error. The documented workaround is to define the material
fully standalone using just `<prefix>:<name>:` (trailing colon, no base
after it) instead of chaining off another custom material — check the
doc for the exact before/after example, and warn the user this may mean
re-declaring values that used to come from inheritance.

## Practical guidance

- Point the user at `references/schemas/` or existing vanilla
  `.material` files (via `bedrock-samples`) before writing one from
  scratch — copying and trimming a working vanilla material chain is
  much safer than authoring one blind.
- Only entities and particles can be assigned a custom/default material;
  don't propose reassigning materials for blocks/items/UI.
- Warn the user this is a "expert-level, here-be-dragons" part of the
  format (this is the Bedrock Wiki's own framing, not an exaggeration) —
  test incrementally rather than writing a large custom material tree in
  one pass.
