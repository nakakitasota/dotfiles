#Requires -RunAsAdministrator

$DOTPATH = $PSScriptRoot
$XDGPATH = Join-Path $PSScriptRoot .config
$EXCLUSIONS = [string[]](".DS_Store", ".config", ".git", ".gitmodules", ".gitignore", ".travis.yml")

function Install-Dotfiles {
    $CANDIDATES = Get-ChildItem -Path $DOTPATH -Filter .??*
    $DOTFILES = $CANDIDATES | Where-Object {$_.Name -notin $EXCLUSIONS}

    foreach ($f in $DOTFILES) {
        New-Item -ItemType SymbolicLink -Path $HOME -Value $($f.FullName) -Name $($f.Name) -Force
    }
}

function Install-XDG {
    $CANDIDATES = Get-ChildItem -Path $XDGPATH
    $XDGFILES = $CANDIDATES | Where-Object {$_.Name -notin $EXCLUSIONS}

    foreach ($f in $XDGFILES) {
        New-Item -ItemType SymbolicLink -Path $HOME\.config -Value $($f.FullName) -Name $($f.Name) -Force
    }
}

function Install-Etc {
    # Keyhac
    New-Item -ItemType SymbolicLink -Path $env:APPDATA\Keyhac -Value $DOTPATH\etc\windows\keyhac\config.py -Name config.py -Force

    # PowerShell
    New-Item -ItemType SymbolicLink -Path $env:USERPROFILE\Documents\PowerShell -Value $DOTPATH\etc\windows\powershell\Microsoft.PowerShell_profile.ps1 -Name Microsoft.PowerShell_profile.ps1 -Force

    # Windows Terminal
    New-Item -ItemType SymbolicLink -Path $env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState -Value $DOTPATH\etc\windows\windows-terminal\settings.json -Name settings.json -Force
}

Install-Dotfiles
Install-XDG
Install-Etc
