# Arguments
param (
    $listCsv
)

# Include other scripts
. .\Get-VariablesFromCsv.ps1
. .\Rename-FileInSameDir.ps1
. .\Copy-FileWithRenaming.ps1

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
        Rename-FileInSameDir $srcFile $newName
    }

    # If the destination directory is specified,
    # copy the file with renaming to the destination directory
    else {
        Copy-FileWithRenaming $srcFile $newName $destDir
    }    
}

Write-Host "Done."

exit 0
