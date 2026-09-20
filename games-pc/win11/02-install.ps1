# Step 2/3 - Steam games.
# Run after 01-install.ps1, once Steam is open and you are logged in.
# You must own the games; each command opens Steam's install dialog.

$games = @(
    @{ Name = "PUBG: BATTLEGROUNDS"; AppId = "578080" },
    @{ Name = "Battlefield 6";       AppId = "2807960" },
    @{ Name = "Counter-Strike 2";    AppId = "730" },
    @{ Name = "Rust";                AppId = "252490" }
)

if (-not (Get-Process -Name steam -ErrorAction SilentlyContinue)) {
    Write-Host "Steam is not running. Open Steam and log in first." -ForegroundColor Yellow
    Pause
    exit 1
}

foreach ($game in $games) {
    Write-Host "Opening Steam installer for $($game.Name) (AppID $($game.AppId))..."
    Start-Process "steam://install/$($game.AppId)"
    Start-Sleep -Seconds 2
}

Write-Host ""
Write-Host "Step 2 completed. Confirm each install dialog in Steam."
Pause
