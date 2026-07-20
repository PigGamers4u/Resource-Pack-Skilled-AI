---
name: mcbe-rp-models-and-geometry
description: Use for .geo.json model files — bone hierarchies, cubes, UV mapping, pivot points, model scale/visible_bounds. Load for any "custom model" or "custom mob shape" task.
---

# MCBE RP Models & Geometry

Read `../../docs/07-geometry-and-models.md`.

## Structure of a `.geo.json`

- Top-level `format_version` + `minecraft:geometry` array.
- Each geometry entry has a `description` (`identifier`, `texture_width`,
  `texture_height`, `visible_bounds_width/height/offset`) and a `bones`
  array.
- Each **bone**: `name`, optional `parent` (for hierarchy/animation
  inheritance), `pivot` (rotation origin in model-space units), and
  `cubes` (each cube: `origin`, `size`, `uv`).
- `identifier` must be referenced exactly (including the `geometry.` prefix
  convention, e.g. `geometry.custom_mob`) from the client entity file's
  `description.geometry` map.

## Common mistakes to catch

- Pivot point not matching the intended rotation origin — causes limbs to
  swing from the wrong point when animated.
- UV coordinates that don't match `texture_width`/`texture_height` — causes
  texture stretching/misalignment (a classic "my skin looks wrong" bug).
- Parent bone typos — breaks the animation hierarchy silently (child bone
  just doesn't move with parent).
- Forgetting `visible_bounds` sizing large enough — causes the model to be
  culled/pop out of view at certain camera angles even though it's still
  "there".
