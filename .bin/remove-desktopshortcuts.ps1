$TARGET_PATH = @(
    "$env:USERPROFILE\Desktop",
    "$env:PUBLIC\Desktop"
)

filter Get-Shortcut()
{
    $shell  = new-object -comobject WScript.Shell
    return $shell.CreateShortcut($_)
}

foreach ( $p in $TARGET_PATH) {
    $shortcuts = Get-ChildItem $p | Where-Object { $_.Name -like "*.lnk" }
    $shortcuts | Get-Shortcut | Where-Object {
        if ((Get-Item $_.TargetPath) -isnot [System.IO.DirectoryInfo]) {
            Remove-Item -Path $_.FullName
            Write-Host "Deleted: $($_.FullName)"
        }
    }
}
