# Arguments
param (
    $listCsv
)

# Include other scripts
. ..\src\Get-VariablesFromCsv.ps1

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

    $renamedFile = ""

    # Check if $destDir is valid
    if ([string]::IsNullOrEmpty($destDir)) {
        # Make a renamed file path
        $renamedFile = Join-Path -Path (Split-Path -Path $srcFile -Parent) $newName 
    }
    else {
        # Make a renamed file path
        $renamedFile = Join-Path -Path $destDir -ChildPath $newName 
    }
    
    # Run the same below process for $srcFile and $renamedFile
    foreach ($filePath in $srcFile, $renamedFile) {
        # Check if $filePath is exists
        if (!(Test-Path $filePath)) {
            continue
        }
        # Delete a file at the path $filePath
        Remove-Item -Path $filePath -Force -Recurse
    }
}

exit 0
