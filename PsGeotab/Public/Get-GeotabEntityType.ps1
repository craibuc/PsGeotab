<#
.SYNOPSIS
List of EntityType.

.DESCRIPTION
List of EntityType.

.INPUTS
None.

.OUTPUTS
String[].  Array of entity types.

.EXAMPLE
Get all devices.
PS> Get-GeotabEntityType

.LINK
https://developers.geotab.com/myGeotab/apiReference/objects/Entity
#>
function Get-GeotabEntityType {

    [CmdletBinding()]
    param ()
    
    @(
        'A1'
        'AddInData'
        'AnnotationLog'
        'Audit'
        'BinaryPayload'
        'Condition'
        'Controller'
        'CustomData'
        'CustomDevice'
        'DataDiagnostic'
        'DebugData'
        'Device'
        'DeviceShare'
        'DeviceStatusInfo'
        'Diagnostic'
        'DistributionList'
        'Driver'
        'DriverChange'
        'DutyStatusAvailability'
        'DutyStatusLog'
        'DutyStatusViolation'
        'DVIRLog'
        'ExceptionEvent'
        'FailureMode'
        'FaultData'
        'FillUp'
        'FlashCode'
        'FuelTaxDetail'
        'FuelUsed'
        'FuelTransaction'
        'Go4v3'
        'Go5'
        'Go6'
        'Go7'
        'Go8'
        'Go9'
        'Go9B'
        'GoCurve'
        'GoCurveAuxiliary'
        'GoDevice'
        'Group'
        'GroupSecurity'
        'IoxAddOn'
        'LogRecord'
        'MediaFile'
        'ParameterGroup'
        'Recipient'
        'RequestLocation'
        'Route'
        'RoutePlanItem'
        'Rule'
        'SecurityClearance'
        'ShipmentLog'
        'Source'
        'StatusData'
        'TachographDataFile'
        'TextMessage'
        'Trailer'
        'TrailerAttachment'
        'Trip'
        'UnitOfMeasure'
        'User'
        'WifiHotspot'
        'WorkHoliday'
        'WorkTime'
        'WorkTimeDetail'
        'Zone'
    )

}