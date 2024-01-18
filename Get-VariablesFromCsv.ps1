function Get-VariablesFromCsv {
    param (
        $listCsv
    )

    # Read the CSV file
    $listData = Import-Csv $listCsv

    # Create an array for the source files
    $srcFiles = @()

    # Create an array for the destination files
    $destFiles = @()

    # Loop for each row in the CSV file
    foreach ($row in $listData) {
        # Add the source file to the array
        $srcFiles += $row.src

        # Add the destination file to the array
        $destFiles += $row.dest
    }

    # Return the arrays
    return $srcFiles, $destFiles
}
