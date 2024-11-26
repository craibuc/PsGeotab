BeforeAll {
    # /PsGeotab
    $ProjectDirectory = Split-Path -Path (Split-Path -Path $PSScriptRoot -Parent) -Parent

    # /PsGeotab/PsGeotab/Public
    $PublicPath = Join-Path $ProjectDirectory "/PsGeotab/Public/"

    # /PsGeotab/Tests/Fixtures/
    # $FixturesDirectory = Join-Path $ProjectDirectory "/Tests/Fixtures/"

    # Search-GeotabFuelTaxDetail.ps1
    $sut = (Split-Path -Leaf $PSCommandPath) -replace '\.Tests\.', '.'

    # . /PsGeotab/PsGeotab/Public/Search-GeotabFuelTaxDetail.ps1
    . (Join-Path $PublicPath $sut)
}

Describe "Search-GeotabFuelTaxDetail" {

    Context "Parameter validation" {

        it "has 1, mandatory parameters" {
            Get-Command "Search-GeotabFuelTaxDetail" | Should -HaveParameter "Session" -Type pscustomobject -Mandatory
        }

        it "has 3, optional parameters" {
            Get-Command "Search-GeotabFuelTaxDetail" | Should -HaveParameter "DeviceSearch" -Type pscustomobject
            Get-Command "Search-GeotabFuelTaxDetail" | Should -HaveParameter "FromDate" -Type datetime
            Get-Command "Search-GeotabFuelTaxDetail" | Should -HaveParameter "ToDate" -Type datetime
            Get-Command "Search-GeotabFuelTaxDetail" | Should -HaveParameter "IncludeBoundaries" -Type switch
            Get-Command "Search-GeotabFuelTaxDetail" | Should -HaveParameter "IncludeHourlyData" -Type switch
            Get-Command "Search-GeotabFuelTaxDetail" | Should -HaveParameter "Id" -Type string
        }

    } # /context
    BeforeAll {
        $Session = [PsCustomObject]@{
            path = 'my.geotab.com'
            credentials = [PsCustomObject]@{
                sessionId = 123456
            }
        }
    

        Mock Invoke-WebRequest {

            $Content = 
            @"
{
    "result": [
        {
            "device": {
                "id": "b65"
            },
            "driver": "UnknownDriverId",
            "jurisdiction": "MN",
            "enterTime": "2020-03-01T00:00:00.000Z",
            "enterOdometer": 142270.8,
            "enterGpsOdometer": 48172.202,
            "enterLatitude": 45.126359,
            "enterLongitude": -93.206443,
            "isEnterOdometerInterpolated": true,
            "exitTime": "2020-03-30T14:53:38.063Z",
            "exitOdometer": 143156.933,
            "exitGpsOdometer": 49062.861,
            "exitLatitude": 45.126297,
            "exitLongitude": -93.206474,
            "isExitOdometerInterpolated": false,
            "authority": "None",
            "isClusterOdometer": true,
            "hasHourlyData": false,
            "versions": [
                "000000000bda2bb2",
                "0000000012bf6105",
                "0000000000367166",
                "000000000000fd48"
            ],
            "isNegligible": false,
            "id": "bC736E"
        }
    ],
    "jsonrpc": "2.0"
}
"@
            $Response = New-MockObject -Type  Microsoft.PowerShell.Commands.BasicHtmlWebResponseObject
            $Response | Add-Member -Type NoteProperty -Name 'Content' -Value $Content -Force
            $Response
        }
    }

    Context "Response" {
    
        it "returns a FuelTaxDetail object" {
            # act 
            $Actual = Search-GeotabFuelTaxDetail -Session $Session

            $Actual | Should -BeOfType [PSCustomObject]
            $Actual.enterTime | Should -BeOfType [datetime]
            $Actual.exitTime | Should -BeOfType [datetime]
            $Actual.id | Should -BeOfType [string]
        }

    } # /context

    Context "-DeviceSearch" {

        BeforeAll {
            $PDirectory = Split-Path -Path (Split-Path -Path $PSScriptRoot -Parent) -Parent

            # /PsGeotab/PsGeotab/Public
            $MPath = Join-Path $PDirectory "\PsGeotab"

            Import-Module $MPath
        }

        it "creates correct request" {
            # arrange
            $DeviceSearch = New-GeotabDeviceSearch -Id 'b65' 

            # act 
            $DeviceSearch | Search-GeotabFuelTaxDetail -Session $Session

            # assert
            Assert-MockCalled Invoke-WebRequest -ParameterFilter {
                $X = $Body | ConvertFrom-Json

                $Uri -eq "https://$($Session.path)/apiv1" -and
                $Method -eq 'Post' -and
                $ContentType -eq 'application/json' -and
                $X.params.typeName -eq 'FuelTaxDetail' -and
                $X.params.search.deviceSearch.id -eq $DeviceSearch.id
            }
        }

    } # /context

    Context "-FromDate" {

        it "creates correct request" {
            # arrange
            $FromDate = (Get-Date).Date.AddDays(-1).ToUniversalTime()

            # act 
            Search-GeotabFuelTaxDetail -Session $Session -FromDate $FromDate
    
            # assert
            Assert-MockCalled Invoke-WebRequest -ParameterFilter {
                $X = $Body | ConvertFrom-Json

                $Uri -eq "https://$($Session.path)/apiv1" -and
                $Method -eq 'Post' -and
                $ContentType -eq 'application/json' -and
                $X.params.typeName -eq 'FuelTaxDetail' -and
                $X.params.search.fromDate -eq $FromDate
            }
        }

    } # /context

    Context "-ToDate" {

        it "creates correct request" {
            # arrange
            $ToDate = (Get-Date).Date.AddSeconds(-1).ToUniversalTime()
            
            # act 
            Search-GeotabFuelTaxDetail -Session $Session -ToDate $ToDate
   
            # assert
            Assert-MockCalled Invoke-WebRequest -ParameterFilter {
                $X = $Body | ConvertFrom-Json -Depth 10

                $Uri -eq "https://$($Session.path)/apiv1" -and
                $Method -eq 'Post' -and
                $ContentType -eq 'application/json' -and
                $X.params.typeName -eq 'FuelTaxDetail' -and
                $X.params.search.toDate -eq $ToDate
            }
        }

    } # /context

    Context "-IncludeBoundaries" {

        it "creates correct request" {    
            # act 
            Search-GeotabFuelTaxDetail -Session $Session -IncludeBoundaries

            # assert
            Assert-MockCalled Invoke-WebRequest -ParameterFilter {
                $X = $Body | ConvertFrom-Json

                $Uri -eq "https://$($Session.path)/apiv1" -and
                $Method -eq 'Post' -and
                $ContentType -eq 'application/json' -and
                $X.params.search.includeBoundaries -eq $true.ToString().ToLower()
            }
        }

    } # /context

    Context "-IncludeHourlyData" {

        it "creates correct request" {    
            # act 
            Search-GeotabFuelTaxDetail -Session $Session -IncludeHourlyData

            # assert
            Assert-MockCalled Invoke-WebRequest -ParameterFilter {
                $X = $Body | ConvertFrom-Json

                $Uri -eq "https://$($Session.path)/apiv1" -and
                $Method -eq 'Post' -and
                $ContentType -eq 'application/json' -and
                $X.params.search.includeHourlyData -eq $true.ToString().ToLower()
            }
        }

    } # /context

    Context "-Id" {

        it "creates correct request" {
            # arrange
            $Id = 'bC736E'

            # act 
            Search-GeotabFuelTaxDetail -Session $Session -Id $Id

            # assert
            Assert-MockCalled Invoke-WebRequest -ParameterFilter {
                $X = $Body | ConvertFrom-Json

                $Uri -eq "https://$($Session.path)/apiv1" -and
                $Method -eq 'Post' -and
                $ContentType -eq 'application/json' -and
                $X.params.search.id -eq $Id
            }
        }
    
    } # /context

}
