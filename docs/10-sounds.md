# Sounds

## sound_definitions.json

```json
{
  "format_version": "1.14.0",
  "sound_definitions": {
    "my_pack.spark": {
      "category": "hostile",
      "sounds": [
        { "name": "sounds/my_pack/spark1", "volume": 1.0, "pitch": 1.0 },
        { "name": "sounds/my_pack/spark2", "volume": 0.9, "pitch": 1.1 }
      ]
    }
  }
}
```

Multiple entries under `sounds` are randomized on each trigger — a cheap
way to avoid a sound feeling repetitive.

## Categories

`hostile`, `neutral`, `player`, `ambient`, `block`, `music`, `record`,
`weather`, `ui`, `bottle`, `friendly` (exact set varies slightly by
version — verify against the target format_version). Category controls
which client volume slider affects it, and a wrong category is a common
cause of "the sound plays but I can't hear it" reports (player has that
category muted).

## Triggering

- BP entity `minecraft:entity_sounds` component maps entity sound events
  (hurt, death, ambient, step) to a sound_definitions.json key.
- Animation/controller sound-effect keyframes.
- `world.playSound(...)` from `@minecraft/server` script code.

## Common mistakes

- Referencing a sound name from BP/animation that was never added to
  `sound_definitions.json` — no error, just silence.
- Audio files not encoded as Ogg Vorbis.
