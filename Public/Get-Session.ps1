<#
.SYNOPSIS
Gets a session object.

.DESCRIPTION
Gets a session object.

.PARAMETER Database
The name of the database.

.PARAMETER Credential
System.Management.Automation.PSCredential.  Representation of account and password.

.INPUTS
None.

.OUTPUTS
System.Management.Automation.PsCustomObject.  Session object.

.EXAMPLE
PS> $Credential = Get-Credential
PS> Get-Session -Database 'database' -Credential $Credential

.EXAMPLE
PS> $SecurePassword = ConvertTo-SecureString 'password' -AsPlainText -Force
PS> $Credential = New-Object System.Management.Automation.PSCredential ('account', $SecurePassword)
PS> Get-Session -Database 'database' -Credential $Credential

.LINK
https://geotab.github.io/sdk/software/guides/concepts/#authentication

#>
function Get-Session
{
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		[string]$Database,

		[Parameter(Mandatory = $true)]
		[pscredential]$Credential
	)

	Write-Debug "$($MyInvocation.MyCommand.Name)"

	$Uri = 'https://my.geotab.com/apiv1'

	# convert SecureString to "plain text"
	$BSTR = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($Credential.Password)
	$Password = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)
	
	Write-Debug "Database: $Database"
	Write-Debug "UserName: $($Credential.UserName)"
	# Write-Debug "Password: $Password"

	# payload as JSON
	$body = @{
		method = 'Authenticate'
		params = @{
			database = $Database
			userName = ($Credential.UserName)
			password = $Password
		}
	} | ConvertTo-Json

	# POST, process responses, then grab relevant data
	$Content = ( Invoke-WebRequest -Uri $Uri -Method Post -Body $Body -ContentType "application/json"  ).Content | ConvertFrom-Json

	# returns PsCustomObject representation of credentials
	if ( $Content.result ) { [PsCustomObject]$Content.result }

	# otherwise raise an exception
	elseif ($Content.error) { Write-Error -Message $Content.error.message }

}
