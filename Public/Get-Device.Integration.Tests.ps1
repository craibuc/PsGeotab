Import-Module ./PsGeotab -Force

$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Integration.Tests\.', '.'
. "$here\$sut"

Describe "Get-Device" -Tag 'integration' {

    # assumes that a credential file exists in PsGeotab\credential.xml
    $Parent = Split-Path -Parent $here
    $Credential = Convert-Path "$Parent\credential.xml" | Import-Clixml
    $Database = $Credential.Database 

    # arrange
    $Session = Get-Session -Database $Database -Credential $Credential
    
    Context "No parameters supplied" {

        It "returns an array of PsCustomObjects" {
            # act
            $Device = Get-Device -Session $Session

            # assert
            $Device.Count | Should -BeGreaterThan 0
        }
    
    }

    Context "`$Id supplied" {

        # arrange
        $Id = 'b57'

        It "returns a single device" {
            # act
            $Device = Get-Device -Session $Session -Id $Id

            # assert
            $Device.id | Should -Be $Id
        }
    }

    Context "`$Name supplied" {

        # arrange
        $Name = '100029'

        It "returns one or more devices with a matching name" {
            # act
            $Device = Get-Device -Session $Session -Name $Name

            # assert
            $Device | Select-Object -First 1 -ExpandProperty Name | Should -Be $Name

        }

    }

}
