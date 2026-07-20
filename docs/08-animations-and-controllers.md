# Animations & Animation Controllers

## `.animation.json`

```json
{
  "format_version": "1.10.0",
  "animations": {
    "animation.my_mob.walk": {
      "loop": true,
      "animation_length": 1.0,
      "bones": {
        "leg_left": {
          "rotation": {
            "0.0": [0, 0, 0],
            "0.5": [30, 0, 0],
            "1.0": [0, 0, 0]
          }
        }
      }
    }
  }
}
```

Keys under `bones` must match bone **names** in the geometry file exactly.

## `.animation_controllers.json`

```json
{
  "format_version": "1.10.0",
  "animation_controllers": {
    "controller.animation.my_mob.movement": {
      "initial_state": "idle",
      "states": {
        "idle": {
          "animations": ["idle"],
          "transitions": [
            { "walk": "query.is_moving" }
          ]
        },
        "walk": {
          "animations": ["walk"],
          "transitions": [
            { "idle": "!query.is_moving" }
          ]
        }
      }
    }
  }
}
```

## Wiring into the client entity file

```json
"description": {
  "animations": {
    "idle": "animation.my_mob.idle",
    "walk": "animation.my_mob.walk",
    "movement": "controller.animation.my_mob.movement"
  },
  "scripts": {
    "animate": ["movement"]
  }
}
```

Only entries listed in `scripts.animate` actually run — defining an
animation or controller and putting it in the `animations` map is not
enough by itself.

## Molang notes

- Common queries: `query.is_moving`, `query.is_on_ground`,
  `query.is_sneaking`, `query.health`, `query.ground_speed`.
- For BP-driven custom state, use an entity property
  (`query.property('namespace:my_flag')`) set from the behavior pack, or a
  vanilla actor flag depending on target version — verify the exact
  syntax against the user's format_version rather than assuming.
- Keep transition conditions for sibling states close to mutually
  exclusive, or the controller can flicker between two nearly-true states.
