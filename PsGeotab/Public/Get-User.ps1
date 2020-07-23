function Get-User {

    [CmdletBinding()]
	param
	(
		[Parameter(ParameterSetName='SessionOnly', Mandatory = $true)]
		# [Parameter(ParameterSetName='ByID', Mandatory = $true)]
		# [Parameter(ParameterSetName='ByName', Mandatory = $true)]
		[PsCustomObject]$Session

		# [Parameter(ParameterSetName='ByID', Mandatory = $true)]
		# [string]$Id,

		# [Parameter(ParameterSetName='ByName', Mandatory = $true)]
		# [string]$Name
	)

	Write-Debug "$($MyInvocation.MyCommand.Name)"
	# Write-Debug "Id: $Id"
	# Write-Debug "Name: $Name"

	$Uri = "https://$($Session.path)/apiv1"
	Write-Debug "Uri: $Uri"
	
	# payload as JSON
	$Body = @{
		method = 'Get'
		params = @{ 
			typeName = 'User'
			credentials = $Session.credentials
		}
	} 
	
	# if ($Id) {
	# 	$Body['params']['search'] = @{id = $Id}
	# }
	# elseif ($Name) {
	# 	$Body['params']['search'] = @{name = $Name}
	# }
	
	# Write-Debug ($Body | ConvertTo-Json -Depth 3)

	# POST
	$Content = ( Invoke-WebRequest -Uri $uri -Method Post -Body ($Body | ConvertTo-Json -Depth 3) -ContentType "application/json" ).Content | ConvertFrom-Json

	# returns PsCustomObject representation of object
	if ( $Content.result ) { $Content.result }
	# otherwise raise an exception
    elseif ($Content.error) { Write-Error -Message $Content.error.message }

}
