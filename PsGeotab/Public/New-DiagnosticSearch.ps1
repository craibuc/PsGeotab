<#
.SYNOPSIS
Create a DiagnosticSearch object.

.PARAMETER code
Search for a Diagnostic by the code number.

.PARAMETER diagnosticType
The DiagnosticType to search for in Diagnostics.

.PARAMETER name
Search for Diagnostics with this Name. Wildcard can be used by prepending/appending "%" to string. Example "%name%".

.PARAMETER sourceSearch
The SourceSearch Id to search for in Diagnostics. Available SourceSearch options are: Id

.PARAMETER id
Search for an entry based on the specific Id.

#>
function New-DiagnosticSearch {

    [CmdletBinding()]
    param (
        [Parameter(ValueFromPipelineByPropertyName)]
        [string]$code,

        [Parameter(ValueFromPipelineByPropertyName)]
        [ValidateSet('DataDiagnostic','GoDiagnostic','GoFault','LegacyFault','None','ObdFault','ObdWwhFault','Pid','ProprietaryFault','Sid','SuspectParameter')]
        [string]$diagnosticType,

        [Parameter(ValueFromPipelineByPropertyName)]
        [string]$name,

        [Parameter(ValueFromPipelineByPropertyName)]
        [string]$sourceSearchId,

        [Parameter(ValueFromPipelineByPropertyName)]
        [string]$id
    )

    begin {}
    process
    {
        $DiagnosticSearch = @{}

        if ($code) { $DiagnosticSearch['code'] = $code }
        if ($diagnosticType) { $DiagnosticSearch['diagnosticType'] = $diagnosticType }
        if ($name) { $DiagnosticSearch['name'] = $name }
        if ($sourceSearchId) { $DiagnosticSearch['sourceSearchId'] = $sourceSearchId }
        if ($id) { $DiagnosticSearch['id'] = $id }

        [pscustomobject]$DiagnosticSearch
    }
    end {}

}
