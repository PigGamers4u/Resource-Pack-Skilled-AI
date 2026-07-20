# Molang Query Reference (Categorized Shortlist)

The official query function list runs to several hundred entries
(learn.microsoft.com/minecraft/creator/reference/content/molangreference/
examples/molangconcepts/queryfunctions). Don't guess a query name from
memory — check that page (or its per-query subpage) for the exact name,
required arguments, and return semantics before shipping an expression
that depends on it. This doc groups the ones actually needed most often
so the router can pick a category fast; it is not exhaustive.

## Movement / physical state
`query.is_moving`, `query.is_on_ground`, `query.is_in_water`,
`query.is_in_lava`, `query.is_in_water_or_rain`, `query.is_swimming`,
`query.is_jumping`, `query.can_fly`, `query.can_walk`, `query.can_climb`,
`query.can_swim`, `query.ground_speed`, `query.modified_move_speed`,
`query.modified_distance_moved`, `query.is_sneaking`, `query.is_sprinting`

## Combat / health
`query.health`, `query.max_health`, `query.is_alive`, `query.hurt_time`,
`query.hurt_direction`, `query.is_critical`, `query.last_hit_by_player`,
`query.invulnerable_ticks`, `query.is_using_item`,
`query.item_in_use_duration`, `query.base_swing_duration`,
`query.modified_swing_duration`

## Mob-state / behavior flags
`query.is_baby`, `query.is_tamed`, `query.is_sitting`, `query.is_sleeping`,
`query.is_angry`, `query.is_sheared`, `query.is_saddled`,
`query.is_pregnant`, `query.is_riding`, `query.has_rider`,
`query.is_leashed`, `query.is_charged`, `query.is_ignited`,
`query.is_scared`, `query.is_stunned`, `query.is_dancing`,
`query.is_celebrating`

## Animation / timing
`query.anim_time`, `query.life_time`, `query.life_span`,
`query.frame_alpha`, `query.delta_time`, `query.death_ticks`,
`query.all_animations_finished`, `query.any_animation_finished`,
`query.key_frame_lerp_time`

## Equipment / items
`query.is_item_equipped`, `query.equipped_item_is_attachable`,
`query.cooldown_time`, `query.cooldown_time_remaining`,
`query.remaining_durability`, `query.max_durability`,
`query.armor_material_slot`, `query.armor_color_slot`,
`query.has_armor_slot`, `query.equipment_count`

## Entity properties / custom data
`query.property('namespace:my_property')` — the main bridge for reading a
BP-defined entity property from RP-side Molang; `query.has_property`,
`query.block_state`, `query.has_block_state` (renamed from
`block_property`/`has_block_property` post-1.20.10, unsupported entirely
from 1.20.50 on)

## Camera / rendering context
`query.is_first_person`, `query.is_in_ui`, `query.is_on_screen`,
`query.is_invisible`, `query.distance_from_camera`,
`query.camera_rotation`, `query.graphics_mode_is_any`

## World / environment
`query.position`, `query.position_delta`, `query.heightmap`,
`query.above_top_solid`, `query.day`, `query.moon_phase`,
`query.moon_brightness`, `query.noise` (Perlin noise sampling)

## Rendering-chain specific (render controllers)
`query.variant`, `query.mark_variant`, `query.bone_aabb`,
`query.bone_orientation_matrix`, `query.bone_origin`,
`query.get_locator_offset`

## Utility / meta
`query.all`, `query.any`, `query.in_range`, `query.approx_eq`,
`query.count`, `query.combine_entities`, `query.get_actor_info_id`,
`query.get_pack_setting`, `query.is_pack_setting_enabled`, `query.log`
(debug-logs a value to the content log — useful while developing an
expression, remove before shipping)

## Naming trap

Several near-duplicate query names both exist and are **not** aliases of
each other in all cases (e.g. `query.is_on_fire` and `query.is_onfire`
both exist) — always verify spelling against the official reference
rather than assuming based on a similar query elsewhere in the same pack.

## When a query doesn't exist for what's needed

If nothing in the query library exposes the value needed (a custom
gameplay flag, a computed number from behavior-pack logic), the standard
pattern is:
1. Expose it as a BP entity property, then read it via `query.property(...)`.
2. Or set an actor variable/flag from a script (`@minecraft/server`) or
   entity event, then read the corresponding query/variable from Molang.

See `mcbe-rp-addon-integration` (`docs/15-bp-rp-integration-bridge.md`)
for the full BP<->RP bridge pattern.
