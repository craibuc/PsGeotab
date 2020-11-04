<#
.SYNOPSIS
The object used to specify the arguments when searching for a Device.

.PARAMETER comment
Search for Devices with comments matching this value. Wildcard can be used by prepending/appending "%" to string. Example "%comments%".

.PARAMETER deviceType
Search for Devices of this DeviceType.

.PARAMETER fromDate
Search for Devices that were active at this date or after. Set to UTC now to search for only currently active (non-archived) devices.

.PARAMETER  groupId
Search for Devices that are a member of these GroupSearch(s).

.PARAMETER keywords
Search for entities that contain specific keywords in all wildcard string-searchable fields.

.PARAMETER licensePlate
Search for Devices with a license plate matching this value. Wildcard can be used by prepending/appending "%" to string. Example "%comments%".

.PARAMETER name
Search for Devices with this Name. Name is the primary description of the Device. Wildcard can be used by prepending/appending "%" to string. Example "%name%".

.PARAMETER serialNumber
Search for a Device by its unique serial number.

.PARAMETER toDate
Search for Devices that were active at this date or before.

.PARAMETER vehicleIdentificationNumber
Search for a Device by Vehicle Identification Number (VIN). This is the unique number assigned to the vehicle during manufacturing.

.PARAMETER id
Search for an entry based on the specific Id.

.LINK
https://geotab.github.io/sdk/software/api/reference/#T:Geotab.Checkmate.ObjectModel.DeviceSearch

#>
function New-GeotabDeviceSearch {

    [CmdletBinding()]
    param (
        [Parameter(ValueFromPipelineByPropertyName)]
        [string]$comment,

        [Parameter(ValueFromPipelineByPropertyName)]
        [string]$deviceType,

        [Parameter(ValueFromPipelineByPropertyName)]
        [datetime]$fromDate,

        [Parameter(ValueFromPipelineByPropertyName)]
        [string]$groupId,

        [Parameter(ValueFromPipelineByPropertyName)]
        [string]$keywords,

        [Parameter(ValueFromPipelineByPropertyName)]
        [string]$licensePlate,

        [Parameter(ValueFromPipelineByPropertyName)]
        [string]$name,

        [Parameter(ValueFromPipelineByPropertyName)]
        [string]$serialNumber,

        [Parameter(ValueFromPipelineByPropertyName)]
        [datetime]$toDate,

        [Parameter(ValueFromPipelineByPropertyName)]
        [string]$vehicleIdentificationNumber,

        [Parameter(ValueFromPipelineByPropertyName)]
        [string]$id
    )

    begin {}

    process
    {
        $DeviceSearch = @{}

        if ($comment) { $DeviceSearch['comment'] = $comment }
        if ($deviceType) { $DeviceSearch['deviceType'] = $deviceType }
        if ($fromDate) { $DeviceSearch['fromDate'] = $fromDate.ToUniversalTime().ToString("o") }
        if ($groupId) { $DeviceSearch['groupId'] = $groupId }
        if ($keywords) { $DeviceSearch['keywords'] = $keywords }
        if ($licensePlate) { $DeviceSearch['licensePlate'] = $licensePlate }
        if ($name) { $DeviceSearch['name'] = $name }
        if ($serialNumber) { $DeviceSearch['serialNumber'] = $serialNumber }
        if ($vehicleIdentificationNumber) { $DeviceSearch['vehicleIdentificationNumber'] = $vehicleIdentificationNumber }
        if ($toDate) { $DeviceSearch['toDate'] = $toDate.ToUniversalTime().ToString("o") }
        if ($id) { $DeviceSearch['id'] = $id }
    
        [pscustomobject]$DeviceSearch

    }

    end {}

}
