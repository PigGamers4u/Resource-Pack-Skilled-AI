# Client Entity Files & Render Controllers

## Minimal client entity file

```json
{
  "format_version": "1.16.0",
  "minecraft:client_entity": {
    "description": {
      "identifier": "my_pack:my_mob",
      "materials": { "default": "entity_alphatest" },
      "textures": { "default": "textures/entity/my_mob" },
      "geometry": { "default": "geometry.my_mob" },
      "animations": {
        "movement": "controller.animation.my_mob.movement"
      },
      "scripts": { "animate": ["movement"] },
      "render_controllers": ["controller.render.my_mob"]
    }
  }
}
```

`description.identifier` must exactly match the behavior pack entity's
identifier (namespace included) or the game will never associate this
visual definition with that entity.

## Minimal render controller

```json
{
  "format_version": "1.10.0",
  "render_controllers": {
    "controller.render.my_mob": {
      "geometry": "Geometry.default",
      "materials": [{ "*": "Material.default" }],
      "textures": ["Texture.default"]
    }
  }
}
```

`Geometry.default`/`Texture.default`/`Material.default` refer back to the
`default` keys in the client entity file's `geometry`/`textures`/
`materials` maps — this indirection is what lets a render controller
switch between texture/geometry *variants* via Molang (e.g. an array of
textures indexed by a variant property) without touching the client
entity file itself.

## The full wiring chain

`BP entity identifier` == `client entity description.identifier`
-> `geometry map` -> `.geo.json identifier`
-> `textures map` -> PNG path
-> `render_controllers array` -> render controller entries reference the
   same map keys
-> `animations map` + `scripts.animate` -> `.animation.json` /
   `.animation_controllers.json` identifiers

A break at any link renders as: default/missing box, invisible entity, or
an unanimated static model, depending on which link failed.
