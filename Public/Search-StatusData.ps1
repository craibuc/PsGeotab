<#
.SYNOPSIS

.PARAMETER Session
Geotab session object.

.PARAMETER DeviceId
The device's id.

.PARAMETER FromDate
Include diagnostic measurements after this date/time.  Default: Today at 12:00:00

.PARAMETER ToDate
Include diagnostic measurements before this date/time.  Default: Today at 23:59:59

.PARAMETER DiagnosticId
The diagnostic measurement. Default: 'DiagnosticOdometerAdjustmentId'

.EXAMPLE
PS> Search-StatusData -Session $Session -DeviceId 'b57'

Get DiagnosticOdometerAdjustmentId diagnostics for device `b57` that occurred today.

.NOTES
When searching for status data including DeviceSearch and DiagnosticSearch the system will return all records that match the search criteria and interpolate the value at the provided from/to dates when there is no record that corresponds to the date. Interpolated records are dynamically created when the request is made and can be identified as not having the ID property populated. Records with an ID are stored in the database.

.LINK
https://geotab.github.io/sdk/software/api/reference/#T:Geotab.Checkmate.ObjectModel.Engine.StatusDataSearch

#>
function Search-StatusData {

    [CmdletBinding()]
    param(
		[Parameter(Mandatory=$true, ValueFromPipeline=$true)]
        [PsCustomObject]$Session,

        [Parameter(ValueFromPipelineByPropertyName,ValueFromPipeline)]
        [Alias('id')]
        [string]$DeviceId,
    
        [Parameter(ValueFromPipelineByPropertyName)]
        [Alias('activeFrom')]
        [datetime]$FromDate = [DateTime]::Today,

        [Parameter(ValueFromPipelineByPropertyName)]
        [Alias('activeTo')]
        [datetime]$ToDate = [DateTime]::Today.AddDays(1).AddSeconds(-1),

        [string]$DiagnosticId='DiagnosticOdometerAdjustmentId'
    )

    Begin
    {
        Write-Debug "$($MyInvocation.MyCommand.Name)::Begin"

        $Uri = "https://$($Session.path)/apiv1"
        Write-Debug "Uri: $Uri"

        Write-Debug "DiagnosticId: $DiagnosticId"
    }
    Process
    {
        Write-Debug "$($MyInvocation.MyCommand.Name)::Process"

        # foreach ($Id in $DeviceId) 
        # {
            Write-Debug "DeviceId: $DeviceId"
            Write-Debug "FromDate: $FromDate"
            Write-Debug "ToDate: $ToDate"
    
            # payload as JSON
            $Body = @{
                method = 'Get'
                params = @{ 
                    typeName = 'StatusData'
                    credentials = $Session.credentials
                    search = @{
                        deviceSearch = @{ id = $DeviceId }
                        diagnosticSearch = @{ id = $DiagnosticId }
                        fromDate = $FromDate.ToUniversalTime().ToString("o")
                        toDate = $toDate.ToUniversalTime().ToString("o")
                    }
                }
            } 

            Write-Debug ($Body | ConvertTo-Json -Depth 3)

            # POST
            $Content = ( Invoke-WebRequest -Uri $uri -Method Post -Body ($Body | ConvertTo-Json -Depth 3 ) -ContentType "application/json" ).Content | ConvertFrom-Json

            # returns PsCustomObject representation of object
            if ( $Content.result ) { $Content.result }
            # otherwise raise an exception
            elseif ($Content.error) { Write-Error -Message $Content.error.message }
                    
        # } # /foreach

    } # /process

    end { Write-Debug "$($MyInvocation.MyCommand.Name)::End" }

}
