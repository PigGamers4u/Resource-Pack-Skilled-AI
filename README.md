# MCBE Resource Pack Master AI

Portable Codex/Claude skills and reference docs for full Minecraft Bedrock
**Resource Pack** development — not just JSON UI, but the entire visual/
audio layer: manifest & pack structure, textures, geometry/models,
animations & animation controllers, particles, sounds, client entity files
& render controllers, attachables, lang/localization, debugging, and the
behavior-pack <-> resource-pack integration boundary.

Structured the same way as `mcbejsonuimasterAI`: install the skills once,
keep all reference material inside the repo, and let the agent route
itself to the right subtopic instead of loading everything every time.

## What this repository is for

Use it when you want Codex or Claude to work well on:

- `manifest.json` authoring, UUIDs, dependencies, format_version
- `terrain_texture.json` / `item_texture.json` / `flipbook_textures.json`
- `.geo.json` geometry (bones, cubes, UV, pivots)
- `.animation.json` and `.animation_controllers.json` (incl. Molang)
- particle effect JSON
- `sound_definitions.json` / `sounds.json`
- client entity files (`entity/*.entity.json`) and render controllers
- attachables (custom item/armor visuals)
- `texts/*.lang` localization
- "why isn't this loading/rendering/playing" debugging
- wiring `@minecraft/server` script/BP events to RP-side animations,
  particles, and sounds
- Vibrant Visuals / PBR ("shaders"): MER/MERS texture sets, lighting
  JSON, reflections
- `.material` files (shader/render-state inheritance for entities/particles)
- deep Molang: multi-statement expressions, loops, structs, and picking
  the right `query.*` function

## What is included

### Skills (`skills/`)

- `mcbe-rp-master` (router — start here)
- `mcbe-rp-basics`
- `mcbe-rp-manifest-and-structure`
- `mcbe-rp-textures`
- `mcbe-rp-models-and-geometry`
- `mcbe-rp-animations`
- `mcbe-rp-particles`
- `mcbe-rp-sounds`
- `mcbe-rp-entities-and-render-controllers`
- `mcbe-rp-attachables`
- `mcbe-rp-lang-and-text`
- `mcbe-rp-debugging`
- `mcbe-rp-addon-integration`
- `mcbe-rp-tooling`
- `mcbe-rp-vibrant-visuals` (PBR / "shaders" — texture sets, lighting JSON)
- `mcbe-rp-materials` (`.material` shader/render-state inheritance)
- `mcbe-rp-molang` (deep Molang: syntax, scopes, loops, query selection)

### Docs (`docs/`)

Numbered concept/reference docs each skill points to — source priority,
mastery map, and one deep-dive doc per topic (see `docs/03-skill-map.md`
for the full index).

### References (`references/`)

- `source-packs/` — drop your own real working packs here as examples
- `external/` — pointers to upstream sources (bedrock-samples, Bedrock
  Wiki, vanilla asset mirrors) — not bundled, kept light
- `schemas/` — JSON Schema files for editor validation, if you add them

### Examples (`examples/`)

- `prompts/` — copy-paste prompts
- `tasks/` — longer guided task templates (build a custom mob end-to-end,
  diagnose a broken pack, merge two packs without collisions)

### Scripts (`scripts/`)

- `install-skills.ps1` / `install-skills.sh` — install every skill into
  `~/.codex/skills/`
- `validate-resource-pack.sh` — basic structural sanity check for a pack
  (valid manifest JSON, unique UUIDs, expected folders)

## Quick start

### 1. Install the skills

macOS/Linux:
```
./scripts/install-skills.sh
```

Windows (PowerShell):
```
.\scripts\install-skills.ps1
```

This copies every directory under `skills/` into `~/.codex/skills/`
(`%USERPROFILE%\.codex\skills\` on Windows).

### 2. Using it with Claude Code / Claude

The `SKILL.md` format here is the same one Claude's skill system uses.
Copy the `skills/` folder into your project (or Claude Code's skills
directory) and the same routing works without any changes.

### 3. Optional: validate a pack

```
./scripts/validate-resource-pack.sh /path/to/my_pack
```

## How to use it with Codex

### Recommended default

Broad or ambiguous request:
```
Use mcbe-rp-master.
```

Brand new to Bedrock resource packs:
```
Use mcbe-rp-basics and mcbe-rp-master.
```

### Typical prompts

See `examples/prompts/README.md` for copy-paste examples covering a full
custom mob build, texture fixes, debugging, the BP/RP integration bridge,
and onboarding.

## Recommended reading order

1. `docs/00-overview.md`
2. `docs/01-source-catalog.md`
3. `docs/02-mastery-map.md`
4. `docs/03-skill-map.md`
5. `docs/05-manifest-and-pack-structure.md`

Then read topic docs as needed — see `skills/mcbe-rp-master/SKILL.md`'s
routing table.

## Is this enough to become a "Resource Pack Master AI" in one shot?

Pragmatically: it's a strong starting scaffold, the same way
`mcbejsonuimasterAI` was for JSON UI. What it gives you immediately:

- portable skills with clear routing
- a beginner-to-advanced mental model across every RP file type
- a documented BP<->RP integration boundary (the part most tutorials skip)
- a validator script and an install script for both Codex and Claude Code

What it doesn't magically guarantee:

- perfect answers for every future Bedrock format_version without updates
- runtime truth from schema files alone — always verify against a real
  working pack or `bedrock-samples` when in doubt
- correct behavior for a pack with hidden dependencies outside the files
  it has access to

The right claim: **this is a strong portable base for an MCBE Resource
Pack specialist agent**, structured so you can keep dropping in real
reference packs and expanding individual topic docs without the whole
thing collapsing into one unreadable file.
