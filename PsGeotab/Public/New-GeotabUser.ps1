<#
.SYNOPSIS
Create a new Geotab User record.

.DESCRIPTION 
Create a new Geotab User record.

.PARAMETER acceptedEULA

.PARAMETER activeDashboardReports

.PARAMETER activeFrom

.PARAMETER activeTo

.PARAMETER authorityAddress

.PARAMETER authorityName

.PARAMETER availableDashboardReports

.PARAMETER cannedResponseOptions

.PARAMETER carrierNumber

.PARAMETER changePassword

.PARAMETER comment

.PARAMETER companyAddress

.PARAMETER companyGroups

.PARAMETER companyName

.PARAMETER countryCode

.PARAMETER dateFormat

.PARAMETER defaultGoogleMapStyle

.PARAMETER defaultHereMapStyle

.PARAMETER defaultMapEngine

.PARAMETER defaultOpenStreetMapStyle

.PARAMETER defaultPage

.PARAMETER designation

.PARAMETER driverGroups

.PARAMETER driveGuideVersion

.PARAMETER electricEnergyEconomyUnit

.PARAMETER employeeNo

.PARAMETER firstDayOfWeek

.PARAMETER firstName

.PARAMETER fuelEconomyUnit

.PARAMETER hosRuleSet

.PARAMETER isDriver

.PARAMETER isEULAAccepted

.PARAMETER isEmailReportEnabled

.PARAMETER isExemptHOSEnabled

.PARAMETER isLabsEnabled

.PARAMETER isMetric

.PARAMETER isNewsEnabled

.PARAMETER isPersonalConveyanceEnabled

.PARAMETER isServiceUpdatesEnabled

.PARAMETER isYardMoveEnabled

.PARAMETER keys

.PARAMETER language

.PARAMETER lastName

.PARAMETER licenseNumber

.PARAMETER licenseProvince

.PARAMETER mapViews

.PARAMETER maxPCDistancePerDay

.PARAMETER name

.PARAMETER password

.PARAMETER phoneNumber

.PARAMETER phoneNumberExtension

.PARAMETER privateUserGroups

.PARAMETER reportGroups

.PARAMETER securityGroups

.PARAMETER showClickOnceWarning

.PARAMETER timeZoneId

.PARAMETER version

.PARAMETER viewDriversOwnDataOnly

.PARAMETER wifiEULA

.PARAMETER zoneDisplayMode

.LINK
https://geotab.github.io/sdk/software/api/reference/#T:Geotab.Checkmate.ObjectModel.Driver

#>

function New-GeotabUser {

    [CmdletBinding()]
    param (
		[Parameter(ValueFromPipelineByPropertyName,Mandatory)]
		[PsCustomObject]$Session,
        # [number]$acceptedEULA,
        # [string]$activeDashboardReports,
        [Parameter(ValueFromPipelineByPropertyName)]
        [datetime]$activeFrom,
        [Parameter(ValueFromPipelineByPropertyName)]
        [datetime]$activeTo,
        # [string]$authorityAddress,
        # [string]$authorityName,
        # [string[]]$availableDashboardReports,
        # [string[]]$cannedResponseOptions,
        # [string]$carrierNumber,
        # [boolean]$changePassword,
        [Parameter(ValueFromPipelineByPropertyName)]
        [string]$comment,
        # [string]$companyAddress,
        # [string[]]$companyGroups,
        # [string]$companyName,
        [Parameter(ValueFromPipelineByPropertyName)]
        [string]$countryCode,
        # [string]$dateFormat,
        # [string]$defaultGoogleMapStyle,
        # [object]$defaultHereMapStyle,
        # [string]$defaultMapEngine,
        # [string]$defaultOpenStreetMapStyle,
        # [string]$defaultPage,
        # [string]$designation,
        [Parameter(ValueFromPipelineByPropertyName)]
        [string[]]$driverGroups,
        # [number]$driveGuideVersion,
        # [string]$electricEnergyEconomyUnit,
        [Parameter(ValueFromPipelineByPropertyName)]
        [string]$employeeNo,
        # [object]$firstDayOfWeek,
        [Parameter(ValueFromPipelineByPropertyName)]
        [string]$firstName,
        [Parameter(ValueFromPipelineByPropertyName)]
        [string]$fuelEconomyUnit,
        # [string]$hosRuleSet,
        [Parameter(ValueFromPipelineByPropertyName)]
        [string]$id,
        [Parameter(ValueFromPipelineByPropertyName)]
        [boolean]$isDriver,
        # [boolean]$isEULAAccepted,
        # [boolean]$isEmailReportEnabled,
        # [boolean]$isExemptHOSEnabled,
        # [boolean]$isLabsEnabled,
        [Parameter(ValueFromPipelineByPropertyName)]
        [boolean]$isMetric,
        # [boolean]$isNewsEnabled,
        # [boolean]$isPersonalConveyanceEnabled,
        # [boolean]$isServiceUpdatesEnabled,
        # [boolean]$isYardMoveEnabled,
        [Parameter(ValueFromPipelineByPropertyName)]
        [string[]]$keys,
        # [string]$language,
        [Parameter(ValueFromPipelineByPropertyName)]
        [string]$lastName,
        [Parameter(ValueFromPipelineByPropertyName)]
        [string]$licenseNumber,
        [Parameter(ValueFromPipelineByPropertyName)]
        [string]$licenseProvince,
        # [string[]]$mapViews,
        # [number]$maxPCDistancePerDay,
        [Parameter(ValueFromPipelineByPropertyName)]
        [string]$name,
        [Parameter(ValueFromPipelineByPropertyName)]
        [string]$password,
        [Parameter(ValueFromPipelineByPropertyName)]
        [string]$phoneNumber,
        # [string]$phoneNumberExtension,
        # [string[]]$privateUserGroups,
        # [string[]]$reportGroups,
        # [string[]]$securityGroups,
        # [boolean]$showClickOnceWarning,
        [Parameter(ValueFromPipelineByPropertyName)]
        [string]$timeZoneId
        # [boolean]$viewDriversOwnDataOnly,
        # [string]$version,
        # [number]$wifiEULA,
        # [string]$zoneDisplayMode
    )
    
    begin {
        Write-Debug "$($MyInvocation.MyCommand.Name)"

        $Uri = "https://$($Session.path)/apiv1"
        Write-Debug "Uri: $Uri"
    }
    
    process {

        # convert datetime values to UTC
        if ($activeFrom) { $PSBoundParameters['activeFrom'] = $activeFrom.ToUniversalTime().tostring("o") } # to UTC
        if ($activeTo) { $PSBoundParameters['activeTo'] = $activeTo.ToUniversalTime().tostring("o") } # to UTC
        # create an array of hashtables
        $driverGroups | ForEach-Object -Begin { $a=@() } -Process { $a+=@{id=$_} } -End { $PSBoundParameters['driverGroups']=$a }

        # make a copy of Dictionary
        $entity = @{} + $PSBoundParameters
        # remove the Session key
        $entity.Remove('Session')

        # payload as JSON
        $Body = @{
            method = 'Add'
            params = @{ 
                typeName = 'User'
                credentials = $Session.credentials
                entity = $entity
            }
        }

        Write-Debug ($Body | ConvertTo-Json -Depth 4)

        # POST
        $Content = ( Invoke-WebRequest -Uri $uri -Method Post -Body ($Body | ConvertTo-Json -Depth 4 ) -ContentType "application/json" ).Content | ConvertFrom-Json

        # returns PsCustomObject representation of object
        if ( $Content.result ) { $Content.result }

        # otherwise raise an exception
        elseif ($Content.error) { Write-Error -Message $Content.error.message }

    }
    
    end {}

}