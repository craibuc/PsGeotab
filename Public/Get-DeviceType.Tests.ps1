$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'
. "$here\$sut"

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
