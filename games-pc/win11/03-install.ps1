# Step 3/3 - Dev tooling: WSL, then Node, Docker, GitHub Desktop, PhpStorm, Cursor,
# Windows Terminal from winget-dev.json.
# Run this PowerShell script as Administrator.

$ErrorActionPreference = "Continue"
. (Join-Path $PSScriptRoot "common.ps1")
Assert-Winget

Write-Host "== Enabling WSL =="
wsl --install --no-distribution

Write-Host ""
Write-Host "== Installing dev applications from winget =="
$Before = Get-StartMenuSnapshot
Import-WingetFile (Join-Path $PSScriptRoot "winget-dev.json")
Add-DesktopShortcuts -Before $Before

Write-Host ""
Write-Host "Step 3 completed."
Write-Host "A reboot is required for WSL, and Docker Desktop needs it to start."
Pause
