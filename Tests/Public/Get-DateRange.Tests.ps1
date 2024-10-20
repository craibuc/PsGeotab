# /PsGeotab
$ProjectDirectory = Split-Path -Path (Split-Path -Path $PSScriptRoot -Parent) -Parent

# /PsGeotab/PsGeotab/Public
$PublicPath = Join-Path $ProjectDirectory "/PsGeotab/Public/"

# /PsGeotab/Tests/Fixtures/
# $FixturesDirectory = Join-Path $ProjectDirectory "/Tests/Fixtures/"

# Get-DataRange.ps1
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'

# . /PsGeotab/PsGeotab/Public/Get-DataRange.ps1
. (Join-Path $PublicPath $sut)

BeforeDiscovery {
    
    [datetime]$From = '2024-01-01'
    [datetime]$To = '2024-01-31'
}

Describe "Get-DateRange" {

    Context "<From> and <To> supplied" {
        BeforeEach {
            [datetime]$From = '2024-01-01'
            [datetime]$To = '2024-01-31'
        }
        
        It "generates dates between <From> and <To>" {

            # act
            $Actual = Get-DateRange $From $To

            # assert
            $Actual | Select-Object -First 1 | Should -Be ($From)
            $Actual | Select-Object -Last 1 | Should -Be ($To)
            $Actual | Measure-Object | Select-Object -ExpandProperty Count | Should -Be (($To - $From).Days + 1)
        }
    
    }

    Context "<From> date supplied" {

        BeforeEach {
            # arrange
            [datetime]$From = '2024-01-01'
            [datetime]$To = (Get-Date).Date
        }

        It "generates dates between <From> and Today" {

            # act
            $Actual = Get-DateRange $From

            # assert
            $Actual | Select-Object -First 1 | Should -Be ($From)
            $Actual | Select-Object -Last 1 | Should -Be $To
            $Actual | Measure-Object | Select-Object -ExpandProperty Count | Should -Be (($To - $From).Days + 1)

        }
    
    }

    Context "<From> and <To> supplied via pipeline" {

        BeforeEach {
            $Hash = [PsCustomObject]@{
                activeFrom = [datetime]'2024-01-01'
                activeTo   = [datetime]'2024-01-05'
            }
        }

        It "generates dates between <From> and <To>" {

            # act
            $Actual = $Hash | Get-DateRange

            # assert
            $Actual | Select-Object -First 1 | Should -Be ($Hash.activeFrom)
            $Actual | Select-Object -Last 1 | Should -Be ($Hash.activeTo)
            $Actual | Measure-Object | Select-Object -ExpandProperty Count | Should -Be (($Hash.activeTo - $Hash.activeFrom).Days + 1)
        }

    } # /context

    Context "-ExcludeFuture supplied" {
        BeforeEach {
            [datetime]$From = '2024-01-01'
            [datetime]$To = (Get-Date).AddDays(10)
        
        
            $Expected = (Get-Date).Date
        }
        It "Generates dates that are <= Today" {

            # act
            $Actual = Get-DateRange -From $From -To $To -ExcludeFuture

            # assert
            $Actual | Select-Object -First 1 | Should -Be $From
            $Actual | Select-Object -Last 1 | Should -Be $Expected
            $Actual | Measure-Object | Select-Object -ExpandProperty Count | Should -Be (($Expected - $From).Days + 1)

        }
    } # /context

    Context "-StartOfMonth supplied" {
        BeforeEach {
            [datetime]$From = '2024-01-01'
            [datetime]$To = '2024-02-15'
        }
        It "Generates dates that are the first of the month" {

            # act
            $Actual = Get-DateRange -From $From -To $To -StartOfMonth

            # assert
            $Actual | Select-Object -First 1 | Should -Be $From
            $Actual | Select-Object -Last 1 | Should -Be ([datetime]'2024-02-01')
            $Actual | Measure-Object | Select-Object -ExpandProperty Count | Should -Be 2

        }
    } # /context

    Context "<Star>tOfMonth and <Excl>udeFuture supplied" {
        BeforeEach {
            [datetime]$From = (get-date -day 1).addmonths(-1).date # first of the month, one month ago
            [datetime]$To = (Get-Date).AddMonths(2)
        }
        It "Generates dates that are <= Today and are first of the month" {

            # act
            $Actual = Get-DateRange -From $From -To $To -StartOfMonth -ExcludeFuture

            # assert
            $Actual | Select-Object -First 1 | Should -Be $From
            $Actual | Select-Object -Last 1 | Should -Be (Get-Date -Day 1).Date
            $Actual | Measure-Object | Select-Object -ExpandProperty Count | Should -Be 2

        }
    } # /context

    Context "-EndOfMonth supplied" {
        BeforeEach {
            [datetime]$From = '2024-03-01'
            [datetime]$To = '2024-05-15'
        }
        It "Generates dates that are the last of the month of <From>" {

            # act
            $Actual = Get-DateRange -From $From -To $To -EndOfMonth

            # assert
            $Actual | Select-Object -First 1 | Should -Be ([datetime]'2024-03-31')
            $Actual | Select-Object -Last 1 | Should -Be ([datetime]'2024-04-30')
            $Actual | Measure-Object | Select-Object -ExpandProperty Count | Should -Be 2

        }
    } # /context

    Context "<Star>tOfMonth and <EndO>fMonth supplied" {
        BeforeEach {
            [datetime]$From = '2024-01-01'
            [datetime]$To = '2024-03-15'
        }
        It "Generates dates that are the first and last of the month" {

            # act
            $Actual = Get-DateRange -From $From -To $To -StartOfMonth -EndOfMonth

            # assert
            $Actual | Select-Object -First 1 | Should -Be ([datetime]'2024-01-01')
            $Actual | Select-Object -Last 1 | Should -Be ([datetime]'2024-03-01')
            $Actual | Measure-Object | Select-Object -ExpandProperty Count | Should -Be 5

        }
    } # /context

    Context "<Star>tOfMonth and <EndO>fMonth and <Excl>udeFuture supplied" {
        BeforeEach {
            [datetime]$From = '2024-01-01'
            [datetime]$To = '2024-03-15'
        }
        It "Generates dates that are the first and last of the month and are <= Today" {

            # act
            $Actual = Get-DateRange -From $From -To $To -StartOfMonth -EndOfMonth -ExcludeFuture

            # assert
            $Actual | Select-Object -First 1 | Should -Be ([datetime]'2024-01-01')
            $Actual | Select-Object -Last 1 | Should -Be ([datetime]'2024-03-01')
            $Actual | Measure-Object | Select-Object -ExpandProperty Count | Should -Be 5

        }
    } # /context

    Context "-FirstDate supplied" {
        BeforeEach {
            [datetime]$From = '2024-01-03'
            [datetime]$To = '2024-02-15'
        }
        Context "-StartOfMonth supplied" {
    
            It "Includes the first record and the first day of the month" {

                # act
                $Actual = Get-DateRange -From $From -To $To -FirstDate -StartOfMonth
    
                # assert
                $Actual | Select-Object -First 1 | Should -Be $From
                $Actual | Select-Object -Last 1 | Should -Be ([datetime]'2024-02-01')
                $Actual | Measure-Object | Select-Object -ExpandProperty Count | Should -Be 2

            }
    
        }

        Context "-EndOfMonth supplied" {

            It "Includes the first record and the last day of the month" {

                # act
                $Actual = Get-DateRange -From $From -To $To -FirstDate -EndOfMonth
    
                # assert
                $Actual | Select-Object -First 1 | Should -Be $From
                $Actual | Select-Object -Last 1 | Should -Be ([datetime]'2024-01-31')
                $Actual | Measure-Object | Select-Object -ExpandProperty Count | Should -Be 2
    
            }
    
        }

    } # /context

    Context "-LastDate supplied" {
    
        Context "-StartOfMonth supplied" {
            BeforeEach {
                [datetime]$From = '2024-01-15'
                [datetime]$To = '2024-02-15'
            }
            It "Includes the last record and the first day of the month" {

                # act
                $Actual = Get-DateRange -From $From -To $To -LastDate -StartOfMonth
    
                # assert
                $Actual | Select-Object -First 1 | Should -Be ([datetime]'2024-02-01')
                $Actual | Select-Object -Last 1 | Should -Be ([datetime]'2024-02-15')
                $Actual | Measure-Object | Select-Object -ExpandProperty Count | Should -Be 2

            }
    
        }

        Context "-EndOfMonth supplied" {
            BeforeEach {
                [datetime]$From = '2024-01-15'
                [datetime]$To = '2024-02-15'
            }
            It "Includes the last record and the last day of the month" {

                # act
                $Actual = Get-DateRange -From $From -To $To -LastDate -EndOfMonth
    
                # assert
                $Actual | Select-Object -First 1 | Should -Be ([datetime]'2024-01-31')
                $Actual | Select-Object -Last 1 | Should -Be ([datetime]'2024-02-15')
                $Actual | Measure-Object | Select-Object -ExpandProperty Count | Should -Be 2
    
            }
    
        }

    } # /context

    Context "-Time 23:59:59" {
        BeforeEach {
            $Time = '23:59:59'
            [datetime]$From = '2024-01-01'
            [datetime]$To = '2024-01-01'
        }
        It "Adds $Time to the date" {

            # act
            $Actual = Get-DateRange -From $From -To $To -Time $Time

            # assert
            $Actual | Select-Object -First 1 | Should -Be ([datetime]"2024-01-01 $Time")
            $Actual | Measure-Object | Select-Object -ExpandProperty Count | Should -Be 1

        }
    }

}