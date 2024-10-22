<#
.SYNOPSIS
Vehicle diagnostic information from the engine computer that can either be measurement data or fault code data.

.PARAMETER Session

.PARAMETER DeviceId

.NOTES
Diagnostics cannot be added, set or removed via the API.

.LINK
https://developers.geotab.com/myGeotab/apiReference/objects/Diagnostic

#>
function Get-Diagnostic {

	[CmdletBinding()]
	param(
		
		[Parameter(Mandatory = $true)]
		[PsCustomObject]$Session,

		[Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ValueFromPipeline = $true)]
		[Alias('id')]
		[string[]]$DeviceId

		# [ValidateSet('DataDiagnostic')]
		# [string]$DiagnosisType
	)

	Begin {
		Write-Debug "$($MyInvocation.MyCommand.Name)::Begin"

		$Uri = "https://$($Session.path)/apiv1"
		Write-Debug "Uri: $Uri"

		# payload as JSON
		$Body = @{
			method = 'Get'
			params = @{ 
				typeName    = 'Diagnostic'
				credentials = $Session.credentials
				search      = @{
					diagnosticType = ''
				}
			}
		}

	}
	Process {
		Write-Debug "$($MyInvocation.MyCommand.Name)::Process"
	
		foreach ($Id in $DeviceId) {
			Write-Debug "DeviceId: $Id"

			# remove search key and value
			$Body['params'].Remove('search')

			# add a search
			if ($Id) {
				$Body['params']['search'] = @{id = $Id }
			}
			# elseif ($DiagnosisType) {
			# 	$Body['params']['search'] = @{diagnosticType = $DiagnosisType}
			# }
		
			Write-Debug ($Body | ConvertTo-Json -Depth 3)

			# POST
			$Content = ( Invoke-WebRequest -Uri $uri -Method Post -Body ($Body | ConvertTo-Json -Depth 3) -ContentType "application/json" ).Content | ConvertFrom-Json
		
			# returns PsCustomObject representation of object
			if ( $Content.result ) { $Content.result }
			# otherwise raise an exception
			elseif ($Content.error) { Write-Error -Message $Content.error.message }
	
		}

	}
	End {
		Write-Debug "$($MyInvocation.MyCommand.Name)::End"
	}

}
