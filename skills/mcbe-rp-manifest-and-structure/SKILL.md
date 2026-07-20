---
name: mcbe-rp-manifest-and-structure
description: Use for manifest.json authoring, UUID/version management, pack dependencies, format_version selection, and the standard resource pack folder layout. Load this whenever a task involves creating a new pack, wiring an RP to a BP, or "my pack won't load / isn't recognized".
---

# MCBE RP Manifest & Structure

Read `../../docs/05-manifest-and-pack-structure.md`.

## Checklist for a valid manifest.json

- `format_version` at top level (use `2` unless the user needs a specific
  legacy target).
- `header`: `name`, `description`, `uuid` (a **unique** v4 UUID, never
  reused across packs — this is the #1 cause of "pack won't apply"), `version`
  (`[major, minor, patch]`), and `min_engine_version`.
- `modules`: at least one module with its own `uuid` (different from the
  header UUID), `type: "resources"`, and matching `version`.
- Optional `dependencies` array: each entry references a BP or RP by its
  `uuid` + `version` — this is how a BP and RP declare they belong together.
- `metadata` (optional): authors, license, url.

## Folder layout reference

```
my_pack/
  manifest.json
  pack_icon.png
  textures/
    terrain_texture.json
    item_texture.json
    flipbook_textures.json
    blocks/...
    items/...
    entity/...
    ui/...
    environment/...
  models/
    entity/*.geo.json
    attachables/*.geo.json
  animations/*.animation.json
  animation_controllers/*.animation_controllers.json
  particles/*.json
  render_controllers/*.render_controllers.json
  entity/*.entity.json           (client entity definitions)
  attachables/*.attachable.json
  sounds/                        (audio files)
  sounds.json
  texts/
    en_US.lang
    languages.json
  ui/*.json
  fonts/
```

Always confirm the user's target `format_version`/`min_engine_version`
before generating fields that may not exist on older versions — flag when
unsure rather than assuming the newest schema.
