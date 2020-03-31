$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'
. "$here\$sut"

Describe "ConvertTo-PlainText" -tag 'Unit' {

    # dummy password
    $Expected = 'Pa55w0rd'

    # create SecureString
    $SecureString = ConvertTo-SecureString $Expected -AsPlainText -Force

    # create a PsCredential
    $Credential = New-Object System.Management.Automation.PSCredential ("LoremIpsum", $SecureString)

    Context "SecureString provided by named parameter" {

        It "converts the value to 'plain' text" {
            # act
            $Actual = ConvertTo-PlainText -SecureString $Credential.Password

            # assert
            $Actual | Should -Be $Expected
        }
    }

    Context "SecureString supplied via pipeline" {
        It "converts the value to 'plain' text" {
            # act
            $Actual = $Credential.Password | ConvertTo-PlainText 

            # assert
            $Actual | Should -Be $Expected
        }
    }

    Context "SecureString supplied via pipeline by name" {        
        It "converts the value to 'plain' text" {
            # act
            $Actual = $Credential | ConvertTo-PlainText 

            # assert
            $Actual | Should -Be $Expected
        }
    }

}
