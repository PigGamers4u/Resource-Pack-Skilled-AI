---
name: mcbe-rp-addon-integration
description: Use when a task spans both the behavior pack and resource pack — e.g. a scripted event should trigger an animation, particle, or sound; a custom item needs both server-side item behavior and an RP texture/attachable; or a @minecraft/server script needs to affect what the RP shows.
---

# MCBE BP <-> RP Integration Bridge

Read `../../docs/15-bp-rp-integration-bridge.md`.

## What crosses the boundary, and how

- **Entity events** defined in the BP (`minecraft:entity_definitions` /
  `component_groups` triggered via `events`) can fire RP-side animation
  triggers, particle effects, and sounds by identifier — the RP never
  needs to know *why*, only the event name it's listening for.
- **`@minecraft/server`** script API calls (e.g.
  `entity.triggerEvent(...)`, `world.playSound(...)`,
  `dimension.spawnParticle(...)`) are how a scripted BP addon can drive RP
  visuals/audio at runtime instead of going through static entity events.
- Resource packs cannot read BP scripting state directly — any dynamic
  value shown visually (like a custom health bar via JSON UI, or a
  Molang-driven animation state) has to be exposed through a mechanism the
  RP *can* read: entity properties, actor flags/variables, or vanilla
  queryable state (`query.health`, etc.).

## Common mistakes to catch

- Assuming the RP can call BP script functions directly — it cannot;
  the RP is passive and only reacts to identifiers/events/properties it's
  told about.
- Firing a `triggerEvent`/particle/sound from script but never having
  actually authored the matching RP asset (or having a typo in the
  identifier) — silent no-op.
- For deep BP-side implementation (dynamic properties, custom commands,
  item serialization, etc.), hand off to general `@minecraft/server`
  scripting knowledge rather than trying to solve it inside this RP skill.
