<#
.SYNOPSIS
Get the devices in a database.

.DESCRIPTION
Get the devices in a database.

.PARAMETER Session
System.Management.Automation.PsCustomObject.  Session object.

.PARAMETER Id
The Id of the device.

.PARAMETER Name
The name of the device.

.INPUTS
None

.OUTPUTS
System.Management.Automation.PsCustomObject[].  Array of devices.

.EXAMPLE
Get all devices.
PS> Get-Device -Session $Session

.EXAMPLE
Get device with id of 'b57'
PS> Get-Device -Session $Session -Id 'b57'

.EXAMPLE
Get device with name of '100001'
PS> Get-Device -Session $Session -Name '1000001'

#>
function Get-Device
{
	[CmdletBinding()]
	param
	(
		[Parameter(ParameterSetName='SessionOnly', Mandatory = $true)]
		[Parameter(ParameterSetName='ByID', Mandatory = $true)]
		[Parameter(ParameterSetName='ByName', Mandatory = $true)]
		[PsCustomObject]$Session,

		[Parameter(ParameterSetName='ByID', Mandatory = $true)]
		[string]$Id,

		[Parameter(ParameterSetName='ByName', Mandatory = $true)]
		[string]$Name
	)

	Write-Debug "$($MyInvocation.MyCommand.Name)"
	Write-Debug "Id: $Id"
	Write-Debug "Name: $Name"

	$Uri = "https://$($Session.path)/apiv1"
	Write-Debug "Uri: $Uri"
	
	# payload as JSON
	$Body = @{
		method = 'Get'
		params = @{ 
			typeName = 'Device'
			credentials = $Session.credentials
		}
	} 
	
	if ($Id) {
		$Body['params']['search'] = @{id = $Id}
	}
	elseif ($Name) {
		$Body['params']['search'] = @{name = $Name}
	}
	
	# Write-Debug ($Body | ConvertTo-Json -Depth 3)

	# POST
	$Content = ( Invoke-WebRequest -Uri $uri -Method Post -Body ($Body | ConvertTo-Json -Depth 3) -ContentType "application/json" ).Content | ConvertFrom-Json

	# returns PsCustomObject representation of object
	if ( $Content.result ) { $Content.result }
	# otherwise raise an exception
	elseif ($Content.error) { Write-Error -Message $Content.error.message }
	
}
