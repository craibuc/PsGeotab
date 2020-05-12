<#
.SYNOPSIS
Convert an encrypted string to its plain-text equivalent.

.DESCRIPTION
Convert an encrypted string to its plain-text equivalent.

.PARAMETER SecureString
The encrypted value to be converted.

.EXAMPLE
PS> $password = ConvertTo-SecureString 'pa55w0rd' -AsPlainText -Force
PS> ConvertTo-PlainText $password
'pa55word'

.INPUTS
[System.Security.SecureString]

.OUTPUTS
[System.String]

.NOTES
None

#>
function ConvertTo-PlainText {

    [CmdletBinding()]
	param(
        [Parameter(ValueFromPipeline,ValueFromPipelineByPropertyName)]
        [Alias('Password')]
		[SecureString]$SecureString
	)

    Begin
    { 
        # Write-Debug "$($MyInvocation.MyCommand.Name)::Begin" 
    }
    Process
    {
        # Write-Debug "$($MyInvocation.MyCommand.Name)::Process"

        try
        {
            $BSTR = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($SecureString)
            [System.Runtime.InteropServices.Marshal]::PtrToStringBSTR($BSTR)
            [System.Runtime.InteropServices.Marshal]::ZeroFreeBSTR($BSTR)
        }
        catch
        {
            #ignore
        }
    }
    End
    {
        # Write-Debug "$($MyInvocation.MyCommand.Name)::End"
    }
    
}
