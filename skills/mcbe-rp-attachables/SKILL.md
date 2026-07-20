---
name: mcbe-rp-attachables
description: Use for attachable JSON files — custom held-item visuals, first/third-person item models, and custom armor/equipment appearance. Load for "custom item model" or "custom armor look" tasks.
---

# MCBE RP Attachables

Read `../../docs/12-attachables.md`.

## Structure

- `attachables/foo.attachable.json`: `description.identifier` (must match
  the item identifier it's attached to), `materials`, `textures`,
  `geometry`, `animations`, `scripts.animate`, and `render_controllers` —
  same wiring pattern as a client entity file, but scoped to an item/armor
  visual rather than a full mob.
- Distinguish `slot.weapon.mainhand` / `slot.weapon.offhand` /
  `slot.armor.head` etc. bone-attachment behavior when relevant — this
  determines which player bone the geometry attaches to and how it's
  positioned by default.

## Common mistakes to catch

- Identifier not matching the BP item's identifier exactly.
- Using entity geometry conventions (bone names like `head`/`body`) when
  an item attachable actually needs a bone that matches player-model
  attachment points — verify against a working reference attachable
  rather than guessing bone names.
