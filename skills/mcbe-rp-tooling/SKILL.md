---
name: mcbe-rp-tooling
description: Use for questions about editors, validators, packagers, and general dev workflow for building/testing Bedrock resource packs (not the JSON content itself).
---

# MCBE RP Tooling

Read `../../docs/16-token-efficient-routing.md` for how this skill suite is
organized, and check `references/external/` and `scripts/` in this repo for
mirrored tools and validators the user has added.

## Typical workflow tooling

- A JSON schema set (for VS Code `json.schemas` autocomplete/validation) —
  check `references/schemas/` for what's available locally before telling
  the user to search for one.
- A pack validator script (see `scripts/validate-resource-pack.*` in this
  repo) to catch structural errors (missing manifest fields, dangling
  texture references) before loading the pack in-game.
- Reloading: Bedrock generally requires closing/reopening the world (or
  using `/reload` for some content in creator/dev builds) to pick up RP
  changes — hot-reload behavior varies by platform and content type, so
  don't assume every edit appears without a reload.
