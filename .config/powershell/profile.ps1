Import-Module posh-git
Import-Module Terminal-Icons

Set-PSReadlineOption -BellStyle None
Set-PSReadLineOption -EditMode Emacs
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineKeyHandler -Key "Ctrl+f" -Function ForwardWord

$ScriptDir = $PSScriptRoot

oh-my-posh init pwsh --config $ScriptDir\PoshThemes\Paradox-Mod.omp.json | Invoke-Expression

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
