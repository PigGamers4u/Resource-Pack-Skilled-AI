# Texture Pipeline

## terrain_texture.json (blocks)

```json
{
  "resource_pack_name": "my_pack",
  "texture_name": "atlas.terrain",
  "padding": 8,
  "num_mip_levels": 4,
  "texture_data": {
    "my_block_short_name": {
      "textures": "textures/blocks/my_block"
    }
  }
}
```

The block's BP definition references `my_block_short_name`, not the PNG
path directly.

## item_texture.json (items)

Same shape, `texture_data` keys referenced from the BP item's
`minecraft:icon` component.

```json
{
  "resource_pack_name": "my_pack",
  "texture_name": "atlas.items",
  "texture_data": {
    "my_item_short_name": {
      "textures": "textures/items/my_item"
    }
  }
}
```

## flipbook_textures.json (animated textures)

```json
[
  {
    "flipbook_texture": "textures/blocks/my_block",
    "atlas_tile": "my_block_short_name",
    "ticks_per_frame": 4,
    "frames": [0, 1, 2, 3]
  }
]
```

`atlas_tile` must match an existing key already declared in
`terrain_texture.json`/`item_texture.json` — the flipbook entry layers
animation on top of a texture that's already registered, it doesn't
register a new one by itself.

## Entity & attachable textures

Client entity files and attachables reference PNG paths **directly** in
`description.textures` (a map of short internal key -> path), with no
separate atlas JSON in between:

```json
"textures": {
  "default": "textures/entity/my_mob"
}
```

## UI/environment textures

Referenced directly by path from the relevant JSON UI or environment
config file — same direct-path pattern as entities.
