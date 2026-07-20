# Boat Water Wake

This is a ready-to-import Minecraft Bedrock add-on example that gives every moving boat a short, bright water wake similar to the reference image.

## Install

1. Copy `BP_boat_water_wake` to Minecraft's `development_behavior_packs` folder.
2. Copy `RP_boat_water_wake` to `development_resource_packs`.
3. In a test world's Add-Ons settings, activate **both** packs.
4. Enter the world and row a boat over water.

The behavior pack checks boats every four ticks. When a boat is in water and moving fast enough, it places a short-lived emitter at its stern. Each emitter creates a small field of particles whose Molang `relative_position` formula draws two expanding, slightly wavy arms of a V-shaped wake. The formula uses `variable.particle_age / variable.particle_lifetime`, so every foam piece progresses naturally along the curve before fading.

## Tuning

- More/less trail: change `EMIT_INTERVAL_TICKS` in `BP_boat_water_wake/scripts/main.js` (smaller means denser).
- Starts at a different speed: change `MIN_HORIZONTAL_SPEED`.
- Wider/narrower wake: change `REAR_OFFSET` or `SIDE_OFFSET`.
- Bigger/longer foam: change the `size` or `max_lifetime` in `RP_boat_water_wake/particles/boat_wake.particle.json`.

This is visual-only: it does not create real water blocks or change boat physics.
