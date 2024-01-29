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
    $newName = $newNames[$i]
    $destDir = $destDirs[$i]

    $renamedFile = ""

    # Check if $destDir is valid
    if ([string]::IsNullOrEmpty($destDir)) {
        # Make a renamed file path
        $renamedFile = Join-Path -Path (Split-Path -Path $srcFile -Parent) $newName
        
        # Check if $renamedFile is exists
        if (!(Test-Path $renamedFile)) {
            return 1
        }
    }
    else {
        # Make a renamed file path
        $renamedFile = Join-Path -Path $destDir -ChildPath $newName 

        # Check if $renamedFile is exists
        if (!(Test-Path $renamedFile)) {
            return 1
        }

        # Check if $srcFile is exists
        if (!(Test-Path $srcFile)) {
            return 1
        }
    }
}

return 0
