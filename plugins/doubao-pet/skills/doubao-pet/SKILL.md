---
name: "doubao-pet"
description: "Install, repair, or verify the bundled Doubao custom pet for the Codex app by copying pet.json and spritesheet.webp into the local Codex pets directory."
---

# Doubao Pet

Use this skill when the user wants to install or repair the Doubao custom pet in Codex.

## Workflow

1. Run the bundled installer:

```bash
python3 scripts/install_doubao_pet.py
```

2. Tell the user that the pet was installed to:

```text
${CODEX_HOME:-$HOME/.codex}/pets/doubao/
```

3. Ask them to open Codex, go to **Settings > Appearance > Pets**, refresh custom pets, and choose **Doubao**.

Do not regenerate or edit the bundled pet artwork unless the user explicitly asks to create a new version.
