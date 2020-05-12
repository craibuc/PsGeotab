# /PsGeotab
$ProjectDirectory = Split-Path -Path (Split-Path -Path $PSScriptRoot -Parent) -Parent

# /PsGeotab/PsGeotab/Private
$PrivatePath = Join-Path $ProjectDirectory "/PsGeotab/Private/"

# /PsGeotab/Tests/Fixtures/
# $FixturesDirectory = Join-Path $ProjectDirectory "/Tests/Fixtures/"

# ConvertTo-PlainText.ps1
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'

# . /PsGeotab/PsGeotab/Private/ConvertTo-PlainText.ps1
. (Join-Path $PrivatePath $sut)

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
