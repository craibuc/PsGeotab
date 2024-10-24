<#
.SYNOPSIS
Generate a Date for all values between to dates.

.PARAMETER From
The beginning of the range.

.PARAMETER To
The end of the range.

.PARAMETER ExcludeFuture
Exclude dates that are greater than `Today`.

.PARAMETER StartOfMonth
Include only the first day of every month.

.PARAMETER EndOfMonth
Include only the last day of every month.

.PARAMETER FirstDate
Include the first date in the supplied range.

.PARAMETER LastDate
Include the last date in the supplied range.

.PARAMETER AddTime
Add a time to the returned date.

.INPUTS
System.DateTime or None.

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
function Get-GeotabDateRange {

    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('activeFrom')]
        [datetime]$From,

        [Parameter(ValueFromPipelineByPropertyName)]
        [Alias('activeTo')]
        [datetime]$To = (Get-Date),

        [switch]$ExcludeFuture,
        
        [switch]$StartOfMonth,
        [switch]$EndOfMonth,

        [switch]$FirstDate,
        [switch]$LastDate,

        [timespan]$Time = '00:00:00'

    )

    Begin {
        Write-Debug "$($MyInvocation.MyCommand.Name)::Begin"
        
        Write-Debug "ExcludeFuture: $ExcludeFuture"
        Write-Debug "StartOfMonth: $StartOfMonth"
        Write-Debug "EndOfMonth: $EndOfMonth"
    }
    Process {
        Write-Debug "$($MyInvocation.MyCommand.Name)::Process"

        if ($ExcludeFuture) {
            $Today = (Get-Date)
            $To = if ( $Today.Date -lt $To.Date ) { $Today } else { $To }
        }
    
        $Save = $From

        Write-Debug "From: $($From.Date) - To: $($To.Date)"

        while ( $From.Date -le $To.Date ) {
            if ($FirstDate -and $From.Date -eq $Save.Date) { $From.Date + $Time }
            elseif ($LastDate -and $From.Date -eq $To.Date) { $From.Date + $Time }
            else {
                # -StartOfMonth and mm/1/yy
                if ( $StartOfMonth -and $From.Day -eq 1) { $From.Date + $Time }
        
                # -EndOfMonth and mm/[28|29|30|31]/yy
                if ( $EndOfMonth -and (!($From.Month -eq 1)) -and ($From.Date -eq $From.AddMonths(1).AddDays(-$From.Day).Date)) { $From.Date + $Time }
                if ($EndOfMonth -and $From.Day -eq 31 -and !($From.Month -eq 7)) { $From.Date + $Time }
        
                # -StartOfMonth and -EndOfMonth not supplied
                elseif ( !$StartOfMonth -and !$EndOfMonth ) { $From.Date + $Time }
            }
            # increment
            $From = $From.AddDays(1)
        
        }
    
    }
    End { 
        Write-Debug "$($MyInvocation.MyCommand.Name)::End"
    }

}

