<#
.SYNOPSIS
Generate a Date for all values between to dates.

.PARAMETER From
The beginning of the range.

.PARAMETER To
The end of the range.

.PARAMETER FirstOfMonth
Include only the first day of every month.

.PARAMETER ExcludeFuture
Exclude dates that are greater than `Today`.

.INPUTS
None.

.OUTPUTS
System.DateTime

.EXAMPLE
PS> Get-DateRange '01/15/2020' '01/20/2020'

Wednesday, January 15, 2020 12:00:00 AM
Thursday, January 16, 2020 12:00:00 AM
Friday, January 17, 2020 12:00:00 AM
Saturday, January 18, 2020 12:00:00 AM
Sunday, January 19, 2020 12:00:00 AM
Monday, January 20, 2020 12:00:00 AM

.EXAMPLE
PS> Get-DateRange '01/15/2019'

Wednesday, January 15, 2020 12:00:00 AM
Thursday, January 16, 2020 12:00:00 AM
Friday, January 17, 2020 12:00:00 AM
Saturday, January 18, 2020 12:00:00 AM
Sunday, January 19, 2020 12:00:00 AM
Monday, January 20, 2020 12:00:00 AM

Assuming `Get-Date` is 01/01/2020

#>
function Get-DateRange {

    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory,ValueFromPipelineByPropertyName)]
        [Alias('activeFrom')]
        [datetime]$From,

        [Parameter(ValueFromPipelineByPropertyName)]
        [Alias('activeTo')]
        [datetime]$To = (Get-Date),

        [switch]$FirstOfMonth,

        [switch]$ExcludeFuture
    )

    Begin {
        Write-Debug "$($MyInvocation.MyCommand.Name)::Begin"
        
        Write-Debug "FirstOfMonth: $FirstOfMonth"
        Write-Debug "ExcludeFuture: $ExcludeFuture"
    }
    Process
    {
        Write-Debug "$($MyInvocation.MyCommand.Name)::Process"

        if ($ExcludeFuture) { $To = (Get-Date).Date }
        Write-Debug "$($From.Date) - $($To.Date)"

        while ( $From.Date -le $To.Date ) 
        {

            if ($FirstOfMonth)
            { 
                # include dates that are MM/01/YYYY
                if ( $From.Day -eq 1 ) { $From.Date }
            }
            else { $From.Date }

            # increment
            $From = $From.AddDays(1)
        }
    
    }
    End 
    { 
        Write-Debug "$($MyInvocation.MyCommand.Name)::End" 
    }

}

