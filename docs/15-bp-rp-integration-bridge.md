# BP <-> RP Integration Bridge

## What the RP can "see"

The resource pack is passive. It can react to:
- **Entity events** fired from the BP (`events` blocks with
  `component_groups` and, in the RP, matching sound/particle/animation
  identifiers listening for the same trigger names).
- **Entity properties / actor flags** the BP sets, which Molang in
  animation controllers/render controllers can query
  (`query.property('namespace:flag')` in newer versions).
- **Vanilla queryable state** (`query.health`, `query.is_moving`, etc.)
  which needs no BP wiring at all.
- **Direct script calls** from `@minecraft/server`:
  `entity.triggerEvent(...)`, `world.playSound(...)`,
  `dimension.spawnParticle(...)` — these fire RP-defined identifiers at
  runtime from scripted logic (e.g. a custom `/kit` command giving an
  item could also trigger a confirmation sound/particle this way).

## What it cannot do

- Read arbitrary BP script variables, dynamic properties, or scoreboard/
  score values directly — any such value has to be surfaced through an
  entity property, actor flag, or a vanilla query the RP already
  understands.
- Execute any general-purpose logic — Molang is an expression language for
  reading/comparing values, not a scripting language.

## Practical pattern for a scripted feature

1. Decide what visual/audio feedback the feature needs (sound, particle,
   animation state change).
2. Author the RP-side asset and identifier first (sound_definitions entry,
   particle effect, or animation controller state) as if it were static.
3. From the BP/script side, call `triggerEvent`/`playSound`/
   `spawnParticle` (or set the entity property/flag a Molang transition is
   watching) at the right moment.
4. Test each side independently before assuming a combined bug is on
   "the other side" — most integration bugs are an identifier typo, not a
   conceptual issue with the bridge itself.
