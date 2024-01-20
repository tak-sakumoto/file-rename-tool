function Rename-FileInSameDir {
    param (
        $srcFile,
        $newName
    )
    # Get the destination directory
    $destDir = Split-Path -Path (Get-Item -Path $srcFile) -Parent
    # Get only the file name
    $srcName = Split-Path -Path $srcFile -Leaf
    # Rename the file
    Rename-Item -Path $srcFile -NewName $newName
    # Print the message
    Write-Host "Renamed: $srcName -> $newName (at $destDir)"
}