<#
.SYNOPSIS
Add a Geotab Enitiy

.PARAMETER Session
Geotab session object.

.PARAMETER typeName
The Entity type

.PARAMETER Entity
The Enitiy Data 

.EXAMPLE
PS> New-GeotabEntity -Session $Session -typeName 'User' -entity $UserData

Add the provided User definded in $UserData

.NOTES
The will create a new entity. 

.LINK
https://developers.geotab.com/myGeotab/apiReference/methods/Add

#>
function New-GeotabEntity {

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
            method = 'Add'
            params = @{ 
                credentials = $Session.credentials
                typeName = $typeName
                entity = $entity
            }
        }
        
        # payload as JSON
        Write-Debug ($Body | ConvertTo-Json -Depth 10)
    
        if ( $PSCmdlet.ShouldProcess("Invoke-WebRequest") ) {
            # POST
            $Content = ( Invoke-WebRequest -Uri $uri -Method Post -Body ($Body | ConvertTo-Json -Depth 10) -ContentType "application/json" ).Content | ConvertFrom-Json
        
            # returns PsCustomObject representation of object
            if ( $Content.result ) { $Content.result }

            # otherwise raise an exception
            elseif ($Content.error) { Write-Error -Message $Content.error.message }
        }
    
    }
    
    end {}

}