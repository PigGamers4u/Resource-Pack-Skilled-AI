#!/usr/bin/env bash
# Basic structural sanity check for a Bedrock resource pack.
# Usage: ./validate-resource-pack.sh /path/to/pack
set -euo pipefail

PACK_DIR="${1:?Usage: validate-resource-pack.sh /path/to/pack}"
FAIL=0

check() {
  if [ ! -e "$1" ]; then
    echo "MISSING: $1"
    FAIL=1
  fi
}

echo "Validating pack at: $PACK_DIR"
check "$PACK_DIR/manifest.json"

if command -v python3 >/dev/null 2>&1; then
  python3 - "$PACK_DIR/manifest.json" << 'PYEOF'
import json, sys
path = sys.argv[1]
try:
    with open(path) as f:
        data = json.load(f)
except Exception as e:
    print(f"INVALID JSON in manifest.json: {e}")
    sys.exit(1)

header = data.get("header", {})
modules = data.get("modules", [])
uuids = [header.get("uuid")] + [m.get("uuid") for m in modules]
uuids = [u for u in uuids if u]
if len(uuids) != len(set(uuids)):
    print("DUPLICATE UUID detected between header and modules.")
    sys.exit(1)
if not header.get("uuid"):
    print("Missing header.uuid")
    sys.exit(1)
if not modules:
    print("No modules[] defined.")
    sys.exit(1)
print("manifest.json: OK")
PYEOF
fi

# Warn (don't fail) on commonly-expected but optional folders
for d in textures models animations animation_controllers particles \
         entity attachables render_controllers sounds texts; do
  if [ ! -d "$PACK_DIR/$d" ]; then
    echo "note: no $d/ folder (fine if this pack doesn't need one)"
  fi
done

if [ "$FAIL" -eq 0 ]; then
  echo "Basic structural checks passed."
else
  echo "Structural checks FAILED."
  exit 1
fi
