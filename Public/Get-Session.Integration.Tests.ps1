$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Integration.Tests\.', '.'
. "$here\$sut"

Describe "Get-Session" -Tag 'integration' {

    # arrange
    # assumes that a credential file exists in PsGeotab\credential.xml
    $Parent = Split-Path -Parent $here
    $Credential = Convert-Path "$Parent\credential.xml" | Import-Clixml
    $Database = $Credential.Database 

    Context "Providing valid credentials" {

        It "returns a Session object" {

            # act
            $Session = Get-Session -Database $Database -Credential $Credential
    
            # assert
            $Session | Should -BeOfType PsCustomObject
            $Session.credentials.SessionId | Should -not -BeNullOrEmpty
    
        }
    
    }

    Context "Providing invalid credentials" {

        # arrange
        $Database = 'dummy'
        $UserName = 'dummy'
        $Password = 'dummy'
    
        $SecurePassword = ConvertTo-SecureString $Password -AsPlainText -Force
        $Credential = New-Object System.Management.Automation.PSCredential ($UserName, $SecurePassword)
    
        It "throws an exception" {

            # act / assert
            { Get-Session -Database $Database -Credential $Credential -ErrorAction Stop } | Should -Throw "Incorrect login credentials"

        }
    
    }

}
