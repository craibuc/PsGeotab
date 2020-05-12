$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'
. "$here\$sut"

Describe "New-DeviceSearch" -Tag 'unit' {

    $Expected = [pscustomobject]@{
        comments = '%comments%'
        deviceType = 'device type'
        fromDate = '03/01/2020 12:00:00'
        groups = '1,2,3'
        keywords = 'keywords'
        licensePlate = '%ABC123%'
        name = '%name%'
        serialNumber = 'ABCEDFGHIJKLMNOPQRSTUVWXYZ'
        toDate = '03/31/2020 23:59:59'
        vehicleIdentificationNumber = '0123456789'
        id = 'b1234'
    }

    it "creates the expected object" {
        # act
        $Actual = $Expected | New-DeviceSearch

        # assert
        $Actual.fromDate | Should -Be ([datetime]$Expected.fromDate).ToUniversalTime().ToString("o")
        $Actual.toDate | Should -Be ([datetime]$Expected.toDate).ToUniversalTime().ToString("o")
        $Actual.serialNumber | Should -Be $Expected.serialNumber
        $Actual.vehicleIdentificationNumber | Should -Be $Expected.vehicleIdentificationNumber
        $Actual.id | Should -Be $Expected.id
    }

}
