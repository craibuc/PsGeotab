# /PsGeotab
$ProjectDirectory = Split-Path -Path (Split-Path -Path $PSScriptRoot -Parent) -Parent

# /PsGeotab/PsGeotab/Public
$PublicPath = Join-Path $ProjectDirectory "/PsGeotab/Public/"

# /PsGeotab/Tests/Fixtures/
$FixturesDirectory = Join-Path $ProjectDirectory "/Tests/Fixtures/"

# New-DiagnosticSearch.ps1
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'

# . /PsGeotab/PsGeotab/Public/New-UserSearch.ps1
. (Join-Path $PublicPath $sut)

Describe "Get-User" -Tag 'unit' {

    Context "Parameter validation" {
        $Command = Get-Command 'Get-User'

        Context 'Session' {
            $ParameterName = 'Session'

            It "is a [PsCustomObject]" {
                $Command | Should -HaveParameter $ParameterName -Type PsCustomObject
            }
            It "is mandatory" {
                $Command | Should -HaveParameter $ParameterName -Mandatory
            }
        }
    }

    Context "Usage" {

        BeforeEach {
            # arrange
            $Session = [PsCustomObject]@{
                path = 'servername'
                credentials = [PsCustomObject]@{
                    sessionId = 123456
                }
            }

            Mock Invoke-WebRequest {
                $Fixture = 'Get-User.json'
                $Content = Get-Content (Join-Path $FixturesDirectory $Fixture) -Raw

                $Response = New-MockObject -Type  Microsoft.PowerShell.Commands.BasicHtmlWebResponseObject
                $Response | Add-Member -Type NoteProperty -Name 'Content' -Value $Content -Force
                $Response
            }

            # act
            $Actual = Get-User -Session $Session
        }

        it "creates the correct request" {
            # assert
            Assert-MockCalled Invoke-WebRequest -ParameterFilter {
                $X = $Body | ConvertFrom-Json

                $Uri -eq "https://$($Session.path)/apiv1" -and
                $Method -eq 'Post' -and
                $ContentType -eq 'application/json' -and
                $X.params.typeName -eq 'User'
            }

        }

    }

}
