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
		[Parameter(Mandatory)]
		[PsCustomObject]$Session,
        # [number]$acceptedEULA,
        # [string]$activeDashboardReports,
        [Parameter()]
        [datetime]$activeFrom,
        [Parameter()]
        [datetime]$activeTo,
        # [string]$authorityAddress,
        # [string]$authorityName,
        # [string[]]$availableDashboardReports,
        # [string[]]$cannedResponseOptions,
        # [string]$carrierNumber,
        # [boolean]$changePassword,
        [Parameter()]
        [string]$comment,
        # [string]$companyAddress,
        # [string[]]$companyGroups,
        # [string]$companyName,
        [Parameter()]
        [string]$countryCode,
        # [string]$dateFormat,
        # [string]$defaultGoogleMapStyle,
        # [object]$defaultHereMapStyle,
        # [string]$defaultMapEngine,
        # [string]$defaultOpenStreetMapStyle,
        # [string]$defaultPage,
        # [string]$designation,
        [Parameter()]
        [string[]]$driverGroups,
        # [number]$driveGuideVersion,
        # [string]$electricEnergyEconomyUnit,
        [Parameter()]
        [string]$employeeNo,
        # [object]$firstDayOfWeek,
        [Parameter()]
        [string]$firstName,
        [Parameter()]
        [string]$fuelEconomyUnit,
        # [string]$hosRuleSet,
        # [Parameter()]
        # [string]$id,
        # [boolean]$isDriver,
        # [boolean]$isEULAAccepted,
        # [boolean]$isEmailReportEnabled,
        # [boolean]$isExemptHOSEnabled,
        # [boolean]$isLabsEnabled,
        [Parameter()]
        [boolean]$isMetric,
        # [boolean]$isNewsEnabled,
        # [boolean]$isPersonalConveyanceEnabled,
        # [boolean]$isServiceUpdatesEnabled,
        # [boolean]$isYardMoveEnabled,
        # [string[]]$keys,
        # [string]$language,
        [Parameter()]
        [string]$lastName,
        [Parameter()]
        [string]$licenseNumber,
        [Parameter()]
        [string]$licenseProvince,
        # [string[]]$mapViews,
        # [number]$maxPCDistancePerDay,
        [Parameter()]
        [string]$name,
        # [string]$password,
        [Parameter()]
        [string]$phoneNumber,
        # [string]$phoneNumberExtension,
        # [string[]]$privateUserGroups,
        # [string[]]$reportGroups,
        # [string[]]$securityGroups,
        # [boolean]$showClickOnceWarning,
        [Parameter()]
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