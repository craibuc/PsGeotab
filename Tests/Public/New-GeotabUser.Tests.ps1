# /PsGeotab
$ProjectDirectory = Split-Path -Path (Split-Path -Path $PSScriptRoot -Parent) -Parent

# /PsGeotab/PsGeotab/Public
$PublicPath = Join-Path $ProjectDirectory "/PsGeotab/Public/"

# /PsGeotab/Tests/Fixtures/
$FixturesDirectory = Join-Path $ProjectDirectory "/Tests/Fixtures/"

# New-GeotabDriver.psd1
$Settings = ((Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.') -replace '.ps1', '.psd1'

# New-GeotabDriver.ps1
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'

# . /PsGeotab/PsGeotab/Public/New-GeotabDriver.ps1
. (Join-Path $PublicPath $sut)


Describe "New-GeotabUser" -tag 'unit' {

    Context "Parameter validation" {

        BeforeAll {
            $Command = Get-Command 'New-GeotabUser'
        }

        $Parameters = @(
            @{Name='Session';Type='PsCustomObject';Mandatory=$true}
            @{Name='activeFrom';Type='datetime';Mandatory=$false}
            @{Name='activeTo';Type='datetime';Mandatory=$false}
            @{Name='comment';Type='string';Mandatory=$false}
            @{Name='countryCode';Type='string';Mandatory=$false}
            @{Name='driverGroups';Type='string[]';Mandatory=$false}
            @{Name='employeeNo';Type='string';Mandatory=$false}
            @{Name='firstName';Type='string';Mandatory=$false}
            @{Name='fuelEconomyUnit';Type='string';Mandatory=$false}
            @{Name='id';Type='string';Mandatory=$false}
            @{Name='isDriver';Type='boolean';Mandatory=$false}
            @{Name='isMetric';Type='boolean';Mandatory=$false}
            @{Name='keys';Type='string[]';Mandatory=$false}
            @{Name='lastName';Type='string';Mandatory=$false}
            @{Name='licenseNumber';Type='string';Mandatory=$false}
            @{Name='licenseProvince';Type='string';Mandatory=$false}
            @{Name='name';Type='string';Mandatory=$false}
            @{Name='password';Type='string';Mandatory=$false}
            @{Name='phoneNumber';Type='string';Mandatory=$false}
            @{Name='timeZoneId';Type='string';Mandatory=$false}
        )

        it '<Name> is a <Type>' -TestCases $Parameters {
            param($Name, $Type)
          
            $Command | Should -HaveParameter $Name -Type $type
        }

        it '<Name> mandatory is <Mandatory>' -TestCases $Parameters {
            param($Name, $Mandatory)
          
            if ($Mandatory) { $Command | Should -HaveParameter $Name -Mandatory }
            else { $Command | Should -HaveParameter $Name -Not -Mandatory }
        }

    }

    Context "Default" {
        BeforeEach {
            $Session = [pscustomobject]@{
                path = 'my41.geotab.com'
                sessionid = 'ABC-123-DEF-456'
            }

            $User = @{
                activeFrom = '7/1/2020'
                activeTo = '7/31/2020'
                comment = 'lorem ipsum'
                countryCode = 'us'
                driverGroups = 'b55','b66'
                employeeNo = 'FL1234'
                firstName = 'First'
                fuelEconomyUnit = "MPGUS"
                id='123456'
                isDriver = $false
                isMetric = $false
                keys = 'ABC','123'
                lastName = 'Last'
                licenseNumber = 'abc123def456ghi789'
                licenseProvince = 'MN'
                name = 'first.last@domain.tld'
                password = 'pa55w0rd'
                phoneNumber = '800-555-1212'
                timeZoneId = 'America/Chicago'
            }

            Mock Invoke-WebRequest {
                $Fixture = 'New-GeotabUser.json'
                $Content = Get-Content (Join-Path $FixturesDirectory $Fixture) -Raw

                $Response = New-MockObject -Type  Microsoft.PowerShell.Commands.BasicHtmlWebResponseObject
                $Response | Add-Member -Type NoteProperty -Name 'Content' -Value $Content -Force
                $Response
            }
        }

        It "created the expected request and returns the expected response" {
            # arrange
            $Expected = [pscustomobject]$User.Clone()
            $Expected.activeFrom = ([datetime]$Expected.activeFrom).ToUniversalTime()
            $Expected.activeTo = ([datetime]$Expected.activeTo).ToUniversalTime()

            # act
            $Actual = New-GeotabUser -Session $Session @User
            
            # assert
            Assert-MockCalled Invoke-WebRequest -ParameterFilter {
                $Json = $Body | ConvertFrom-Json

                $Delta = Compare-Object -ReferenceObject @($Expected.PsObject.Properties) -DifferenceObject @($Json.params.entity.PsObject.Properties)
                # Write-Debug "Differences: $( $Delta.SideIndicator.Count )"

                $Method -eq 'Post' -and
                $Uri -eq ("https://{0}/apiv1" -f $Session.path) -and
                $Json.method -eq 'Add' -and
                $Json.params.typeName -eq 'User' -and
                $Delta.SideIndicator.Count -eq 0
            }

            $Actual | Should -BeOfType [string]
        }

    }

}