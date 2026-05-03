#!/usr/bin/env python3
"""Install the bundled Doubao pet into the local Codex pets directory."""

from __future__ import annotations

import json
import os
import shutil
from pathlib import Path


def codex_home() -> Path:
    return Path(os.environ.get("CODEX_HOME") or "~/.codex").expanduser().resolve()


def main() -> None:
    skill_dir = Path(__file__).resolve().parents[1]
    source_dir = skill_dir / "assets" / "pets" / "doubao"
    target_dir = codex_home() / "pets" / "doubao"

    manifest = source_dir / "pet.json"
    spritesheet = source_dir / "spritesheet.webp"
    if not manifest.is_file() or not spritesheet.is_file():
        raise SystemExit(f"missing bundled pet files under {source_dir}")

    target_dir.mkdir(parents=True, exist_ok=True)
    shutil.copy2(manifest, target_dir / "pet.json")
    shutil.copy2(spritesheet, target_dir / "spritesheet.webp")

    print(
        json.dumps(
            {
                "ok": True,
                "pet_dir": str(target_dir),
                "manifest": str(target_dir / "pet.json"),
                "spritesheet": str(target_dir / "spritesheet.webp"),
            },
            indent=2,
        )
    )


if __name__ == "__main__":
    main()
