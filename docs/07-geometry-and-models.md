# Geometry & Models

## Minimal `.geo.json`

```json
{
  "format_version": "1.16.0",
  "minecraft:geometry": [
    {
      "description": {
        "identifier": "geometry.my_mob",
        "texture_width": 64,
        "texture_height": 64,
        "visible_bounds_width": 2,
        "visible_bounds_height": 2.5,
        "visible_bounds_offset": [0, 0.75, 0]
      },
      "bones": [
        {
          "name": "body",
          "pivot": [0, 12, 0],
          "cubes": [
            { "origin": [-4, 12, -4], "size": [8, 8, 8], "uv": [0, 0] }
          ]
        },
        {
          "name": "head",
          "parent": "body",
          "pivot": [0, 20, 0],
          "cubes": [
            { "origin": [-4, 20, -4], "size": [8, 8, 8], "uv": [0, 16] }
          ]
        }
      ]
    }
  ]
}
```

## Notes

- `identifier` is what the client entity file's `description.geometry` map
  points at (e.g. `"default": "geometry.my_mob"`), always by exact string
  match including the `geometry.` prefix.
- `pivot` is the rotation origin for that bone — get this wrong and
  animations rotate around the wrong point (classic "the arm swings from
  the shoulder-and-a-half" bug).
- `parent` builds the hierarchy — a child bone inherits the parent's
  transform, so animating `body` moves `head` along with it unless `head`
  has its own opposing keyframes.
- `uv` + cube `size` must be consistent with `texture_width`/
  `texture_height`, or the texture will appear stretched/misaligned.
- Attachable geometries (held items, armor) generally follow the same
  format but are scoped/pivoted to match a player bone attachment point —
  compare against a known-good reference rather than guessing coordinates.
