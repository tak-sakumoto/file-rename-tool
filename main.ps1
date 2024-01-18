# Arguments
param (
    $listCsv
)

# Include other scripts
. .\Get-VariablesFromCsv.ps1

# Check if the $listCsv parameter is empty
if ([string]::IsNullOrEmpty($listCsv)) {
    # Warn the user that the CSV file parameter is empty
    Write-Host "Error: CSV file parameter is empty"
    exit 1
}

# Check if the CSV file exists
if (!(Test-Path $listCsv)) {
    # Warn the user that the CSV file doesn't exist
    Write-Host "Error: $listCsv does not exist"
    exit 1
}

# Get the source and destination files
$srcFiles, $newNames, $destDirs = Get-VariablesFromCsv $listCsv

# Loop for each source file
for ($i = 0; $i -lt $srcFiles.Count; $i++) {
    $srcFile = $srcFiles[$i]
    $newName = $newNames[$i]
    $destDir = $destDirs[$i]

    # Check if the file exists
    if (!(Test-Path $srcFile)) {
        # Warn the user that the file doesn't exist
        Write-Host "WARNING: $srcFile does not exist"
        continue
    }

    # If the destination directory is not specified,
    # rename the file in the same directory
    if ([string]::IsNullOrEmpty($destDir)) {
        # Get the destination directory
        $destDir = Split-Path -Path (Get-Item -Path $srcFile) -Parent
        # Get only the file name
        $srcName = Split-Path -Path $srcFile -Leaf
        # Rename the file
        Rename-Item -Path $srcFile -NewName $newName
        # Print the message
        Write-Host "Renamed: $srcName -> $newName (at $destDir)"
    }

    # If the destination directory is specified,
    # copy the file with renaming to the destination directory
    else {
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
}

Write-Host "Done."

exit 0
