#Requires -RunAsAdministrator

<#
.SYNOPSIS
Install Firefox configurations files to default profile directory

.PARAMETER Target
Specify the type of configuration file to install.
Allowed values: [All, user.js, userChrome.css, userContent.css]

.PARAMETER ProfileSearchPath
Specify the search path for the profile directory.
Allowed values: [Conventional, MSIX]

.PARAMETER InstallProfile
Specify the profile for the installation destination.
Allowed values: [Default, Interactive]
#>

Param(
    [Parameter(Mandatory)][ValidateSet("user.js", "userChrome.css", "userContent.css", "All")][string]$Target,
    [Parameter(Mandatory)][ValidateSet("Conventional", "MSIX")][string]$ProfileSearchPath,
    [Parameter(Mandatory)][ValidateSet("Default", "Interactive")][string]$InstallProfile
)
Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$ConfigPath = Join-Path -Path $PSScriptRoot -ChildPath "..\..\firefox" | Convert-Path
$ProfilePath = & {
    $searchPath = $(switch($ProfileSearchPath) {
        "Conventional" {"$Env:APPDATA\Mozilla\Firefox\Profiles" | Convert-Path}
        "MSIX" {"$Env:LOCALAPPDATA\Packages\Mozilla.Firefox_n80bbvh6b1yt2\LocalCache\Roaming\Mozilla\Firefox\Profiles" | Convert-Path}
    })
    $profiles = (Get-ChildItem -Path $searchPath -Directory)
    $profilePath = $(switch($InstallProfile) {
        "Default" {($profiles | Where-Object {$_.FullName -clike "*default-release"})[0].FullName}
        "Interactive" {
            $title = "$($profiles.Count) profiles found."
            $message = "Please select the profile for the installation destination:"
            $options = & {
                [System.Management.Automation.Host.ChoiceDescription[]]$o = @()
                for ($i = 0; $i -lt $profiles.Count; $i++) {
                    $o += New-Object System.Management.Automation.Host.ChoiceDescription("$($profiles[$i].Name)(&$($i))")
                }
                $o += New-Object System.Management.Automation.Host.ChoiceDescription("Suspend(&S)")
                return $o
            }
            $defaultChoice = $profiles.Count
            $result = $Host.UI.PromptForChoice($title, $message, $options, $defaultChoice)
            if ($result -eq $defaultChoice) { exit }
            return $profiles[$result].FullName
        }
    })
    return $profilePath
}
$ChromePath = Join-Path -Path $ProfilePath -ChildPath "chrome"

# Create chrome direcroty in profile if it doesn't exist
if (-not (Test-Path -Path $ChromePath)) {
    New-Item -ItemType Directory -Path $ChromePath
}

function New-UserJsLink {
    New-Item -ItemType SymbolicLink -Path $ProfilePath -Value (Join-Path -Path $ConfigPath -ChildPath "user.js") -Name "user.js" -Force
}

function New-UserChromeCssLink {
    New-Item -ItemType SymbolicLink -Path $ChromePath -Value (Join-Path -Path $ConfigPath -ChildPath "chrome\userChrome.css") -Name "userChrome.css" -Force
}

function New-UserContentCssLink {
    New-Item -ItemType HardLink -Path $ChromePath -Value (Join-Path -Path $ConfigPath -ChildPath "chrome\userContent.css") -Name "userContent.css" -Force
}

switch($Target) {
    "user.js" { New-UserJsLink }
    "userChrome.css" { New-UserChromeCssLink }
    "userContent.css" { New-UserContentCssLink }
    "All" {
        New-UserJsLink
        New-UserChromeCssLink
        New-UserContentCssLink
    }
}
