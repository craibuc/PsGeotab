BeforeAll {

    # /PsGeotab
    $ProjectDirectory = Split-Path -Path (Split-Path -Path $PSScriptRoot -Parent) -Parent

    # /PsGeotab/PsGeotab/Public
    $PublicPath = Join-Path $ProjectDirectory "/PsGeotab/Public/"

    # Get-GeotabDiagnosticType.ps1
    $sut = (Split-Path -Leaf $PSCommandPath) -replace '\.Tests\.', '.'

    # . /PsGeotab/PsGeotab/Public/Get-GeotabDiagnosticType.ps1
    . (Join-Path $PublicPath $sut)

}

Describe "Get-GeotabDiagnosticType" {

    Context "No parameters supplied" {

        It "returns an array of PsCustomObjects" {
            # act
            $DiagnosticType = Get-GeotabDiagnosticType

            # assert
            $DiagnosticType.Count | Should -BeGreaterThan 0
        }
    }

}
