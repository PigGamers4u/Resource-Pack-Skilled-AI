---
name: mcbe-rp-animations
description: Use for .animation.json keyframe animations and .animation_controllers.json state machines, including Molang expressions driving transitions. Load for "make it move", "play this animation when X", or animation-controller debugging.
---

# MCBE RP Animations & Animation Controllers

Read `../../docs/08-animations-and-controllers.md`.

## Two different files, two different jobs

- **`.animation.json`**: defines *what a bone does over time* — rotation/
  position/scale keyframes per bone, per animation name
  (`animation.<entity>.<name>`).
- **`.animation_controllers.json`**: defines *when* an animation plays —
  a state machine with named states, each holding one or more
  `animations` to play plus `transitions` guarded by Molang boolean
  expressions (reading entity properties/flags/variables).

Both get wired into the render controller / client entity file's
`scripts.animate` array — an animation or controller that exists on disk
but is never listed there will simply never play.

## Molang basics for transitions

- Common driving values: `query.is_moving`, `query.is_on_ground`,
  `query.health`, custom entity flags set from the behavior pack
  (`query.property('namespace:flag')` for newer versions using entity
  properties, or `variable.` / actor flags on older setups).
- Keep transition conditions mutually exclusive where possible to avoid
  flicker between two states that are both slightly true at once.

## Common mistakes to catch

- Animation defined but never referenced in `scripts.animate`.
- Controller referenced but the *initial state* name doesn't match any
  state defined in the controller (silent no-op).
- Blend weight/`blend_transition` not set, causing jarring snaps between
  states instead of smooth blends.
