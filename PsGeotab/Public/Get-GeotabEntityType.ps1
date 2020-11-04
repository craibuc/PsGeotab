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
https://geotab.github.io/sdk/software/api/reference/#T:Geotab.Checkmate.ObjectModel.Entity
#>
function Get-GeotabEntityType {

    [CmdletBinding()]
    param ()
    
    @(
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
        'FlashCode'
        'FuelEvent'
        'FuelTaxDetail'
        'FuelTransaction'
        'Go4v3'
        'Go5'
        'Go6'
        'Go7'
        'Go8'
        'Go9'
        'GoCurve'
        'GoCurveAuxiliary'
        'GoDevice'
        'Group'
        'GroupSecurity'
        'IoxAddOn'
        'LogRecord'
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
        'TextMessage'
        'Trailer'
        'TrailerAttachment'
        'Trip'
        'UnitOfMeasure'
        'User'
        'WorkHoliday'
        'WorkTime'
        'WorkTimeDetail'
        'Zone'   
    )

}