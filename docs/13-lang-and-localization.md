# Lang & Localization

## texts/languages.json

```json
["en_US"]
```

## texts/en_US.lang

```
## Items
item.my_pack:my_item.name=My Item

## Blocks
tile.my_pack:my_block.name=My Block

## Entities
entity.my_pack:my_mob.name=My Mob

## Pack metadata
pack.name=My Resource Pack
pack.description=Custom RP for MyAddon
```

- One `key=value` pair per line, `#` (or `##`) for comments.
- Namespace + identifier in the key must match the BP definition exactly
  (case-sensitive) or the raw identifier string shows in-game instead of
  the friendly name.
- A `.lang` file for a language not listed in `languages.json` is ignored
  entirely.
