BeforeAll {

    # /PsGeotab
    $ProjectDirectory = Split-Path -Path (Split-Path -Path $PSScriptRoot -Parent) -Parent

    # /PsGeotab/PsGeotab/Public
    $PublicPath = Join-Path $ProjectDirectory "/PsGeotab/Public/"

    # /PsGeotab/Tests/Fixtures/
    $FixturesDirectory = Join-Path $ProjectDirectory "/Tests/Fixtures/"

    $SUT = (Split-Path -Leaf $PSCommandPath) -replace '\.Tests\.', '.'

    $Path = Join-Path $PublicPath $SUT
    Write-Host "Path: $Path"

    . (Join-Path $PublicPath $SUT)

}

Describe "Get-GeotabEntity" -Tag 'unit' {

    Context "Parameter validation" {

        BeforeAll {
            $Command = Get-Command 'Get-GeotabEntity'
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

        Context 'resultsLimit' {
            BeforeAll {
                $ParameterName = 'resultsLimit'
            }

            It "is a [int]" {
                $Command | Should -HaveParameter $ParameterName -Type int
            }
            It "is mandatory" {
                $Command | Should -HaveParameter $ParameterName -Not -Mandatory
            }
        }

        Context 'search' {
            BeforeAll {
                $ParameterName = 'search'
            }

            It "is a [object]" {
                $Command | Should -HaveParameter $ParameterName -Type object
            }
            It "is mandatory" {
                $Command | Should -HaveParameter $ParameterName -Not -Mandatory
            }
        }

    }

    Context "when Session and typeName parameters are supplied" {

        BeforeAll {
            # arrange
            $Session = [PsCustomObject]@{
                path = 'servername'
                credentials = [PsCustomObject]@{
                    sessionId = 123456
                }
            }
            $typeName = 'User'

            Mock Invoke-WebRequest {
                $Fixture = 'Get-User.Response.json'
                $Content = Get-Content (Join-Path $FixturesDirectory $Fixture) -Raw

                $Response = New-MockObject -Type  Microsoft.PowerShell.Commands.BasicHtmlWebResponseObject
                $Response | Add-Member -Type NoteProperty -Name 'Content' -Value $Content -Force
                $Response
            }
        }

        BeforeEach {
            Get-GeotabEntity -Session $Session -typeName $typeName
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

        It "using a content-type of 'application/json'" {
            Should -Invoke Invoke-WebRequest -ParameterFilter {
                $ContentType -eq 'application/json'
            }
        }

        It "settings the body's " {
            Should -Invoke Invoke-WebRequest -ParameterFilter {
                $ParsedBody = $Body | ConvertFrom-Json
                $ParsedBody.params.typeName -eq $typeName    
            }
        }

        Context "when the resultsLimit parameter is supplied" {

            BeforeEach {
                # arrange
                $resultLimit = 100

                # act
                Get-GeotabEntity -Session $Session -typeName $typeName -resultsLimit $resultLimit
            }
    
            It "sets the body.params.resultsLimit correctly" {
                # assert
                Should -Invoke Invoke-WebRequest -ParameterFilter {
                    $ParsedBody = ($Body | ConvertFrom-Json)
                    $ParsedBody.params.resultsLimit -eq $resultLimit
                }
            }
    
        } # /resultsLimit

        Context "when the search parameter is supplied" {

            BeforeEach {
                # arrange
                $search = @{ employeeNumber = 'ABC123' }

                # act
                Get-GeotabEntity -Session $Session -typeName $typeName -search $search
            }
    
            It "sets the body.params.search correctly" {
                # assert
                Should -Invoke Invoke-WebRequest -ParameterFilter {
                    $ParsedBody = ($Body | ConvertFrom-Json)

                    ( Compare-Object -ReferenceObject ([pscustomobject]$search) -DifferenceObject $ParsedBody.params.search ).SideIndicator.Count -eq 0
                }
            }
    
        } # /search

    }

}