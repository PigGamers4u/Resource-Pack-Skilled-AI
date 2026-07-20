# Attachables

## Minimal attachable

```json
{
  "format_version": "1.10.0",
  "minecraft:attachable": {
    "description": {
      "identifier": "my_pack:my_item",
      "materials": { "default": "entity_alphatest_one_sided" },
      "textures": { "default": "textures/items/my_item_3d" },
      "geometry": { "default": "geometry.my_item" },
      "scripts": { "parent_setup": "variable.is_first_person" },
      "render_controllers": ["controller.render.item_default"]
    }
  }
}
```

- `description.identifier` matches the BP item's identifier exactly.
- Used for 3D held-item models, armor pieces, or any equipment visual
  beyond a flat icon.
- Follows the same map/render-controller wiring pattern as client entity
  files (see `mcbe-rp-entities-and-render-controllers`).

## Common mistakes

- Reusing mob bone-naming conventions when the attachable actually needs
  to align with player attachment bones — compare against a known-good
  reference attachable rather than guessing.
- Forgetting first/third-person visibility differences — some attachable
  setups intentionally show a different geometry/texture depending on
  camera perspective via scripted conditions.
