# /PsGeotab
$ProjectDirectory = Split-Path -Path (Split-Path -Path $PSScriptRoot -Parent) -Parent

# /PsGeotab/PsGeotab/Public
$PublicPath = Join-Path $ProjectDirectory "/PsGeotab/Public/"

# /PsGeotab/Tests/Fixtures/
# $FixturesDirectory = Join-Path $ProjectDirectory "/Tests/Fixtures/"

# Get-DeviceType.ps1
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'

# . /PsGeotab/PsGeotab/Public/Get-DeviceType.ps1
. (Join-Path $PublicPath $sut)

Describe "Get-DeviceType" {

    Context "No parameters supplied" {

        It "returns an array of PsCustomObjects" {
            # act
            $DeviceType = Get-DeviceType

            # assert
            $DeviceType.Count | Should -BeGreaterThan 0
        }
    }

}
