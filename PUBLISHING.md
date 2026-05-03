# Publishing Checklist

This repo is prepared for a GitHub repository named:

```text
wangyufeng0615/doubao-codex-pet
```

## What Is Ready

- `pets/doubao/pet.json`
- `pets/doubao/spritesheet.webp`
- macOS/Linux installer: `install.sh`
- Windows installer: `install.ps1`
- optional Codex plugin marketplace entry: `.agents/plugins/marketplace.json`
- optional plugin wrapper: `plugins/doubao-pet/`
- validation script: `scripts/validate_pet.py`
- GitHub Actions validation workflow
- contact sheet and QA JSON under `docs/`

## Validate Locally

```sh
python3 -m pip install pillow
python3 scripts/validate_pet.py --root .
```

Test the installer without touching your real Codex home:

```sh
tmpdir="$(mktemp -d)"
CODEX_HOME="$tmpdir/codex-home" ./install.sh
find "$tmpdir/codex-home/pets/doubao" -maxdepth 1 -type f -print
rm -rf "$tmpdir"
```

## Publish With GitHub CLI

Create and push the public GitHub repository:

```sh
git init
git add .
git commit -m "Add Doubao Codex pet"
gh repo create wangyufeng0615/doubao-codex-pet --public --source=. --remote=origin --push
```

## User Install Commands After Publishing

macOS/Linux:

```sh
curl -fsSL https://raw.githubusercontent.com/wangyufeng0615/doubao-codex-pet/main/install.sh | sh
```

Windows PowerShell:

```powershell
iwr https://raw.githubusercontent.com/wangyufeng0615/doubao-codex-pet/main/install.ps1 -UseB | iex
```

Codex prompt:

```text
Install the Codex pet from https://github.com/wangyufeng0615/doubao-codex-pet
```

Optional Codex plugin marketplace path:

```sh
codex plugin marketplace add wangyufeng0615/doubao-codex-pet
```

Then install the **Doubao Pet** plugin and ask:

```text
$doubao-pet install Doubao
```

## Official Basis

- Codex pets are selected/refreshed from the local Codex home in **Settings > Appearance > Pets**.
- Official custom pet creation points users to `$skill-installer hatch-pet`.
- Official skills documentation says skills are reusable workflow folders with `SKILL.md`, optional scripts, references, and assets.
- Official plugin documentation says plugins are the installable distribution unit for reusable skills/apps.
- Official CLI docs say `codex plugin marketplace add` accepts GitHub shorthand such as `owner/repo`.

## License

The repository is released under the MIT license, including code,
documentation, pet metadata, spritesheets, preview images, and the optional
Codex plugin wrapper.
