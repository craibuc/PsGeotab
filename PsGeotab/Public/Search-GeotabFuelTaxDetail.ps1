<#
.SYNOPSIS

.PARAMETER DeviceSearch
The device search.  Use New-DeviceSearch to construct object.

.PARAMETER FromDate
The beginning of the time interval. The search will adjust it to the nearest hour on or before this time. For instance, 8:20 AM will become 8 AM.

.PARAMETER ToDate
The end of the time interval. The search will adjust it to the nearest hour on or after this time. For instance, 5:40 PM will become 6 PM.

.PARAMETER IncludeBoundaries
A value indicating whether to include any parts of boundary details that fall outside the time interval.

.PARAMETER IncludeHourlyData
A value indicating whether to include hourly data.

.PARAMETER Id
Search for an entry based on the specific Id.  NOT the deviceId.

.LINK
https://developers.geotab.com/myGeotab/apiReference/objects/FuelTaxDetailSearch

#>
function Search-GeotabFuelTaxDetail {

    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [PsCustomObject]$Session,

        [Parameter(ValueFromPipeline)]
        [PsCustomObject]$DeviceSearch,

        [Parameter()]
        [datetime]$FromDate, # = (Get-Date).Date.AddDays(-1),

        [Parameter()]
        [datetime]$ToDate, # = (Get-Date).Date.AddSeconds(-1),

        [Parameter()]
        [switch]$IncludeBoundaries,

        [Parameter()]
        [switch]$IncludeHourlyData,

        [Parameter()]
        [string]$Id
    )

    $Uri = "https://$($Session.path)/apiv1"
    Write-Debug "Uri: $Uri"

    # payload as JSON
    $Body = @{
        method = 'Get'
        params = @{ 
            typeName = 'FuelTaxDetail'
            credentials = $Session.credentials
            search = @{}
        }
    }

    if ($DeviceSearch) { $Body.params.search['deviceSearch'] = $DeviceSearch }
    if ($FromDate) { $Body.params.search['fromDate'] = $FromDate.ToUniversalTime().ToString("o") }
    if ($ToDate) { $Body.params.search['toDate'] = $ToDate.ToUniversalTime().ToString("o") }
    if ($IncludeBoundaries) { $Body.params.search['includeBoundaries'] = $true.ToString().ToLower() }
    if ($IncludeHourlyData) { $Body.params.search['includeHourlyData'] = $true.ToString().ToLower() }
    if ($id) { $Body.params.search['id'] = $Id }

    Write-Debug ( $Body | ConvertTo-Json )
    
    $Content = ( Invoke-WebRequest -Uri $uri -Method Post -Body ($Body | ConvertTo-Json -Depth 3 ) -ContentType "application/json" ).Content | ConvertFrom-Json

    # returns PsCustomObject representation of object
    if ( $Content.result ) { $Content.result }
    # otherwise raise an exception
    elseif ($Content.error) { Write-Error -Message $Content.error.message }

}
