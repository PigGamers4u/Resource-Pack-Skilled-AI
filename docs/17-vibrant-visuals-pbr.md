# Vibrant Visuals / PBR

Source: Microsoft Learn's Vibrant Visuals documentation
(learn.microsoft.com/minecraft/creator/documents/vibrantvisuals). Verify
against that source for anything version-specific, since this system has
been actively evolving (schema versions referenced below go up to 1.26.0
as of the last check).

## What it is

Vibrant Visuals is Mojang's built-in physically-based-rendering (PBR)
pipeline for deferred lighting and ray tracing: directional lighting,
volumetric fog, atmospherics, reflections, and shadows. It's visuals-only
(no gameplay changes) and runs entirely client-side — players opt in via
Video Settings > Graphics Mode.

## Enabling it for a pack

Add a `capabilities` array to the RP's `manifest.json`, alongside
`header`/`modules`:

```json
{
  "format_version": 1,
  "header": { "...": "..." },
  "modules": [ { "...": "..." } ],
  "capabilities": [
    "pbr",
    "raytraced"
  ]
}
```

- `"pbr"` unlocks Vibrant Visuals support.
- `"raytraced"` unlocks RTX ray-tracing support.
- These capabilities are **not backwards-compatible** with each other —
  a pack built only for the old RTX pipeline may need additional work to
  look right in Vibrant Visuals, and vice versa.
- Any PBR field a pack doesn't supply falls back to an engine default.

## Texture Sets (MER / MERS maps)

A Texture Set JSON sits next to the regular color texture and declares
extra grayscale/RGB maps that describe surface material properties:

| Map | Channel meaning | 0.0 (black) | 1.0 (white) |
|---|---|---|---|
| Metalness | how metallic | non-metallic (grass, wood) | fully metallic (iron, gold) |
| Emissive | how much it glows | dark | fully emissive |
| Roughness | how rough/smooth | smooth (glass, polished) | rough (brick, bark) |
| Normal (RGB, not grayscale) | surface direction per-pixel | — | flat = (128,128,255) |
| Height | extrusion depth | extrudes inward | extrudes outward |
| Subsurface scattering (Vibrant Visuals only) | light passing through material | — | — |

In ray-traced mode, texture sets only apply to **blocks**. In Vibrant
Visuals, they can also apply to mobs, items, and particles.

Example `iron_block.texture_set.json`:

```json
{
  "format_version": "1.16.100",
  "minecraft:texture_set": {
    "color": "iron_block",
    "metalness_emissive_roughness": "iron_block_mer"
  }
}
```

A fully reflective "mirror" look: roughness map at solid black (0.0,
perfectly smooth) + metalness map at solid white (1.0, fully metallic).

## Lighting JSON (three separate files, three separate jobs)

1. **`lighting/global.json`** — `minecraft:lighting_settings`:
   directional lights (`orbital.sun`/`orbital.moon`, each with
   `illuminance` in lux and `color`, plus `orbital_offset_degrees`), the
   End's `flash`, `emissive.desaturation`, `ambient` (`illuminance`
   0.0–5.0, `color`, default `#FFFFFF` @ `0.02`), and `sky.intensity`
   (0.1–1.0, default `1.0`). Per-biome variants are supported (as of
   1.21.90) by adding additional lighting JSON files in this directory
   assigned to specific biomes — a plain `lighting/global.json` no longer
   overrides vanilla per-biome lighting on its own.
2. **`local_lighting/local_lighting.json`** — `minecraft:local_light_settings`:
   per-block-identifier `light_color` + `light_type`
   (`"static_light"` or `"point_light"`). Static lights are baked-in,
   uniform, no dynamic shadows (what torches/glowstone/lanterns already
   use). Point lights emit from a single point with real specular
   highlights and dynamic shadows but are more performance-costly —
   several vanilla blocks (torch, redstone_torch, end_rod, lantern,
   soul_lantern, soul_torch, candle variants, sea_pickle, copper_torch/
   lantern variants) are already point lights by default and can only
   have their *color* overridden here, not their point-vs-static type.
3. **`pbr/global.json`** — `minecraft:pbr_fallback_settings`: default
   MERS values per category (`blocks`, `actors`, `particles`, `items`)
   used when a specific object has no texture set of its own.

Color values in all three files accept either an `[R, G, B]` array
(0–255) or a 6-digit hex string.

### Keyframing lighting over the day-night cycle

Several fields (sun/moon `illuminance`/`color`, ambient
`illuminance`/`color`, sky `intensity` as of `1.26.0`) accept a keyframe
object instead of a flat value — keys are a `0.0`–`1.0` fraction of the
day cycle, values are the setting at that point:

```json
"illuminance": {
  "0.0": 109880.0,
  "0.25": 20000.0,
  "0.5": 1.0,
  "0.75": 20000.0,
  "1.0": 109880.0
}
```

Check the field's schema-version requirement against the pack's
`min_engine_version` before assuming keyframe support is available —
older targets need a flat value instead.

## Reflections

Vibrant Visuals reflections come from image-based lighting (IBL) and
screen-space reflections (SSR); there's no direct "reflection strength"
knob — `roughness` and `metalness` in texture sets (or the `pbr/
global.json` fallback) are what control how reflective a surface looks.
Off-screen objects and first-person mirror reflections aren't supported;
transparent geometry other than water doesn't receive SSR.

## Common mistakes to catch

- Forgetting the `capabilities` array — texture sets/lighting JSON are
  otherwise inert.
- Confusing the block-component `light_emission` (a separate, gameplay-
  affecting concept — e.g. mob spawning) with the PBR "Emissive" texture
  map — related but distinct systems that can be combined.
- Out-of-range values (ambient illuminance outside 0.0–5.0, sky intensity
  outside 0.1–1.0).
- Assuming a `lighting/global.json` alone overrides vanilla per-biome
  lighting on current versions — it doesn't; biome-specific files are
  required for that as of 1.21.90.
