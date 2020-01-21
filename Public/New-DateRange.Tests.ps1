$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'
. "$here\$sut"

Describe "New-DateRange" {

    [datetime]$From = '01/01/2019'
    [datetime]$To = '01/31/2019'

    Context "`$From and `$To supplied" {

        It "generates dates between `$From and `$To" {

            # act
            $Actual = New-DateRange $From $To

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
            $Actual = New-DateRange $From

            # assert
            $Actual | Select-Object -First 1 | Should -Be ($From)
            $Actual | Select-Object -Last 1 | Should -Be $To
            $Actual | Measure-Object | Select-Object -ExpandProperty Count | Should -Be (($To - $From).Days + 1)

        }
    
    }

    Context "Parameters supplied via pipeline" {

        $Hash = [PsCustomObject]@{
            activeFrom=[datetime]'01/01/2020'
            activeTo=[datetime]'01/05/2020'
        }

        It "generates dates between $($Hash.activeFrom) and $($Hash.activeTo)" {

            # act
            $Actual = $Hash | New-DateRange

            # assert
            $Actual | Select-Object -First 1 | Should -Be ($Hash.activeFrom)
            $Actual | Select-Object -Last 1 | Should -Be ($Hash.activeTo)
            $Actual | Measure-Object | Select-Object -ExpandProperty Count | Should -Be (($Hash.activeTo - $Hash.activeFrom).Days + 1)
        }

    }
}
