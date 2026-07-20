---
name: mcbe-rp-entities-and-render-controllers
description: Use for client entity definition files (entity/*.entity.json) and render_controllers/*.render_controllers.json — the files that tie geometry, texture, animations, and materials together into a rendered entity. Load for "my custom mob is invisible/wrong texture/not animating" and full custom-mob builds.
---

# MCBE RP Client Entity Files & Render Controllers

Read `../../docs/11-entities-and-render-controllers.md`.

## The wiring chain (all of these must agree)

1. **Client entity file** (`entity/foo.entity.json`):
   `description.identifier` (must match the BP entity identifier),
   `description.materials`, `description.textures` (map, e.g.
   `default` -> path), `description.geometry` (map, e.g. `default` ->
   `geometry.foo`), `description.animations` (map, short name -> animation
   or controller identifier), `description.scripts.animate` (array of the
   short names above that should actually run), and
   `description.render_controllers` (array referencing controller
   identifiers).
2. **Render controller** (`render_controllers/foo.render_controllers.json`):
   picks *which* texture/geometry/material map entries to actually use
   (often via Molang, e.g. switching texture by variant), and can loop over
   `arrays.textures`/`arrays.geometries` for multi-variant entities.
3. **Geometry + texture + animation files** themselves (see their own
   skills).

A file existing on disk wires nothing by itself — every link in this chain
has to *reference* the previous one by identifier/key, or the mob renders
as the default "missing" box, invisible, or unanimated.

## Common mistakes to catch

- `description.identifier` mismatch between client entity file and BP
  entity file (must match exactly, including namespace).
- Animation/controller added to `description.animations` but not also
  listed in `description.scripts.animate`.
- Render controller referencing a texture/geometry array key that was
  never defined in the client entity file's `textures`/`geometry` maps.
- Missing `materials` entry (defaults usually work, but custom
  transparency/emissive effects need an explicit material reference).
