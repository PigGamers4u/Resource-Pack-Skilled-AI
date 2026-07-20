# Ready-Made Prompts

Copy-paste examples for using this skill suite with Codex or Claude Code.

### Broad / full custom mob
```
Use mcbe-rp-master and build the resource-pack side of a custom mob:
client entity file, a simple two-cube geometry, a walk/idle animation
controller, and wiring for a footstep sound. The behavior pack identifier
is "myaddon:sparkling".
```

### Texture fix
```
Use mcbe-rp-textures and fix why my custom item's icon shows as a
purple-black checkerboard. Here's my item_texture.json and the BP item
file.
```

### Debugging
```
Use mcbe-rp-debugging and mcbe-rp-entities-and-render-controllers.
My custom mob loads with no errors but renders as an invisible entity.
Here are my client entity file and geo.json.
```

### BP/RP bridge
```
Use mcbe-rp-addon-integration. I have a @minecraft/server script that
gives a kit item, and I want it to also play a custom sound and spawn a
particle effect when the kit is claimed. Walk me through wiring both
sides.
```

### Vibrant Visuals / PBR ("shaders")
```
Use mcbe-rp-vibrant-visuals. I want my custom sword's blade to look like
polished steel with Vibrant Visuals enabled -- walk me through the
manifest capability and the texture set JSON I need.
```

### Custom materials
```
Use mcbe-rp-materials. I want a custom entity material that adds
fresnel-style rim lighting on top of the default alpha-test entity
material. What am I inheriting from, and what should I watch out for?
```

### Deep Molang / picking a query
```
Use mcbe-rp-molang. I need an animation controller state that only
transitions back to idle once the mob has been standing still for 2
full seconds -- help me write that expression and tell me which query
functions it needs.
```

### Onboarding
```
Use mcbe-rp-basics and mcbe-rp-manifest-and-structure. I've never made a
Bedrock resource pack before -- walk me through the minimum files needed
and how the game finds them.
```
