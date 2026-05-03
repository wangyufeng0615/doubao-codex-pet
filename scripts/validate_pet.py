#!/usr/bin/env python3
"""Validate the distributable Doubao Codex pet package."""

from __future__ import annotations

import argparse
import json
from pathlib import Path

try:
    from PIL import Image
except ImportError as exc:  # pragma: no cover
    raise SystemExit("Pillow is required: python3 -m pip install pillow") from exc


ATLAS_SIZE = (1536, 1872)
CELL_SIZE = (192, 208)
EXPECTED_MANIFEST = {
    "id": "doubao",
    "displayName": "Doubao",
    "spritesheetPath": "spritesheet.webp",
}


def validate(root: Path) -> dict[str, object]:
    pet_dir = root / "pets" / "doubao"
    manifest_path = pet_dir / "pet.json"
    spritesheet_path = pet_dir / "spritesheet.webp"
    errors: list[str] = []

    if not manifest_path.is_file():
        errors.append(f"missing {manifest_path}")
        manifest = {}
    else:
        manifest = json.loads(manifest_path.read_text(encoding="utf-8"))
        for key, value in EXPECTED_MANIFEST.items():
            if manifest.get(key) != value:
                errors.append(f"pet.json {key} expected {value!r}, got {manifest.get(key)!r}")
        if not manifest.get("description"):
            errors.append("pet.json description is required")

    if not spritesheet_path.is_file():
        errors.append(f"missing {spritesheet_path}")
    else:
        with Image.open(spritesheet_path) as image:
            if image.size != ATLAS_SIZE:
                errors.append(f"spritesheet size expected {ATLAS_SIZE}, got {image.size}")
            if image.format != "WEBP":
                errors.append(f"spritesheet format expected WEBP, got {image.format}")
            if image.width % CELL_SIZE[0] or image.height % CELL_SIZE[1]:
                errors.append("spritesheet is not divisible into 192x208 cells")

    return {
        "ok": not errors,
        "errors": errors,
        "pet": str(pet_dir),
        "manifest": str(manifest_path),
        "spritesheet": str(spritesheet_path),
    }


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--root", default=".", help="Repository root")
    args = parser.parse_args()
    result = validate(Path(args.root).resolve())
    print(json.dumps(result, indent=2))
    if not result["ok"]:
        raise SystemExit(1)


if __name__ == "__main__":
    main()
