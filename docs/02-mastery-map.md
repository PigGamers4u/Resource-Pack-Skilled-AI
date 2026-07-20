# Mastery Map

A rough dependency order for *learning* the resource pack format, useful
when explaining things to a beginner from scratch:

1. Manifest & folder structure (nothing works without a valid pack)
2. Textures (blocks/items) — simplest visual change, fastest feedback loop
3. Lang/text — second simplest, good for confirming identifiers wire up
4. Sounds — similarly simple event -> asset mapping
5. Geometry/models — needed before animation makes sense
6. Client entity files & render controllers — the wiring layer that ties
   texture + geometry + animation together for entities/items
7. Animations & animation controllers — motion, once the model exists
8. Particles — often the most fiddly, benefits from an existing working
   example to start from
9. Attachables — same wiring pattern as entities, scoped to items/armor
10. BP<->RP integration — once each RP piece works standalone, wire it to
    behavior-pack-driven events/scripts
