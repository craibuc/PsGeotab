<#
.SYNOPSIS
Get Geotab Entities such as a Device or User

.PARAMETER Session
Geotab Session Object

.PARAMETER typeName
Geotab Entity Type

.PARAMETER resultsLimit
limit the results to an integer

.PARAMETER search
Get Method search object

.NOTES
Returns the Entities based on the TypeName and Seach objects provided

.LINK
https://developers.geotab.com/myGeotab/apiReference/methods/Get

#>

function Get-GeotabEntity {

    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory)]
        [PsCustomObject]$Session,

        [Parameter(Mandatory)]
        [string]$typeName,

        [Parameter()]
        [int]$resultsLimit,

        [Parameter()]
        [object]$search
    )

    $Uri = "https://$($Session.path)/apiv1"
    Write-Debug "Uri: $Uri"
	
    # payload as JSON
    $Body = @{
        method = 'Get'
        params = @{ 
            credentials = $Session.credentials
            typeName = $typeName
        }
    }

    if ( $PsBoundParameters['resultsLimit'] ) {
        $Body['params'].Add('resultsLimit', $resultsLimit)
    }

    if ( $PsBoundParameters['search'] ) {
        $Body['params'].Add('search', $search)
    }

    Write-Debug ($Body | ConvertTo-Json -Depth 10)

    # POST
    $Content = ( Invoke-WebRequest -Uri $uri -Method Post -Body ($Body | ConvertTo-Json -Depth 10) -ContentType "application/json" ).Content | ConvertFrom-Json

    # returns PsCustomObject representation of object
    if ( $Content.result ) { $Content.result }
    # otherwise raise an exception
    # returns PsCustomObject representation of object
    if ( $Content.result ) { $Content.result }
    # otherwise raise an exception
    elseif ($Content.error) { Write-Error -Message $Content.error.message }

}
