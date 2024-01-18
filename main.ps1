# Arguments
param (
    $listCsv
)

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

# Read the CSV file
$listData = Import-Csv $listCsv

# Assign values to variables
$srcFiles = $listData.src
$destFiles = $listData.dest

# Loop for each file
for ($i = 0; $i -lt $srcFiles.Count; $i++) {
    $srcFile = $srcFiles[$i]
    $destFile = $destFiles[$i]

    # Check if the file exists
    if (Test-Path $srcFile) {
        # Rename the file
        Rename-Item -Path $srcFile -NewName $destFile
        Write-Host "Renamed: $srcFile -> $destFile"
    }
    else {
        # Warn the user that the file doesn't exist
        Write-Host "WARNING: $srcFile does not exist"
    }    
}

Write-Host "Done."

exit 0
