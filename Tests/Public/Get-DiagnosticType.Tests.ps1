# /PsGeotab
$ProjectDirectory = Split-Path -Path (Split-Path -Path $PSScriptRoot -Parent) -Parent

# /PsGeotab/PsGeotab/Public
$PublicPath = Join-Path $ProjectDirectory "/PsGeotab/Public/"

# /PsGeotab/Tests/Fixtures/
# $FixturesDirectory = Join-Path $ProjectDirectory "/Tests/Fixtures/"

# Get-DiagnosticType.ps1
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'

# . /PsGeotab/PsGeotab/Public/Get-DiagnosticType.ps1
. (Join-Path $PublicPath $sut)

Describe "Get-DiagnosticType" {

    Context "No parameters supplied" {

        It "returns an array of PsCustomObjects" {
            # act
            $DiagnosticType = Get-DiagnosticType

            # assert
            $DiagnosticType.Count | Should -BeGreaterThan 0
        }
    }

}
