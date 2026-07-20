---
name: mcbe-rp-lang-and-text
description: Use for texts/*.lang files, languages.json, and localization key conventions for items, blocks, entities, and UI strings.
---

# MCBE RP Lang & Text

Read `../../docs/13-lang-and-localization.md`.

## Key conventions

- `texts/languages.json`: array of language codes the pack supports
  (e.g. `["en_US"]`).
- `texts/en_US.lang`: `key=value` pairs, one per line, `#` for comments.
- Standard key patterns:
  - Item: `item.<namespace>:<item_name>.name=Display Name`
  - Block: `tile.<namespace>:<block_name>.name=Display Name`
  - Entity: `entity.<namespace>:<entity_name>.name=Display Name`
- Pack metadata strings (`pack.name`, `pack.description`) can also live
  here for localized pack listings.

## Common mistakes to catch

- Key namespace/name not matching the BP identifier exactly (case-sensitive) —
  results in the raw identifier showing in-game instead of the friendly name.
- Missing entry in `languages.json` for a `.lang` file that does exist —
  the file is ignored if its language isn't declared.
