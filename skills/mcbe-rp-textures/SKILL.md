---
name: mcbe-rp-textures
description: Use for anything involving texture files and their JSON indexes — terrain_texture.json, item_texture.json, flipbook_textures.json, texture short-name resolution, atlases, and texture path conventions for blocks/items/entities/UI.
---

# MCBE RP Textures

Read `../../docs/06-texture-pipeline.md`.

## Key files

- `textures/terrain_texture.json` — maps a block texture **short-name** key
  (referenced from block definitions in the BP) to one or more PNG paths
  under `textures/blocks/`.
- `textures/item_texture.json` — same idea for items, PNGs typically under
  `textures/items/`.
- `textures/flipbook_textures.json` — declares animated textures (frame
  sequence + tick rate) layered on top of a terrain/item texture entry.
- Entity textures are referenced **directly by path** from the client
  entity file's `description.textures` map — no short-name indirection.

## Common mistakes to catch

- Forgetting to add a new texture's short-name to `terrain_texture.json`/
  `item_texture.json` — the texture exists on disk but nothing points at it.
- Path typos (case sensitivity matters on some platforms even though
  Windows/most local testing won't catch it).
- Using an item/block short-name key that collides with a vanilla one,
  silently overriding vanilla textures pack-wide.
- Flipbook entries need `atlas_tile` (or `flipbook_texture`/`atlas_index`
  depending on target version) to match an existing terrain/item texture
  key — verify against the user's actual format_version.
