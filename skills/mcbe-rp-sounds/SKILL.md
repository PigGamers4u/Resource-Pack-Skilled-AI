---
name: mcbe-rp-sounds
description: Use for sound_definitions.json and sounds.json — mapping sound event names to audio files, categories, and volume/pitch ranges. Load for "add a custom sound" tasks.
---

# MCBE RP Sounds

Read `../../docs/10-sounds.md`.

## Two files, two jobs

- `sounds/sound_definitions.json` — declares a **sound name** ->
  one or more audio file paths (ogg, under `sounds/`), plus `category`
  (e.g. `hostile`, `neutral`, `ambient`, `record`, `ui`), and optional
  `volume`/`pitch` ranges for randomized variation.
- `sounds.json` (top-level) — maps **legacy/vanilla event names** to
  entries in `sound_definitions.json`; mainly relevant when overriding a
  vanilla sound event rather than adding a brand-new custom one.

## Wiring for custom entities

A custom mob's sound is normally triggered either:
- from the BP entity's `minecraft:entity_sounds` component (event ->
  sound name mapping), or
- from an animation/animation controller sound effect keyframe
  referencing the same sound name.

## Common mistakes to catch

- Sound name referenced from BP/animation but missing from
  `sound_definitions.json` (silent failure — no sound, no error).
- Wrong `category`, causing the sound to be muted by an unrelated
  in-game volume slider the player has turned down.
- Audio files not in Ogg Vorbis format / wrong sample rate causing the
  client to silently skip playback.
