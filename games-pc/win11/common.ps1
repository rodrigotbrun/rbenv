# Shared helpers, dot-sourced by the numbered install scripts.

$script:StartMenuDirs = @(
    "$env:ProgramData\Microsoft\Windows\Start Menu\Programs",
    "$env:APPDATA\Microsoft\Windows\Start Menu\Programs"
)

function Get-StartMenuSnapshot {
    @{
        Lnk  = @(Get-ChildItem -Path $script:StartMenuDirs -Filter *.lnk -Recurse -ErrorAction SilentlyContinue |
            Select-Object -ExpandProperty FullName)
        Apps = @(Get-StartApps | Select-Object -ExpandProperty AppID)
    }
}

# Adds desktop shortcuts for everything that appeared since the snapshot was taken.
function Add-DesktopShortcuts {
    param([Parameter(Mandatory)] $Before)

    Write-Host ""
    Write-Host "== Adding desktop shortcuts =="
    $Desktop = [Environment]::GetFolderPath("CommonDesktopDirectory")
    $Skip = "uninstall|readme|release notes|documentation|help|license"
    $Shell = New-Object -ComObject WScript.Shell

    # Classic (Win32) apps: copy their new Start Menu shortcuts.
    Get-ChildItem -Path $script:StartMenuDirs -Filter *.lnk -Recurse -ErrorAction SilentlyContinue |
        Where-Object { $Before.Lnk -notcontains $_.FullName -and $_.BaseName -notmatch $Skip } |
        ForEach-Object {
            $dest = Join-Path $Desktop $_.Name
            if (-not (Test-Path $dest)) {
                Copy-Item -LiteralPath $_.FullName -Destination $dest
                Write-Host "  $($_.BaseName)"
            }
        }

    # Packaged (MSIX/Store) apps have no .lnk, so point a shortcut at shell:AppsFolder.
    Get-StartApps |
        Where-Object { $Before.Apps -notcontains $_.AppID -and $_.AppID -like "*!*" -and $_.Name -notmatch $Skip } |
        ForEach-Object {
            $dest = Join-Path $Desktop "$($_.Name).lnk"
            if (-not (Test-Path $dest)) {
                $lnk = $Shell.CreateShortcut($dest)
                $lnk.TargetPath = "explorer.exe"
                $lnk.Arguments = "shell:AppsFolder\$($_.AppID)"
                $lnk.Save()
                Write-Host "  $($_.Name)"
            }
        }
}

function Assert-Winget {
    if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
        Write-Host "winget not found. Run C:\Windows\Setup\Scripts\InstallWinget.ps1 first." -ForegroundColor Red
        Pause
        exit 1
    }
}

function Import-WingetFile {
    param([Parameter(Mandatory)] [string] $Path)

    winget source update
    winget import `
        --import-file $Path `
        --ignore-unavailable `
        --ignore-versions `
        --accept-package-agreements `
        --accept-source-agreements
}
