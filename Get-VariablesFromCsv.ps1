function Get-VariablesFromCsv {
    param (
        $listCsv
    )

    # Read the CSV file
    $listData = Import-Csv $listCsv

    # Create an array for the source files
    $srcFiles = @()
    # Create an array for the new names
    $newNames = @()
    # Create an array for the destination directories
    $destDirs = @()

    # Loop for each row in the CSV file
    foreach ($row in $listData) {
        # Add the source file to the array
        $srcFiles += $row.src
        # Add the new name to the array
        $newNames += $row.new_name
        # Add the destination directory to the array
        $destDirs += $row.dest
    }

    # Return the arrays
    return $srcFiles, $newNames, $destDirs
}
