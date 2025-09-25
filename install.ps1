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

    # Vim
    New-Item -ItemType SymbolicLink -Path $HOME -Value (Join-Path -Path $env:USERPROFILE -ChildPath .vim\vimrc) -Name "_vimrc" -Force
    New-Item -ItemType SymbolicLink -Path $HOME -Value (Join-Path -Path $env:USERPROFILE -ChildPath .vim\gvimrc) -Name "_gvimrc" -Force
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

function Set-EnvironmentVariables {
    [Environment]::SetEnvironmentVariable("XDG_CONFIG_HOME", "${HOME}\.config", "User")
    [Environment]::SetEnvironmentVariable("XDG_CACHE_HOME", "${HOME}\.cache", "User")
    [Environment]::SetEnvironmentVariable("XDG_DATA_HOME", "${HOME}\.local\share", "User")
    [Environment]::SetEnvironmentVariable("XDG_STATE_HOME", "${HOME}\.local\state", "User")
    [Environment]::SetEnvironmentVariable("GIT_SSH", "C:\Windows\System32\OpenSSH\ssh.exe", "User")

    $currentPath = [Environment]::GetEnvironmentVariable('Path', 'User')
    $xdgDataPath = [Environment]::GetEnvironmentVariable('XDG_DATA_HOME', 'User')

    # Add path to mise shims
    $miseShimPath = "$xdgDataPath\mise\shims"
    if (-not ($currentPath.Contains($miseShimPath))) {
        $newPath = $currentPath + ";" + $miseShimPath
        [Environment]::SetEnvironmentVariable('Path', $newPath, 'User')
        Write-Host "Added"
    }
}

Install-Dotfiles
Install-XDG
Install-Etc
. (Join-Path -Path $PSScriptRoot -ChildPath "etc/windows/firefox/Install-FirefoxConfig.ps1") -ProfileSearchPath MSIX -Target All -InstallProfile Default
Set-EnvironmentVariables
