---
name: mcbe-rp-vibrant-visuals
description: Use for Vibrant Visuals / PBR (physically based rendering) work — texture sets (MER/MERS maps), the "pbr"/"raytraced" manifest capabilities, lighting/global.json, local_lighting/local_lighting.json, pbr/global.json, atmospherics, and key-frame JSON for day-night lighting changes. Load this for anything the user calls "shaders," "PBR," "Vibrant Visuals," reflections, or realistic lighting.
---

# MCBE RP Vibrant Visuals / PBR

Read `../../docs/17-vibrant-visuals-pbr.md`.

## What Vibrant Visuals actually is

It's Mojang's built-in PBR + deferred lighting/ray-tracing pipeline, not a
"write your own shader" system (that's the separate, unsupported/legacy
custom-shader path — see the note in `mcbe-rp-materials` if the user
specifically wants that instead). Vibrant Visuals is opt-in per resource
pack via a manifest capability, runs entirely client-side, and changes
visuals only — it never touches gameplay.

## The three things a pack can control

1. **Texture Sets** (`*.texture_set.json` next to a block/item/entity
   texture) — declare MER/MERS maps: metalness, emissive, roughness, and
   (Vibrant-Visuals-only) subsurface scattering, plus optional normal and
   height maps.
2. **Lighting JSON** — `lighting/global.json` (sun/moon/ambient/sky,
   supports per-biome variants and keyframes), `local_lighting/
   local_lighting.json` (per-block point/static light colors), and
   `pbr/global.json` (fallback MERS values for blocks/actors/particles/
   items that have no texture set).
3. **Manifest capability** — `"pbr"` for Vibrant Visuals, `"raytraced"`
   for RTX ray tracing; add both to `capabilities` if targeting both
   pipelines, but confirm with the user since they render differently and
   a pack tuned for one may need separate values for the other.

## Minimum steps for "add PBR to my block/item/entity"

1. Add `"capabilities": ["pbr"]` (and/or `"raytraced"`) to the RP's
   `manifest.json`, alongside the existing `header`/`modules`.
2. Create a `<name>.texture_set.json` next to the existing color texture,
   at minimum setting `color` and `metalness_emissive_roughness` (or the
   full `metalness_emissive_roughness_subsurface` for Vibrant Visuals-only
   subsurface support).
3. Author the actual MER(S) texture as a real PNG — this is not
   auto-generated, the user (or Blockbench's PBR plugin) needs to paint it.
4. Leave any map channel empty only if the default fallback value is
   acceptable — flag this to the user rather than silently omitting maps.

## Common mistakes to catch

- Forgetting the `capabilities` array entirely — texture sets are inert
  without it.
- Confusing the block-component `light_emission` value (a gameplay/vanilla
  lighting concept, also affects mob spawning) with the PBR "Emissive" map
  channel — they're separate systems that can be combined but aren't the
  same thing.
- Assuming ray-traced and Vibrant Visuals capabilities are interchangeable
  — they are not backwards-compatible with each other by default.
- Using an out-of-range value (e.g. sky `intensity` outside 0.1–1.0,
  ambient `illuminance` outside 0.0–5.0) — check the valid ranges in the
  doc before writing a lighting JSON.
- Not checking whether the target field supports keyframes at the user's
  `min_engine_version` — keyframe support for sky/ambient params was added
  in a specific version (see the schema version table in the doc); older
  targets need a flat value instead.
