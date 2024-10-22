<#
.SYNOPSIS
List of DeviceTypes.

.DESCRIPTION
List of DeviceTypes.

.INPUTS
None.

.OUTPUTS
System.Management.Automation.PsCustomObject[].  Array of device types.

.EXAMPLE
Get all devices.
PS> Get-GeotabDeviceType

.LINK
https://developers.geotab.com/myGeotab/apiReference/objects/DeviceType

#>
function Get-GeotabDeviceType {

    $csv = `
@"
CustomDevice,Custom (third-party) device
CustomVehicleDevice,Custom (third-party) automotive vehicle tracking device
GO2,GO Device
GO3,GO3 Tracking Device
GO4,GO4 Tracking Device
GO4v3,GO4v3 Tracking Device - like GO4 but with larger memory and some new functionality
GO5,GO5 Tracking Device
GO6,GO6 Tracking Device
GO7,GO7 Tracking Device
GO8,GO8 Tracking Device
GO9,GO9 Tracking Device
GoDriveDevice,GoDrive Mobile Device
None,Unknown device type
OldGeotab,GEOTAB unit (unsupported)
"@

    $csv | ConvertFrom-Csv
    
}
