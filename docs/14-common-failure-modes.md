# Common Failure Modes

Ordered by how often each one turns up in practice.

1. **Pack doesn't show up / won't apply**
   - Invalid JSON in `manifest.json` (trailing comma, missing bracket).
   - Duplicate UUID reused from another pack or a copy-pasted tutorial.
   - `format_version` incompatible with the target `min_engine_version`.

2. **Purple-black checkerboard texture**
   - Path typo, or texture short-name missing from
     `terrain_texture.json`/`item_texture.json`.
   - PNG not actually present at the referenced path.

3. **Entity renders as a default/missing box, or invisible**
   - Geometry `identifier` in `.geo.json` doesn't match the client entity
     file's `description.geometry` map value exactly.
   - `description.identifier` in the client entity file doesn't match the
     BP entity's identifier.

4. **Model visible but never animates**
   - Animation/controller present in `description.animations` but missing
     from `description.scripts.animate`.
   - Molang transition condition in the controller never evaluates true
     (e.g. referencing a BP flag/property that's never actually set).

5. **No sound**
   - Sound name used by the BP/animation was never added to
     `sound_definitions.json`.
   - Player has that sound `category` muted client-side (not a pack bug).

6. **No particles**
   - Nothing ever triggers the particle effect from the BP/script side.
   - Texture path inside the particle JSON is wrong.

7. **Works alone, breaks when combined with other packs (pack merge)**
   - Texture/short-name key collisions across packs silently override
     each other depending on pack stack order.
   - Two packs both defining fields for the same vanilla identifier
     (e.g. both touching `minecraft:zombie`'s client entity file) —
     only the higher-priority pack in the stack wins for each *file*, not
     each field, so partial merges don't happen automatically.

8. **Behavior changed, visuals didn't (or vice versa)**
   - Forgetting resource packs and behavior packs are independent —
     changing BP logic doesn't touch RP visuals and needs its own RP
     update, and the reverse.
