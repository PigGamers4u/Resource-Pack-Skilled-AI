import { MolangVariableMap, system, world } from "@minecraft/server";

const WAKE_EFFECT = "waterwake:boat_wake";
const EMIT_INTERVAL_TICKS = 2;           // more frequent
const MIN_HORIZONTAL_SPEED = 0.04;

function spawnWake(boat, velocity) {
  const speed = Math.hypot(velocity.x, velocity.z);
  if (!boat.isInWater || speed < MIN_HORIZONTAL_SPEED) return;

  const forwardX = velocity.x / speed;
  const forwardZ = velocity.z / speed;
  const boatLoc = boat.location;

  for (const side of [-1, 1]) {
    const spawnLoc = {
      x: boatLoc.x - forwardX * 0.9 + (-forwardZ) * 0.45 * side,
      y: boatLoc.y + 0.25,
      z: boatLoc.z - forwardZ * 0.9 + forwardX * 0.45 * side
    };

    const vars = new MolangVariableMap();
    vars.setFloat("wake_x", -forwardX * (0.6 + speed * 2.8));
    vars.setFloat("wake_z", -forwardZ * (0.6 + speed * 2.8));
    // Default size for boat
    vars.setFloat("size_x", 0.28);
    vars.setFloat("size_y", 0.10);

    boat.dimension.spawnParticle(WAKE_EFFECT, spawnLoc, vars);
  }
}

system.runInterval(() => {
  for (const dimId of ["minecraft:overworld", "minecraft:nether", "minecraft:the_end"]) {
    const dim = world.getDimension(dimId);
    for (const boat of dim.getEntities({ families: ["boat"] })) {
      spawnWake(boat, boat.getVelocity());
    }
  }
}, EMIT_INTERVAL_TICKS);