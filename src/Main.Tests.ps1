Describe "Main Script Tests" {
    Context "When the CSV file parameter is empty" {
        It "Should return an error" {
            . "$PSScriptRoot\Main.ps1" -listCsv ""
            $LASTEXITCODE | Should -Be 1
        }
    }

    Context "When the CSV file doesn't exist" {
        It "Should return an error" {
            . "$PSScriptRoot\Main.ps1" -listCsv "nonexistent.csv"
            $LASTEXITCODE | Should -Be 1
        }
    }

    Context 'When $listCsv is valid' {
        It 'Should exit with code 0' {
            # Arrange
            $listCsv = "$PSScriptRoot\..\test\list.csv"
            . "$PSScriptRoot\..\test\Remove-TestItemsFromList.ps1" -listCsv $listCsv
            . "$PSScriptRoot\..\test\New-TestItemsFromList.ps1" -listCsv $listCsv

            # Act
            . "$PSScriptRoot\Main.ps1"  -listCsv $listCsv

            # Assert
            $LASTEXITCODE | Should -Be 0
            . "$PSScriptRoot\..\test\Remove-TestItemsFromList.ps1" -listCsv $listCsv
        }

        It 'Should rename files' {
            # Arrange
            $listCsv = "$PSScriptRoot\..\test\list.csv"
            . "$PSScriptRoot\..\test\New-TestItemsFromList.ps1" -listCsv $listCsv

            # Act
            . "$PSScriptRoot\Main.ps1" -listCsv $listCsv

            # Assert
            . "$PSScriptRoot\..\test\Test-TestItemPathsFromList.ps1" -listCsv $listCsv
            $LASTEXITCODE | Should -Be 0
            . "$PSScriptRoot\..\test\Remove-TestItemsFromList.ps1" -listCsv $listCsv
        }
    }
}