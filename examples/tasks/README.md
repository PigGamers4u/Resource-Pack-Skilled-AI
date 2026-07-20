# Task Templates

Longer, guided tasks -- pair a concrete objective with the right skill
flow, and expect the agent to inspect existing files, trace dependencies,
and patch the pack rather than just answer in prose.

## Task: "Add a custom mob end-to-end"
Skills: mcbe-rp-manifest-and-structure, mcbe-rp-models-and-geometry,
mcbe-rp-entities-and-render-controllers, mcbe-rp-animations,
mcbe-rp-sounds, mcbe-rp-addon-integration

Steps the agent should take:
1. Confirm the BP entity identifier already exists (or note it needs to).
2. Generate `.geo.json`, client entity file, render controller.
3. Generate idle/walk animations + a movement animation controller.
4. Wire a footstep/ambient sound.
5. List every file created and how they reference each other, so the user
   can sanity-check the wiring at a glance.

## Task: "Diagnose a broken pack"
Skills: mcbe-rp-debugging + whichever specific topic skill matches the
symptom (see the triage order in `docs/14-common-failure-modes.md`)

Steps the agent should take:
1. Ask for (or read) the manifest, the specific asset files involved, and
   the exact symptom.
2. Walk the wiring chain for that asset type end-to-end, checking each
   link (identifier match, path correctness, format_version-appropriate
   fields).
3. Report the single most likely break point first, with a concrete fix,
   rather than a long list of maybes.

## Task: "Merge two community packs without collisions"
Skills: mcbe-rp-manifest-and-structure, mcbe-rp-debugging

Steps the agent should take:
1. Diff both packs' `terrain_texture.json`/`item_texture.json` short-name
   keys and any shared client entity file identifiers for collisions.
2. Flag every collision explicitly instead of silently picking one.
3. Propose a merge order or renaming strategy based on which pack the
   user considers primary.
