# External References

Track (or shallow-clone/mirror) these upstream sources as needed:

- Mojang `bedrock-samples` — https://github.com/Mojang/bedrock-samples
  (official vanilla RP/BP, best source for current real-world JSON)
- Bedrock Wiki — https://wiki.bedrock.dev (community documentation,
  versioned by format_version)
- ZtechNetwork `MCBVanillaResourcePack` — vanilla texture path reference,
  useful when you need to confirm an exact vanilla asset path

Large mirrors are intentionally not committed to this repo (keep it light
and reproducible) — sync them locally with a script under `scripts/` if
you want an offline copy, the same way `mcbejsonuimasterAI` handles its
vanilla pack mirror.
