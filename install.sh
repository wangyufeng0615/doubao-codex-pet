#!/usr/bin/env sh
set -eu

PET_ID="${PET_ID:-doubao}"
CODEX_HOME="${CODEX_HOME:-$HOME/.codex}"
DEST_DIR="$CODEX_HOME/pets/$PET_ID"
RAW_BASE="${REPO_RAW_BASE:-https://raw.githubusercontent.com/wangyufeng0615/doubao-codex-pet/main}"

script_dir() {
  case "$0" in
    */*) cd "$(dirname "$0")" && pwd ;;
    *) pwd ;;
  esac
}

copy_local() {
  src_dir="$(script_dir)/pets/$PET_ID"
  if [ -f "$src_dir/pet.json" ] && [ -f "$src_dir/spritesheet.webp" ]; then
    mkdir -p "$DEST_DIR"
    cp "$src_dir/pet.json" "$DEST_DIR/pet.json"
    cp "$src_dir/spritesheet.webp" "$DEST_DIR/spritesheet.webp"
    return 0
  fi
  return 1
}

download_file() {
  url="$1"
  dest="$2"
  if command -v curl >/dev/null 2>&1; then
    curl -fsSL "$url" -o "$dest"
  elif command -v wget >/dev/null 2>&1; then
    wget -q "$url" -O "$dest"
  else
    echo "error: install requires curl or wget when not run from a local clone" >&2
    exit 1
  fi
}

download_remote() {
  tmp_dir="$(mktemp -d)"
  trap 'rm -rf "$tmp_dir"' EXIT INT TERM

  download_file "$RAW_BASE/pets/$PET_ID/pet.json" "$tmp_dir/pet.json"
  download_file "$RAW_BASE/pets/$PET_ID/spritesheet.webp" "$tmp_dir/spritesheet.webp"

  mkdir -p "$DEST_DIR"
  cp "$tmp_dir/pet.json" "$DEST_DIR/pet.json"
  cp "$tmp_dir/spritesheet.webp" "$DEST_DIR/spritesheet.webp"
}

if ! copy_local; then
  download_remote
fi

echo "Installed Doubao Codex pet to $DEST_DIR"
echo "Open Codex > Settings > Appearance > Pets, refresh custom pets, then choose Doubao."
