# Particles

## Minimal particle effect

```json
{
  "format_version": "1.10.0",
  "particle_effect": {
    "description": {
      "identifier": "my_pack:spark",
      "basic_render_parameters": {
        "material": "particles_alpha",
        "texture": "textures/particle/spark"
      }
    },
    "components": {
      "minecraft:emitter_rate_instant": { "num_particles": 10 },
      "minecraft:emitter_shape_point": { "offset": [0, 0, 0] },
      "minecraft:particle_lifetime_expression": { "max_lifetime": 1.0 },
      "minecraft:particle_motion_dynamic": {
        "linear_acceleration": [0, -1, 0]
      },
      "minecraft:particle_appearance_billboard": {
        "size": [0.1, 0.1],
        "facing_camera_mode": "camera",
        "uv": {
          "texture_width": 16,
          "texture_height": 16,
          "uv": [0, 0],
          "uv_size": [16, 16]
        }
      }
    }
  }
}
```

## Triggering

Particles are inert on their own. They're fired from:
- a BP entity event (`minecraft:spawn_particle_effect` component/event), or
- `dimension.spawnParticle(...)` in `@minecraft/server` script code, or
- an animation/animation-controller particle-effect keyframe.

## Common mistakes

- Texture path in `basic_render_parameters.texture` not matching an actual
  PNG under `textures/particle/`.
- Forgetting a fade-out curve, causing particles to disappear abruptly
  instead of fading.
- `material` mismatch (e.g. using an opaque material for something meant
  to be semi-transparent) causing harsh edges.
