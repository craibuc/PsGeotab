<#
.SYNOPSIS
Create a DeviceSearch object.

.PARAMETER comment
Search for Devices with comments matching this value. Wildcard can be used by prepending/appending "%" to string. Example "%comments%".

.PARAMETER deviceType
Search for Devices of this DeviceType.

.PARAMETER fromDate
Search for Devices that were active at this date or after. Set to UTC now to search for only currently active (non-archived) devices.

.PARAMETER  groups
Search for Devices that are a member of these GroupSearch(s). Available GroupSearch options are:.

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
function New-DeviceSearch {

    [CmdletBinding()]
    param (
        [Parameter(ValueFromPipelineByPropertyName)]
        [string]$comment,

        [Parameter(ValueFromPipelineByPropertyName)]
        [string]$deviceType,

        [Parameter(ValueFromPipelineByPropertyName)]
        [datetime]$fromDate,

        [Parameter(ValueFromPipelineByPropertyName)]
        [string]$groups,

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

    $DeviceSearch = [pscustomobject]@{}

    if ($comment) { $DeviceSearch | Add-Member -MemberType NoteProperty -Name 'comment' -Value $comment }
    if ($deviceType) { $DeviceSearch | Add-Member -MemberType NoteProperty -Name 'deviceType' -Value $deviceType }
    if ($fromDate) { $DeviceSearch | Add-Member -MemberType NoteProperty -Name 'fromDate' -Value $fromDate.ToUniversalTime().ToString("o") }
    if ($groups) { $DeviceSearch | Add-Member -MemberType NoteProperty -Name 'groups' -Value $groups }
    if ($keywords) { $DeviceSearch | Add-Member -MemberType NoteProperty -Name 'keywords' -Value $keywords }
    if ($licensePlate) { $DeviceSearch | Add-Member -MemberType NoteProperty -Name 'licensePlate' -Value $licensePlate }
    if ($name) { $DeviceSearch | Add-Member -MemberType NoteProperty -Name 'name' -Value $name }
    if ($serialNumber) { $DeviceSearch | Add-Member -MemberType NoteProperty -Name 'serialNumber' -Value $serialNumber }
    if ($vehicleIdentificationNumber) { $DeviceSearch | Add-Member -MemberType NoteProperty -Name 'vehicleIdentificationNumber' -Value $vehicleIdentificationNumber }
    if ($toDate) { $DeviceSearch | Add-Member -MemberType NoteProperty -Name 'toDate' -Value $toDate.ToUniversalTime().ToString("o") }
    if ($id) { $DeviceSearch | Add-Member -MemberType NoteProperty -Name 'id' -Value $id }

    $DeviceSearch

}
