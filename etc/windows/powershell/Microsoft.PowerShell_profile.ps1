$rc = "$env:XDG_CONFIG_HOME\powershell\profile.ps1"

if (Test-Path $rc) {
    . $rc
}
