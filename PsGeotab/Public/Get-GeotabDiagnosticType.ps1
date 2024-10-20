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
PS> Get-GeotabDiagnosticType

.LINK
https://developers.geotab.com/myGeotab/apiReference/objects/DiagnosticType

#>
function Get-GeotabDiagnosticType {

    $csv = `
        @"
Name,Description
BrpFault,BRP Fault.
DataDiagnostic,Data Diagnostic.
GmcccFault,GMCCC Fault.
GoDiagnostic,Go Diagnostic.
GoFault,Go Device Fault.
LegacyFault,Legacy Proprietary Fault.
None,No diagnostic.
ObdFault,OBD-II (On-board Diagnostic) Fault.
ObdWwhFault,OBD-II (On-board Diagnostic) WWH Fault.
Pid,PID (Parameter Identifier).
ProprietaryFault,Proprietary Fault.
Sid,SID (Subsystem Identifier).
SuspectParameter,SPN (Suspect Parameter Number).
"@

    $csv | ConvertFrom-Csv
    
}
