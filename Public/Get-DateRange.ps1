<#
.SYNOPSIS
Generate a Date for all values between to dates.

.PARAMETER From
The beginning of the range.

.PARAMETER To
The end of the range.

.INPUTS
None.

.OUTPUTS
System.DateTime

.EXAMPLE
PS> New-DateRange '01/15/2020' '01/20/2020'

Wednesday, January 15, 2020 12:00:00 AM
Thursday, January 16, 2020 12:00:00 AM
Friday, January 17, 2020 12:00:00 AM
Saturday, January 18, 2020 12:00:00 AM
Sunday, January 19, 2020 12:00:00 AM
Monday, January 20, 2020 12:00:00 AM

.EXAMPLE
PS> New-DateRange '01/15/2019'

Wednesday, January 15, 2020 12:00:00 AM
Thursday, January 16, 2020 12:00:00 AM
Friday, January 17, 2020 12:00:00 AM
Saturday, January 18, 2020 12:00:00 AM
Sunday, January 19, 2020 12:00:00 AM
Monday, January 20, 2020 12:00:00 AM

Assuming `Get-Date` is 01/01/2020

#>
function New-DateRange {

    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory,ValueFromPipelineByPropertyName)]
        [Alias('activeFrom')]
        [datetime]$From,

        [Parameter(ValueFromPipelineByPropertyName)]
        [Alias('activeTo')]
        [datetime]$To = (Get-Date)
    )

    Begin {}
    Process
    {
        Write-Debug "$($From.Date) - $($To.Date)"

        while ( $From.Date -le $To.Date ) 
        {
            $From
            $From = $From.AddDays(1)
        }
    
    }
    End {}

}
