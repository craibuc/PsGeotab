BeforeAll {

    # /PsGeotab
    $ProjectDirectory = Split-Path -Path (Split-Path -Path $PSScriptRoot -Parent) -Parent

    # /PsGeotab/PsGeotab/Public
    $PublicPath = Join-Path $ProjectDirectory "/PsGeotab/Public/"

    # Get-GeotabDeviceType.ps1
    $sut = (Split-Path -Leaf $PSCommandPath) -replace '\.Tests\.', '.'

    # . /PsGeotab/PsGeotab/Public/Get-GeotabDeviceType.ps1
    . (Join-Path $PublicPath $sut)

}

Describe "Get-GeotabDeviceType" {

    Context "No parameters supplied" {

        It "returns an array of PsCustomObjects" {
            # act
            $DeviceType = Get-GeotabDeviceType

            # assert
            $DeviceType.Count | Should -BeGreaterThan 0
        }
    }

}
