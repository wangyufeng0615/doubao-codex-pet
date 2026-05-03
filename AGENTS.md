# Repository Guidance

This repository packages one Codex custom pet. Keep the published package small and installation-oriented.

- The canonical pet files are `pets/doubao/pet.json` and `pets/doubao/spritesheet.webp`.
- Do not commit generation workspaces such as `doubao-run/`, `generated_images/`, or backups.
- Keep installer behavior simple: copy or download the two pet files into `${CODEX_HOME:-$HOME/.codex}/pets/doubao/`.
- If changing the spritesheet, validate that it remains a 1536x1872 WebP atlas with 8 columns, 9 rows, and 192x208 cells.
- The optional plugin wrapper should reuse the same pet files and should not contain a divergent copy unless both copies are updated together.
