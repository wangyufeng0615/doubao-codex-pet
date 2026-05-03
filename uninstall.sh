#!/usr/bin/env sh
set -eu

PET_ID="${PET_ID:-doubao}"
CODEX_HOME="${CODEX_HOME:-$HOME/.codex}"
DEST_DIR="$CODEX_HOME/pets/$PET_ID"

if [ -d "$DEST_DIR" ]; then
  rm -rf "$DEST_DIR"
  echo "Removed $DEST_DIR"
else
  echo "Doubao pet is not installed at $DEST_DIR"
fi
