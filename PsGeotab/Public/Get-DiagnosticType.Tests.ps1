$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'
. "$here\$sut"

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
