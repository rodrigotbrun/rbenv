# Step 1/3 - New Windows PC setup: general apps (browser, chat, media, launchers,
# Steam client, Riot Games...) from winget-apps.json.
# Run this PowerShell script as Administrator.
# Next: log in to Steam, then run 02-install.ps1. Dev tooling is in 03-install.ps1.

$ErrorActionPreference = "Continue"
. (Join-Path $PSScriptRoot "common.ps1")
Assert-Winget

Write-Host "== Installing applications from winget =="
$Before = Get-StartMenuSnapshot
Import-WingetFile (Join-Path $PSScriptRoot "winget-apps.json")
Add-DesktopShortcuts -Before $Before

Write-Host ""
Write-Host "== NVIDIA =="
Write-Host "WinGet does not reliably provide the current NVIDIA display driver itself."
Write-Host "Install/update the NVIDIA driver through the NVIDIA App / NVIDIA's driver package."

Write-Host ""
Write-Host "Step 1 completed."
Write-Host "Next: open Steam and log in, then run 02-install.ps1."
Pause
