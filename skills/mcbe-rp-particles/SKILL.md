---
name: mcbe-rp-particles
description: Use for particle effect JSON — emitter shape, emitter rate, particle appearance/motion components, and curves. Load for "add a particle effect" tasks.
---

# MCBE RP Particles

Read `../../docs/09-particles.md`.

## Structure

- `particle_effect.description.identifier` — how it's referenced (from a
  BP entity event, a command, or an animation controller particle effect
  reference).
- `components` block, commonly including:
  - `minecraft:emitter_rate_instant` / `minecraft:emitter_rate_steady` —
    how many/how fast particles spawn.
  - `minecraft:emitter_shape_point` / `_sphere` / `_box` / `_disc` /
    `_entity_aabb` — where particles originate.
  - `minecraft:particle_lifetime_expression` — how long each particle lives.
  - `minecraft:particle_appearance_billboard` (or `_tinting`) — texture,
    size, facing camera behavior.
  - `minecraft:particle_motion_dynamic` / `_parametric` — velocity,
    acceleration, drag.
- `curves` — named expressions particles can reference for values that
  change over the particle's lifetime (e.g. fade-out opacity curve).

## Common mistakes to catch

- Texture path in `particle_appearance_billboard` not matching an actual
  PNG under `textures/particle/`.
- Emitter never triggered from the BP side (particles are inert until an
  entity event, spawn rule, or animation controller fires them).
- Lifetime/curve mismatch causing particles to visually "pop" instead of
  fading, when a fade-out curve was intended but not wired to opacity.
