# Overview

This repository is a portable skill/knowledge base for Minecraft Bedrock
**Resource Pack** (RP) development, built to install into an AI coding
agent's skill system (Codex, Claude Code, or any tool that reads
`SKILL.md` files) the same way `mcbejsonuimasterAI` does for JSON UI
specifically.

Scope here is the **whole resource pack**, not just JSON UI:
- pack structure & manifest
- textures (block/item/entity/flipbook)
- geometry/models
- animations & animation controllers
- particles
- sounds
- client entity files & render controllers
- attachables
- lang/localization
- debugging
- the BP<->RP integration boundary
- tooling

If the task is specifically JSON UI (HUD, forms, chest menus, title/
actionbar parsing), prefer a dedicated JSON UI skill suite if the user has
one installed — this repo's `mcbe-rp-*` skills intentionally don't
duplicate that depth.
