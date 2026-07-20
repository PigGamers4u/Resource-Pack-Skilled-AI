---
name: mcbe-rp-debugging
description: Use whenever the user reports something not working — pack won't load, texture missing/purple-black, model invisible, animation not playing, sound silent, particle not showing. Load this alongside the specific topic skill for the asset type involved.
---

# MCBE RP Debugging

Read `../../docs/14-common-failure-modes.md`.

## Triage order

1. **Pack not recognized at all** -> check `manifest.json` validity
   (valid JSON, correct/unique UUIDs, matching `format_version`).
2. **Purple-black checkerboard texture** -> texture path wrong, or missing
   entry in `terrain_texture.json`/`item_texture.json`.
3. **Invisible model / default box** -> geometry identifier mismatch
   between `.geo.json` and the client entity file's `description.geometry`.
4. **Model visible but not animating** -> animation/controller not listed
   in `description.scripts.animate`, or Molang transition condition never
   evaluates true.
5. **No sound** -> sound name missing from `sound_definitions.json`, or
   category muted client-side.
6. **No particles** -> emitter never triggered from BP side, or texture
   path in the particle file is wrong.
7. **Works standalone, breaks when merged with other packs** -> short-name
   or identifier collision; see the Pack Merge topic in
   `../../docs/14-common-failure-modes.md`.

Always ask for (or generate and check) the exact file names/identifiers
involved before proposing a fix — most RP bugs are a single mismatched
string, not a conceptual error.
