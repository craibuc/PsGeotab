<#

.LINK
https://developers.geotab.com/myGeotab/apiReference/objects/User
#>
class User {
    [bool]$acceptedEULA
    [string]$activeDashboardReports
    [datetime]$activeFrom
    [datetime]$activeTo
    [string]$authorityAddress
    [string]$authorityName
    [string[]]$availableDashboardReports
    [string[]]$cannedResponseOptions
    [string]$carrierNumber
    [bool]$changePassword
    [string]$comment
    [string]$companyAddress
    [string[]]$companyGroups
    [string]$companyName
    [string]$countryCode
    [string]$dateFormat = 'MM/dd/yy HH:mm:ss'
    [ValidateSet(, 'Hybrid', 'Roadmap', 'Satellite', 'Terrain')]
    [string]$defaultGoogleMapStyle = 'Roadmap'
    [ValidateSet()]
    [object]$defaultHereMapStyle = 'Roadmap'
    [ValidateSet('GoogleMaps''HereMap''MapBox')]
    [string]$defaultMapEngine = 'MapBox'
    [ValidateSet('Cycle', 'MapBox', 'None', 'Satellite', 'Transport')]
    [string]$defaultOpenStreetMapStyle = 'MapBox'
    [string]$defaultPage
    [ValidateRange(0, 50)]
    [string]$designation
    [int]$driveGuideVersion
    [ValidateSet('KiloWhPer100Km', 'KiloWhPer100Miles', 'KmPerKiloWh', 'KmPerLitersE', 'LitersEPer100Km', 'MPGEImperial', 'MPGEUS', 'MilePerKiloWh', 'WhPerKm', 'WhPerMile')]
    [string]$electricEnergyEconomyUnit = 'LitersEPer100Km'
    [ValidateRange(0, 50)]
    [string]$employeeNo
    [object]$firstDayOfWeek = 'Sunday'
    [ValidateRange(0, 255)]
    [string]$firstName
    [ValidateSet('KmPerLiter', 'LitersPer100Km', 'MPGImperial', 'MPGUS')]
    [string]$fuelEconomyUnit = 'LitersPer100Km'
    [string]$hosRuleSet
    [string]$id
    [boolean]$isDriver
    [boolean]$isEULAAccepted
    [boolean]$isEmailReportEnabled = $true
    [boolean]$isExemptHOSEnabled
    [boolean]$isLabsEnabled
    [boolean]$isMetric = $true
    [boolean]$isNewsEnabled = $true
    [boolean]$isPersonalConveyanceEnabled
    [boolean]$isServiceUpdatesEnabled
    [boolean]$isYardMoveEnabled
    [string]$language = 'en'
    [ValidateRange(0, 255)]
    [string]$lastName
    [ValidateSet('highlightGroups', 'name', 'viewport')]
    [string[]]$mapViews
    [int]$maxPCDistancePerDay
    [ValidateRange(0, 255)]
    [string]$name
    [string]$password
    [ValidateRange(0, 20)]
    [string]$phoneNumber
    [ValidateRange(0, 5)]
    [string]$phoneNumberExtension
    [string[]]$privateUserGroups
    [string[]]$reportGroups
    [string[]]$securityGroups
    [boolean]$showClickOnceWarning
    [string]$timeZoneId = 'America/New_York'
    [int]$wifiEULA
    [ValidateSet('All', 'Default', 'None')]
    [string]$zoneDisplayMode = 'Default'
    [string]$version
}

<#

.LINK
https://developers.geotab.com/myGeotab/apiReference/objects/Driver
#>
class Driver : User {
    [string[]]$driverGroups
    [string[]]$keys
    [string]$licenseNumber
    [string]$licenseProvince
    [bool]$viewDriversOwnDataOnly
}
