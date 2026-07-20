# Token-Efficient Routing

This skill suite is intentionally split into narrow topic skills instead
of one giant document, mirroring the pattern used by `mcbejsonuimasterAI`
for JSON UI specifically.

## Rules of thumb for the agent

- Read `skills/mcbe-rp-master/SKILL.md` first — it's the router, not the
  content.
- Load only the topic skill(s) the current task actually touches.
- Within a topic skill, read only the specific doc(s) it names under
  `docs/` — not the whole folder.
- Prefer an existing working example under `references/source-packs/`
  over generating a file from a blank mental template, when one exists.
- When a task spans multiple topics (e.g. "add a custom mob with a walk
  animation and a footstep sound"), load
  `mcbe-rp-manifest-and-structure` + `mcbe-rp-models-and-geometry` +
  `mcbe-rp-entities-and-render-controllers` + `mcbe-rp-animations` +
  `mcbe-rp-sounds` together up front rather than discovering the need for
  each one mid-task.
