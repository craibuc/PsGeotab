BeforeAll {

    $ProjectDirectory = Split-Path -Path (Split-Path -Path $PSScriptRoot -Parent) -Parent

    $PublicPath = Join-Path $ProjectDirectory "/PsGeotab/Public/"

    $FixturesDirectory = Join-Path $ProjectDirectory "/Tests/Fixtures/"

    $SUT = (Split-Path -Leaf $PSCommandPath) -replace '\.Tests\.', '.'

    $Path = Join-Path $PublicPath $SUT

    . (Join-Path $PublicPath $SUT)

}

Describe "Remove-GeotabEntity" -Tag 'unit' {

    Context "Parameter validation" {

        BeforeAll {
            $Command = Get-Command 'Remove-GeotabEntity'
        }

        Context 'Session' {
            BeforeAll {
                $ParameterName = 'Session'
            }

            It "is a [PsCustomObject]" {
                $Command | Should -HaveParameter $ParameterName -Type PsCustomObject
            }
            It "is mandatory" {
                $Command | Should -HaveParameter $ParameterName -Mandatory
            }
        }

        Context 'typeName' {
            BeforeAll {
                $ParameterName = 'typeName'
            }

            It "is a [string]" {
                $Command | Should -HaveParameter $ParameterName -Type string
            }
            It "is mandatory" {
                $Command | Should -HaveParameter $ParameterName -Mandatory
            }
        }

        Context 'entity' {
            BeforeAll {
                $ParameterName = 'entity'
            }

            It "is a [object]" {
                $Command | Should -HaveParameter $ParameterName -Type object
            }
            It "is mandatory" {
                $Command | Should -HaveParameter $ParameterName -Mandatory
            }
        }

    } # /Content

    Context "when Session, typeName, and entity parameters are supplied" {

        BeforeAll {
            # arrange
            $Session = [PsCustomObject]@{
                path = 'servername'
                credentials = [PsCustomObject]@{
                    sessionId = 123456
                }
            }
            $typeName = 'User'
            
            $entity = @{
                id = 'b9'
                firstName = 'First'
                lastName = 'Last'
            }

            Mock Invoke-WebRequest {
                $Fixture = 'Remove-User.Response.json'
                $Content = Get-Content (Join-Path $FixturesDirectory $Fixture) -Raw

                $Response = New-MockObject -Type  Microsoft.PowerShell.Commands.BasicHtmlWebResponseObject
                $Response | Add-Member -Type NoteProperty -Name 'Content' -Value $Content -Force
                $Response
            }
        }

        BeforeEach {
            Remove-GeotabEntity -Session $Session -typeName $typeName -entity $entity
        }

        It "creates a POST request" {
            Should -Invoke Invoke-WebRequest -ParameterFilter {
                $Method -eq 'Post'
            }
        }

        It "to the correct Uri" {
            Should -Invoke Invoke-WebRequest -ParameterFilter {
                $Uri -eq "https://$($Session.path)/apiv1"
            }
        }

        It "using a ContentType of 'application/json'" {
            Should -Invoke Invoke-WebRequest -ParameterFilter {
                $ContentType -eq 'application/json'
            }
        }

        It "with the desired Body payload" {
            # assert
            Should -Invoke Invoke-WebRequest -ParameterFilter {
                $ParsedBody = ($Body | ConvertFrom-Json)
                $ParsedBody.method -eq 'Remove' -and
                $ParsedBody.params.typeName -eq $typeName -and
                $ParsedBody.params.entity.id -ne $null -and
                ( Compare-Object -ReferenceObject ([pscustomobject]$Entity) -DifferenceObject $ParsedBody.params.entity ).SideIndicator.Count -eq 0
            }
        }

    }

}