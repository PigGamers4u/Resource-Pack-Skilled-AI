# Manifest & Pack Structure

## manifest.json anatomy

```json
{
  "format_version": 2,
  "header": {
    "name": "My Resource Pack",
    "description": "Custom RP for MyAddon",
    "uuid": "REPLACE-WITH-UNIQUE-V4-UUID",
    "version": [1, 0, 0],
    "min_engine_version": [1, 21, 0]
  },
  "modules": [
    {
      "type": "resources",
      "uuid": "REPLACE-WITH-A-DIFFERENT-UNIQUE-V4-UUID",
      "version": [1, 0, 0]
    }
  ],
  "dependencies": [
    {
      "uuid": "UUID-OF-MATCHING-BEHAVIOR-PACK-HEADER",
      "version": [1, 0, 0]
    }
  ]
}
```

Rules that generate the most support requests when violated:

- `header.uuid` and every `modules[n].uuid` must all be **distinct** UUIDs.
- Never reuse a UUID from another pack, including copy-pasted tutorial
  examples — generate a fresh one per pack/module.
- `version` arrays are `[major, minor, patch]` integers, not a string.
- If pairing with a BP, the BP's own `header.uuid` is what goes in this
  RP's `dependencies[].uuid` (and vice versa) — not the module UUID.

## Folder layout

See the table in `mcbe-rp-manifest-and-structure/SKILL.md` for the full
tree. The only two things required for a pack to be *valid* are
`manifest.json` and a `pack_icon.png` (optional but expected by the game
UI) — everything else is added as needed per feature.

## format_version footguns

Individual JSON files (geometry, animations, particles, render
controllers) each declare their **own** `format_version` independent of
the manifest's. A field can exist in one format_version and not another —
always check the target version before assuming a field name is valid.
