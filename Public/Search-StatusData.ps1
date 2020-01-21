<#
.SYNOPSIS

.PARAMETER Session
Geotab session object.

.PARAMETER DeviceId
The device's id.

.PARAMETER DiagnosticId
The diagnostic measurement. Default: 'DiagnosticOdometerAdjustmentId'

.PARAMETER FromDate
Include diagnostic measurements after this date/time.  Default: Today at 12:00:00

.PARAMETER ToDate
Include diagnostic measurements before this date/time.  Default: Today at 23:59:59

.EXAMPLE
PS> Search-StatusData -Session $Session -DeviceId 'b57'

Get DiagnosticOdometerAdjustmentId diagnostics for device `b57` that occurred today.

.LINK
https://geotab.github.io/sdk/software/api/reference/#T:Geotab.Checkmate.ObjectModel.Engine.StatusDataSearch

#>
function Search-StatusData {

    [CmdletBinding()]
    param(
		[Parameter(Mandatory=$true, ValueFromPipeline=$true)]
        [PsCustomObject]$Session,

        [Parameter(ValueFromPipelineByPropertyName=$true,ValueFromPipeline=$true)]
        [Alias('id')]
        [string]$DeviceId,
    
        [string]$DiagnosticId='DiagnosticOdometerAdjustmentId',

        [datetime]$FromDate = [DateTime]::Today,

        [datetime]$ToDate = [DateTime]::Today.AddDays(1).AddSeconds(-1)
    )

    Begin
    {
        Write-Debug "$($MyInvocation.MyCommand.Name)::Begin"

        $Uri = "https://$($Session.path)/apiv1"
        Write-Debug "Uri: $Uri"

        Write-Debug "DiagnosticId: $DiagnosticId"
        Write-Debug "FromDate: $FromDate"
        Write-Debug "ToDate: $ToDate"
    }
    Process
    {
        Write-Debug "$($MyInvocation.MyCommand.Name)::Process"

        foreach ($Id in $DeviceId) 
        {
            Write-Debug "Id: $Id"

            # payload as JSON
            $Body = @{
                method = 'Get'
                params = @{ 
                    typeName = 'StatusData'
                    credentials = $Session.credentials
                    search = @{
                        deviceSearch = @{ id = $Id }
                        diagnosticSearch = @{ id = $DiagnosticId }
                        fromDate = $FromDate.ToUniversalTime().ToString("o")
                        toDate = $toDate.ToUniversalTime().ToString("o")
                    }
                }
            } 

            Write-Debug $Body | ConvertTo-Json -Depth 3

            # POST
            $Content = ( Invoke-WebRequest -Uri $uri -Method Post -Body ($Body | ConvertTo-Json -Depth 3 ) -ContentType "application/json" ).Content | ConvertFrom-Json

            # returns PsCustomObject representation of object
            if ( $Content.result ) { $Content.result }
            # otherwise raise an exception
            elseif ($Content.error) { Write-Error -Message $Content.error.message }
                    
        } # /foreach

    } # /process

    end { Write-Debug "$($MyInvocation.MyCommand.Name)::End" }

}
