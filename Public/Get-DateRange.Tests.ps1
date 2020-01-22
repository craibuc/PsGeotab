$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'
. "$here\$sut"

Describe "Get-DateRange" {

    [datetime]$From = '01/01/2019'
    [datetime]$To = '01/31/2019'

    Context "`$From and `$To supplied" {

        It "generates dates between `$From and `$To" {

            # act
            $Actual = Get-DateRange $From $To

            # assert
            $Actual | Select-Object -First 1 | Should -Be ($From)
            $Actual | Select-Object -Last 1 | Should -Be ($To)
            $Actual | Measure-Object | Select-Object -ExpandProperty Count | Should -Be (($To - $From).Days + 1)
        }
    
    }

    Context "`$From and `$To supplied" {

        # arrange
        [datetime]$From = '01/01/2020'
        [datetime]$To = (Get-Date).Date

        It "generates dates between `$From and Today" {

            # act
            $Actual = Get-DateRange $From

            # assert
            $Actual | Select-Object -First 1 | Should -Be ($From)
            $Actual | Select-Object -Last 1 | Should -Be $To
            $Actual | Measure-Object | Select-Object -ExpandProperty Count | Should -Be (($To - $From).Days + 1)

        }
    
    }

    Context "`$From and `$To supplied via pipeline" {

        $Hash = [PsCustomObject]@{
            activeFrom=[datetime]'01/01/2020'
            activeTo=[datetime]'01/05/2020'
        }

        It "generates dates between $($Hash.activeFrom) and $($Hash.activeTo)" {

            # act
            $Actual = $Hash | Get-DateRange

            # assert
            $Actual | Select-Object -First 1 | Should -Be ($Hash.activeFrom)
            $Actual | Select-Object -Last 1 | Should -Be ($Hash.activeTo)
            $Actual | Measure-Object | Select-Object -ExpandProperty Count | Should -Be (($Hash.activeTo - $Hash.activeFrom).Days + 1)
        }

    } # /context

    Context "`$FirstOfMonth supplied" {

        [datetime]$From = '01/01/2019'
        [datetime]$To = '02/15/2019'
    
        It "Generates dates that are the first of the month" {

            # act
            $Actual = Get-DateRange -From $From -To $To -FirstOfMonth

            # assert
            $Actual | Select-Object -First 1 | Should -Be $From
            $Actual | Select-Object -Last 1 | Should -Be ([datetime]'02/01/2019')
            $Actual | Measure-Object | Select-Object -ExpandProperty Count | Should -Be 2

        }
    } # /context

    Context "`$ExcludeFuture supplied" {

        [datetime]$From = '01/01/2019'
        [datetime]$To = (Get-Date).AddDays(10)
        
        $Expected = (Get-Date).Date

        It "Generates dates that are <= Today" {

            # act
            $Actual = Get-DateRange -From $From -To $To -ExcludeFuture

            # assert
            $Actual | Select-Object -First 1 | Should -Be $From
            $Actual | Select-Object -Last 1 | Should -Be $Expected
            $Actual | Measure-Object | Select-Object -ExpandProperty Count | Should -Be (($Expected - $From).Days + 1)

        }
    } # /context

    Context "`$FirstOfMonth and `$ExcludeFuture supplied" {

        [datetime]$From = (get-date -day 1).addmonths(-1).date # first of the month, one month ago
        [datetime]$To = (Get-Date).AddMonths(2)
        
        It "Generates dates that are <= Today and are first of the month" {

            # act
            $Actual = Get-DateRange -From $From -To $To -FirstOfMonth -ExcludeFuture

            # assert
            $Actual | Select-Object -First 1 | Should -Be $From
            $Actual | Select-Object -Last 1 | Should -Be (Get-Date -Day 1).Date
            $Actual | Measure-Object | Select-Object -ExpandProperty Count | Should -Be 2

        }
    } # /context

}
