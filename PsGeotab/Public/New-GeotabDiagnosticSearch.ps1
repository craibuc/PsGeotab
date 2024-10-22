<#
.SYNOPSIS
The object used to specify the arguments when searching for Diagnostic(s).

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

.LINK
https://developers.geotab.com/myGeotab/apiReference/objects/Engine.DiagnosticSearch

#>
function New-GeotabDiagnosticSearch {

    [CmdletBinding()]
    param (
        [Parameter(ValueFromPipelineByPropertyName)]
        [string]$code,

        [Parameter(ValueFromPipelineByPropertyName)]
        [ValidateSet('BrpFault','DataDiagnostic','GmcccFault','GoDiagnostic','GoFault','LegacyFault','None','ObdFault','ObdWwhFault','Pid','ProprietaryFault','Sid','SuspectParameter')]
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
