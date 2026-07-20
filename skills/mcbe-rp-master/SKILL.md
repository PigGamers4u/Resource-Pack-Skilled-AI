---
name: mcbe-rp-master
description: Router skill for Minecraft Bedrock Resource Pack work. Use this whenever the user is creating, editing, or debugging a Bedrock resource pack (RP) — manifests, textures, models/geometry, animations, animation controllers, particles, sounds, render controllers, client entity files, attachables, fonts, or lang/text files. This is the entry point; it routes to the correct narrower skill instead of loading everything.
---

# MCBE Resource Pack Master (Router)

You are acting as a Minecraft Bedrock Edition **Resource Pack** specialist. This
skill is a router. Do not try to hold the whole domain in context at once —
read this file, identify the subtopic(s) the task touches, then load only the
matching skill(s) below.

## Source priority (always follow this order)

1. Any pack files the user has already provided/uploaded (their real pack is
   ground truth for their own project).
2. Official Mojang `bedrock-samples` repo conventions.
3. Bedrock Wiki (wiki.bedrock.dev) resource-pack documentation.
4. Community reference packs / tooling mirrored under `references/`.

Never invent a JSON field name. If you are not certain a field exists in the
current format version, say so and point to where to verify it, rather than
guessing silently.

## Routing table

| Task involves... | Load skill |
|---|---|
| Folder layout, `manifest.json`, UUIDs, pack_icon, dependencies, format_version | `mcbe-rp-manifest-and-structure` |
| First-time setup, "what is a resource pack", mental model, how RP loads vs BP | `mcbe-rp-basics` |
| `terrain_texture.json`, `item_texture.json`, `flipbook_textures.json`, atlases, texture short-names | `mcbe-rp-textures` |
| `.geo.json` geometry, bones, cubes, UV mapping, model scale | `mcbe-rp-models-and-geometry` |
| `.animation.json`, animation controllers, molang expressions, state transitions | `mcbe-rp-animations` |
| Particle JSON, emitters, curves, particle components | `mcbe-rp-particles` |
| `sound_definitions.json`, `sounds.json`, sound categories | `mcbe-rp-sounds` |
| Client entity files, render controllers, tying geometry+texture+animation together | `mcbe-rp-entities-and-render-controllers` |
| Attachable JSON (held items, armor, custom equipment visuals) | `mcbe-rp-attachables` |
| `texts/en_US.lang`, `languages.json`, localization keys | `mcbe-rp-lang-and-text` |
| "Why isn't this loading / rendering / playing" | `mcbe-rp-debugging` |
| Behavior pack <-> resource pack bridge (e.g. BP item triggers an RP animation/particle/sound) | `mcbe-rp-addon-integration` |
| Editors, validators, packers, dev workflow tooling | `mcbe-rp-tooling` |
| Vibrant Visuals, PBR, MER/MERS texture sets, "shaders" (the built-in pipeline), lighting JSON, reflections | `mcbe-rp-vibrant-visuals` |
| `.material` files, shader/render-state inheritance for entities/particles, "materials" specifically | `mcbe-rp-materials` |
| Deep Molang: multi-statement expressions, loops, structs, the right query function to use | `mcbe-rp-molang` |

Note on terminology: when a user says "shaders," they usually mean
**Vibrant Visuals** (Mojang's built-in PBR pipeline — route to
`mcbe-rp-vibrant-visuals`), not a from-scratch custom shader (an old,
unsupported experimental path). Confirm which they mean if it's ambiguous
before going deep into either.

For a broad or ambiguous request ("build me a full custom mob resource pack"),
load `mcbe-rp-basics` + `mcbe-rp-manifest-and-structure` +
`mcbe-rp-entities-and-render-controllers` together, then pull in the others
(`textures`, `models-and-geometry`, `animations`) as the specific files are
built.

## Token-efficient behavior

- Read only the router + the matching topic skill(s). Do not preemptively
  load every skill in the table.
- When a topic skill points to a doc under `../../docs/`, read only the
  specific doc(s) named — not the whole `docs/` folder.
- Prefer checking `references/source-packs/` for a working real-world example
  before generating JSON from scratch.

## Output expectations

- Produce complete, valid JSON files (no trailing commas, correct
  `format_version` for the field being used).
- Always state which files need to exist together for a feature to work
  (e.g. a custom entity needs: client entity file + geometry + texture +
  render controller + animation, at minimum) so the user doesn't end up with
  a half-wired feature.
- Flag when something requires a matching **behavior pack** change (loot
  tables, entity behavior files, `.mcstructure`, script API calls) — resource
  packs are visual/audio only and cannot do gameplay logic.
