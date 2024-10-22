<#
.SYNOPSIS
Remove a Geotab Enitiy

.PARAMETER Session
Geotab session object.

.PARAMETER typeName
The Entity type

.PARAMETER Entity
The Enitiy Data 

.EXAMPLE
PS> Remove-GeotabEntity -Session $Session -typeName 'User' -entity $UserData

Remove the provided User definded in $UserData

.NOTES
This will attempt to Delete all date of the provided entity, this is not reversable.

.LINK
https://developers.geotab.com/myGeotab/apiReference/methods/Remove

#>
function Remove-GeotabEntity {

    [CmdletBinding(SupportsShouldProcess)]
    param (
        [Parameter(Mandatory)]
        [PsCustomObject]$Session,

        [Parameter(Mandatory)]
        [string]$typeName,

        [Parameter(Mandatory)]
        [object]$entity
    )
    
    begin {
        $Uri = "https://$($Session.path)/apiv1"
        Write-Debug "Uri: $Uri"
    }
    
    process {
        # payload        
        $Body = @{
            method = 'Remove'
            params = @{ 
                credentials = $Session.credentials
                typeName = $typeName
                entity = $entity
            }
        }
        
        # payload as JSON
        Write-Debug ($Body | ConvertTo-Json -Depth 4)
    
        # POST
        if ( $PSCmdlet.ShouldProcess("Invoke-WebRequest") ) {
            $Content = ( Invoke-WebRequest -Uri $uri -Method Post -Body ($Body | ConvertTo-Json -Depth 4) -ContentType "application/json" ).Content | ConvertFrom-Json

            # returns PsCustomObject representation of object
            if ( $Content.result ) { $Content.result }

            # otherwise raise an exception
            elseif ($Content.error) { Write-Error -Message $Content.error.message }
        }

    }
    
    end {}

}