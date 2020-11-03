function Get-GeotabEntity {

    [CmdletBinding()]
	param
	(
		[Parameter(Mandatory)]
		[PsCustomObject]$Session,

        [Parameter(Mandatory)]
		[string]$typeName,

        [Parameter()]
        [int]$resultsLimit,

        [Parameter()]
        [object]$search
	)

	$Uri = "https://$($Session.path)/apiv1"
	Write-Debug "Uri: $Uri"
	
	# payload as JSON
	$Body = @{
        method = 'Get'
        params = @{ 
            credentials = $Session.credentials
            typeName = $typeName
        }
	}

    if ( $PsBoundParameters['resultsLimit'] ) {
        $Body['params'].Add('resultsLimit', $resultsLimit)
    }

    if ( $PsBoundParameters['search'] ) {
        $Body['params'].Add('search', $search)
    }

	Write-Debug ($Body | ConvertTo-Json)

	# POST
	$Content = ( Invoke-WebRequest -Uri $uri -Method Post -Body ($Body | ConvertTo-Json) -ContentType "application/json" ).Content | ConvertFrom-Json

	# returns PsCustomObject representation of object
	if ( $Content.result ) { $Content.result }
	# otherwise raise an exception
    elseif ($Content.error) { Write-Error -Message $Content.error.message }

}
