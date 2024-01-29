# Arguments
param (
    $listCsv
)

# Include other scripts
. $PSScriptRoot\..\src\Get-VariablesFromCsv.ps1

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
    $destDir = $destDirs[$i]

    # Make the parent directory of $srcFile
    New-Item -Path (Split-Path -Path $srcFile -Parent) -ItemType Directory -Force | Out-Null

    # Check if $srcFile is a folder
    if ((Split-Path -Path $srcFile -Leaf) -like "*folder*") {
        # Make a directory at the path $srcFile
        New-Item -Path $srcFile -ItemType Directory -Force | Out-Null
    }
    else {
        # Else make a file at the path $srcFile
        New-Item -Path $srcFile -ItemType File -Force | Out-Null
    }

    # Check if $destDir is valid
    if ([string]::IsNullOrEmpty($destDir)) {
        continue
    }
    # Make a directory at the path $destDir
    New-Item -Path $destDir -ItemType Directory -Force | Out-Null
}

exit 0
