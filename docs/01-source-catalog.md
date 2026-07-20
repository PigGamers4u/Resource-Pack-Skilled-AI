# Source Catalog

Authoritative sources for verifying anything in this skill suite, in
priority order:

1. **The user's own pack files**, if provided — always ground truth for
   their specific project's format_version and existing conventions.
2. **Mojang `bedrock-samples`** (github.com/Mojang/bedrock-samples) —
   official vanilla RP/BP source, the single best way to check current
   field names and real working examples for any file type.
3. **Bedrock Wiki** (wiki.bedrock.dev) — actively maintained community
   documentation, generally accurate and versioned by format_version.
4. **Community reference packs** mirrored under `references/source-packs/`
   in this repo (add your own working packs here).
5. **Schema repositories** for editor validation, under
   `references/schemas/`.

Do not treat old blog posts, outdated tutorials, or memory of a single
past format_version as authoritative if it conflicts with the above.
