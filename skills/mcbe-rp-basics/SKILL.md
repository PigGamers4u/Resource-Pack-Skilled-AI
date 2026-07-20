---
name: mcbe-rp-basics
description: Use for onboarding and mental-model questions about Minecraft Bedrock resource packs — what a resource pack is, how it loads relative to behavior packs, how the game resolves files, and the overall folder map. Good first skill for beginners before diving into a specific file type.
---

# MCBE Resource Pack Basics

Read `../../docs/00-overview.md` and `../../docs/05-manifest-and-pack-structure.md`.

## Core mental model

- A **resource pack (RP)** controls everything the player *perceives*:
  textures, models, animations, sounds, particles, UI, fonts, and text.
- A **behavior pack (BP)** controls everything the game *does*: entity
  definitions, loot tables, recipes, scripts, spawn rules.
- RP and BP are paired by convention (matching names/UUID references in
  `manifest.json` dependencies) but are technically independent packs. A
  custom mob usually needs files in **both**: BP defines its behavior,
  RP defines how it looks/sounds.
- Bedrock resolves most RP content by **string path lookup**, not folder
  structure alone — e.g. a client entity file's `texture` field points at a
  short-name key defined in `textures/item_texture.json` or
  `textures/terrain_texture.json`, not directly at a PNG path, in most cases
  (there are exceptions — see `mcbe-rp-textures`).
- Nothing in an RP is "code" — there is no scripting inside a resource pack.
  Any conditional logic lives in Molang expressions inside animation
  controllers/particles, which is a limited expression language, not a
  general-purpose one.

## When the user is brand new

Walk through, in order:
1. What folder layout a minimal working RP needs (`manifest.json` + one
   real asset).
2. How to enable it (Global Resources vs. per-world in the Bedrock client).
3. The single most common beginner failure: format_version mismatches and
   mismatched UUIDs between `manifest.json`'s `header.uuid` and any BP
   dependency reference.

Then hand off to the specific topic skill for whatever they're building.
