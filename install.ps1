$ErrorActionPreference = "Stop"

$PetId = if ($env:PET_ID) { $env:PET_ID } else { "doubao" }
$CodexHome = if ($env:CODEX_HOME) { $env:CODEX_HOME } else { Join-Path $HOME ".codex" }
$DestDir = Join-Path (Join-Path $CodexHome "pets") $PetId
$RawBase = if ($env:REPO_RAW_BASE) { $env:REPO_RAW_BASE } else { "https://raw.githubusercontent.com/wangyufeng0615/doubao-codex-pet/main" }

function Copy-LocalPet {
    if ($PSScriptRoot) {
        $SrcDir = Join-Path (Join-Path $PSScriptRoot "pets") $PetId
        $PetJson = Join-Path $SrcDir "pet.json"
        $Sprite = Join-Path $SrcDir "spritesheet.webp"
        if ((Test-Path $PetJson) -and (Test-Path $Sprite)) {
            New-Item -ItemType Directory -Force -Path $DestDir | Out-Null
            Copy-Item $PetJson (Join-Path $DestDir "pet.json") -Force
            Copy-Item $Sprite (Join-Path $DestDir "spritesheet.webp") -Force
            return $true
        }
    }
    return $false
}

function Download-RemotePet {
    New-Item -ItemType Directory -Force -Path $DestDir | Out-Null
    Invoke-WebRequest "$RawBase/pets/$PetId/pet.json" -OutFile (Join-Path $DestDir "pet.json")
    Invoke-WebRequest "$RawBase/pets/$PetId/spritesheet.webp" -OutFile (Join-Path $DestDir "spritesheet.webp")
}

if (-not (Copy-LocalPet)) {
    Download-RemotePet
}

Write-Host "Installed Doubao Codex pet to $DestDir"
Write-Host "Open Codex > Settings > Appearance > Pets, refresh custom pets, then choose Doubao."
