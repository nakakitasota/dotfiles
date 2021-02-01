Import-Module posh-git
Import-Module oh-my-posh
Import-Module Get-ChildItemColor

Set-PSReadlineOption -BellStyle None
Set-PSReadLineOption -EditMode Emacs
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineKeyHandler -Key "Ctrl+f" -Function ForwardWord

$ScriptDir = $PSScriptRoot

$ThemeSettings.MyThemesLocation = "${ScriptDir}\PoshThemes"
Set-Theme Paradox-Mod

function rmrf {
    <#
        .DESCRIPTION
        Deletes the specified file or directory.
        .PARAMETER target
        Target file or directory to be deleted.
        .NOTES
        This is an equivalent command of "rm -rf" in Unix-like systems.
        #>
    Param(
        [Parameter(Mandatory = $true)]
        [string]$Target
    )
    Remove-Item -Recurse -Force $Target
}

Set-Alias open Invoke-Item
