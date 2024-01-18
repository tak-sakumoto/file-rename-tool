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
$srcFiles, $destFiles = Get-VariablesFromCsv $listCsv

# Loop for each file
for ($i = 0; $i -lt $srcFiles.Count; $i++) {
    $srcFile = $srcFiles[$i]
    $destFile = $destFiles[$i]

    # Check if the file exists
    if (!(Test-Path $srcFile)) {
        # Warn the user that the file doesn't exist
        Write-Host "WARNING: $srcFile does not exist"
        continue
    }
    
    # Rename the file
    Rename-Item -Path $srcFile -NewName $destFile
    Write-Host "Renamed: $srcFile -> $destFile"
}

Write-Host "Done."

exit 0
