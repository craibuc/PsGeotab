BeforeAll {

    # /PsGeotab
    $ProjectDirectory = Split-Path -Path (Split-Path -Path $PSScriptRoot -Parent) -Parent

    # /PsGeotab/PsGeotab/Public
    $PublicPath = Join-Path $ProjectDirectory "/PsGeotab/Public/"

    # New-GeotabDeviceSearch.ps1
    $sut = (Split-Path -Leaf $PSCommandPath) -replace '\.Tests\.', '.'

    # . /PsGeotab/PsGeotab/Public/New-GeotabDeviceSearch.ps1
    . (Join-Path $PublicPath $sut)

}

Describe "New-GeotabDeviceSearch" -Tag 'unit' {

    BeforeAll {

        $Expected = [pscustomobject]@{
            comments = '%comments%'
            deviceType = 'device type'
            fromDate = '2024-03-01 12:00:00'
            groups = '1,2,3'
            keywords = 'keywords'
            licensePlate = '%ABC123%'
            name = '%name%'
            serialNumber = 'ABCEDFGHIJKLMNOPQRSTUVWXYZ'
            toDate = '2024-03-31 23:59:59'
            vehicleIdentificationNumber = '0123456789'
            id = 'b1234'
        }
        
    }

    it "creates the expected object" {
        # act
        $Actual = $Expected | New-GeotabDeviceSearch

        # assert
        $Actual.fromDate | Should -Be ([datetime]$Expected.fromDate).ToUniversalTime().ToString("o")
        $Actual.toDate | Should -Be ([datetime]$Expected.toDate).ToUniversalTime().ToString("o")
        $Actual.serialNumber | Should -Be $Expected.serialNumber
        $Actual.vehicleIdentificationNumber | Should -Be $Expected.vehicleIdentificationNumber
        $Actual.id | Should -Be $Expected.id
    }

}
