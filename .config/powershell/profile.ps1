Import-Module posh-git
Import-Module Terminal-Icons

Set-PSReadlineOption -BellStyle None
Set-PSReadLineOption -EditMode Emacs
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineKeyHandler -Key "Ctrl+f" -Function ForwardWord

$env:EDITOR="nvim"

$env:FZF_DEFAULT_OPTS="--height 40% --reverse --border sharp --preview-window sharp"
Set-PsFzfOption -PSReadlineChordReverseHistory 'Ctrl+r'

$ScriptDir = $PSScriptRoot

oh-my-posh init pwsh --config $ScriptDir\PoshThemes\Paradox-Mod.omp.json | Invoke-Expression
mise activate pwsh | Out-String | Invoke-Expression

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

function Invoke-FuzzyGhq {
    $path = ghq list | fzf --prompt="Repository> "
    if ($LastExitCode -eq 0) {
        cd "$(ghq root)\$path"
    }
}

Set-PSReadLineKeyHandler -Chord 'Ctrl+g' -ScriptBlock {
    [Microsoft.PowerShell.PSConsoleReadLine]::RevertLine()
    [Microsoft.PowerShell.PSConsoleReadLine]::Insert("Invoke-FuzzyGhq")
    [Microsoft.PowerShell.PSConsoleReadLine]::AcceptLine()
}

Set-Alias open Invoke-Item
