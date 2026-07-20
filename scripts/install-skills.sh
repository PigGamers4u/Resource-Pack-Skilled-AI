#!/usr/bin/env bash
# Installs every skill folder under skills/ into Codex's user skills directory
# (~/.codex/skills). Also works as a base for Claude Code project skills --
# see the README for the Claude Code target path.
set -euo pipefail

SRC_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../skills" && pwd)"
DEST_DIR="${HOME}/.codex/skills"

mkdir -p "$DEST_DIR"

for skill in "$SRC_DIR"/*/; do
  name="$(basename "$skill")"
  echo "Installing $name -> $DEST_DIR/$name"
  rm -rf "${DEST_DIR:?}/${name}"
  cp -r "$skill" "$DEST_DIR/$name"
done

echo "Done. Installed to $DEST_DIR"
