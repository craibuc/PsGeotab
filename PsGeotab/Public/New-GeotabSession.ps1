<#
.SYNOPSIS
Creates a new Geotab session.

.DESCRIPTION
Creates a new Geotab session.

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
PS> New-GeotabSession -Database 'database' -Credential $Credential

Create a new Geotab session, prompting for parameters.

.EXAMPLE
PS> $SecurePassword = ConvertTo-SecureString 'password' -AsPlainText -Force
PS> $Credential = New-Object System.Management.Automation.PSCredential ('account', $SecurePassword)
PS> New-GeotabSession -Database 'database' -Credential $Credential

Create a new Geotab session, supplying parameters in code.

.LINK
https://developers.geotab.com/MyGeotab/software/guides/concepts/#authentication

#>
function New-GeotabSession {
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
	$Password = $Credential | ConvertTo-PlainText

	Write-Debug "Database: $Database"
	Write-Debug "UserName: $($Credential.UserName)"

	$Headers = @{'Cache-Control' = 'no-cache' }

	# payload as JSON
	$body = @{
		method = 'Authenticate'
		params = @{
			database = $Database
			userName = ($Credential.UserName)
			password = $Password
		}
	} | ConvertTo-Json
	
	# Write-Debug $Body

	# forcing TLS v1.2
	[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

	# POST, process responses, then grab relevant data
	$Content = ( Invoke-WebRequest -Uri $Uri -Method Post -Body $Body -ContentType "application/json" -Headers $Headers ).Content | ConvertFrom-Json

	# returns PsCustomObject representation of credentials
	if ( $Content.result ) { 
		if ($Content.result.Path -eq 'ThisServer') {
			$Content.result.Path = 'my.geotab.com'
		}
		[PsCustomObject]$Content.result 
	}

	# otherwise raise an exception
	elseif ($Content.error) { Write-Error -Message $Content.error.message }

}
