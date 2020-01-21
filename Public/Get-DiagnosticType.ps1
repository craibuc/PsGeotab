<#
.SYNOPSIS
List of DiagnosticTypes.

.DESCRIPTION
List of DiagnosticTypes.

.INPUTS
None.

.OUTPUTS
System.Management.Automation.PsCustomObject[].  Array of diagnostic types.

.EXAMPLE
Get all devices.
PS> Get-DiagnosticType

.LINK
https://geotab.github.io/sdk/software/api/reference/#T:Geotab.Checkmate.ObjectModel.DiagnosticType

#>
function Get-DiagnosticType {

    $csv = `
@"
Name,Description
DataDiagnostic,Data Diagnostic
GoDiagnostic,Go Diagnostic
GoFault,Go Device Fault
LegacyFault,Legacy Proprietary Fault
None,No diagnostic
ObdFault,OBD (Onboard Diagnostic) Fault
ObdWwhFault,OBD (Onboard Diagnostic) WWH Fault
Pid,PID (Parameter Identifier)
ProprietaryFault,Proprietary Fault
Sid,SID (Subsystem Identifier)
SuspectParameter,SPN (Suspect Parameter Number)
"@

    $csv | ConvertFrom-Csv
    
}
