function Copy-FileWithRenaming {
    param (
        $srcFile,
        $newName,
        $destDir
    )
    # Check if the destination directory exists
    if (!(Test-Path $destDir)) {
        # Create the destination directory
        Write-Host "Create new directory: $destDir"
        New-Item -ItemType Directory -Path $destDir
    }

    # Get the destination file path including the new names
    $destFile = Join-Path -Path $destDir -ChildPath $newName
    # Rename the src file by copying it to the destination directory 
    Copy-Item -Path $srcFile -Destination $destFile
    # Printthe message
    Write-Host "Renamed by copying: $srcFile -> $destFile"
}