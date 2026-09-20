# New Windows PC setup
# Run this PowerShell script as Administrator.
# It installs the apps from winget-new-pc.json, enables WSL, and opens Steam
# installation dialogs for the requested Steam games.

$ErrorActionPreference = "Continue"

Write-Host "== Enabling WSL =="
wsl --install --no-distribution

Write-Host "== Installing applications from winget =="
$JsonPath = Join-Path $PSScriptRoot "winget-new-pc.json"

winget source update
winget import `
    --import-file $JsonPath `
    --ignore-unavailable `
    --ignore-versions `
    --accept-package-agreements `
    --accept-source-agreements

Write-Host ""
Write-Host "== NVIDIA =="
Write-Host "WinGet does not reliably provide the current NVIDIA display driver itself."
Write-Host "Install/update the NVIDIA driver through the NVIDIA App / NVIDIA's driver package."

Write-Host ""
Write-Host "== Steam games =="
Write-Host "Steam must be installed and you must own the games. The following commands open"
Write-Host "Steam's install flow for each game:"
Write-Host "  PUBG           AppID 578080"
Write-Host "  Battlefield 6  AppID 2807960"
Write-Host "  Counter-Strike 2 AppID 730"
Write-Host "  Rust           AppID 252490"

# Give Steam a moment to register its URL protocol after installation.
Start-Sleep -Seconds 5

$games = @(
    @{ Name = "PUBG: BATTLEGROUNDS"; AppId = "578080" },
    @{ Name = "Battlefield 6";       AppId = "2807960" },
    @{ Name = "Counter-Strike 2";    AppId = "730" },
    @{ Name = "Rust";                AppId = "252490" }
)

foreach ($game in $games) {
    Write-Host "Opening Steam installer for $($game.Name)..."
    Start-Process "steam://install/$($game.AppId)"
    Start-Sleep -Seconds 2
}

Write-Host ""
Write-Host "Setup commands completed."
Write-Host "A reboot is recommended because WSL was enabled."
Pause
