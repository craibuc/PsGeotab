# /PsGeotab
$ProjectDirectory = Split-Path -Path (Split-Path -Path $PSScriptRoot -Parent) -Parent

# /PsGeotab/PsGeotab/Public
$PublicPath = Join-Path $ProjectDirectory "/PsGeotab/Public/"

# /PsGeotab/Tests/Fixtures/
# $FixturesDirectory = Join-Path $ProjectDirectory "/Tests/Fixtures/"

# New-DiagnosticSearch.ps1
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'

# . /PsGeotab/PsGeotab/Public/New-UserSearch.ps1
. (Join-Path $PublicPath $sut)

Describe "New-UserSearch" -Tag 'unit' {

    Context "Parameter validation" {
        $Command = Get-Command 'New-UserSearch'

        Context 'companyGroup' {
            $ParameterName = 'companyGroup'

            It "is a [String[]]" {
                $Command | Should -HaveParameter $ParameterName -Type string[]
            }
            It "is optional" {
                $Command | Should -HaveParameter $ParameterName -Not -Mandatory
            }
        }

        Context 'driverGroup' {
            $ParameterName = 'driverGroup'

            It "is a [String[]]" {
                $Command | Should -HaveParameter $ParameterName -Type string[]
            }
            It "is optional" {
                $Command | Should -HaveParameter $ParameterName -Not -Mandatory
            }
        }

        Context 'firstName' {
            $ParameterName = 'firstName'

            It "is a [String]" {
                $Command | Should -HaveParameter $ParameterName -Type string
            }
            It "is optional" {
                $Command | Should -HaveParameter $ParameterName -Not -Mandatory

            }
        }

        Context 'lastName' {
            $ParameterName = 'lastName'

            It "is a [String]" {
                $Command | Should -HaveParameter $ParameterName -Type string
            }
            It "is optional" {
                $Command | Should -HaveParameter $ParameterName -Not -Mandatory
            }
        }

        Context 'name' {
            $ParameterName = 'name'

            It "is a [String]" {
                $Command | Should -HaveParameter $ParameterName -Type string
            }
            It "is optional" {
                $Command | Should -HaveParameter $ParameterName -Not -Mandatory
            }
        }

        Context 'fromDate' {
            $ParameterName = 'fromDate'

            It "is a [datetime]" {
                $Command | Should -HaveParameter $ParameterName -Type datetime
            }
            It "is optional" {
                $Command | Should -HaveParameter $ParameterName -Not -Mandatory
            }
        }

        Context 'toDate' {
            $ParameterName = 'toDate'

            It "is a [datetime]" {
                $Command | Should -HaveParameter $ParameterName -Type datetime
            }
            It "is optional" {
                $Command | Should -HaveParameter $ParameterName -Not -Mandatory
            }
        }

        Context 'isDriver' {
            $ParameterName = 'isDriver'

            It "is a [boolean]" {
                $Command | Should -HaveParameter $ParameterName -Type boolean
            }
            It "is optional" {
                $Command | Should -HaveParameter $ParameterName -Not -Mandatory
            }
        }

        Context 'keyId' {
            $ParameterName = 'keyId'

            It "is a [string]" {
                $Command | Should -HaveParameter $ParameterName -Type string
            }
            It "is optional" {
                $Command | Should -HaveParameter $ParameterName -Not -Mandatory
            }
        }

        Context 'keywords' {
            $ParameterName = 'keywords'

            It "is a [string]" {
                $Command | Should -HaveParameter $ParameterName -Type string
            }
            It "is optional" {
                $Command | Should -HaveParameter $ParameterName -Not -Mandatory
            }
        }

        Context 'securityGroup' {
            $ParameterName = 'securityGroup'

            It "is a [string[]]" {
                $Command | Should -HaveParameter $ParameterName -Type string[]
            }
            It "is optional" {
                $Command | Should -HaveParameter $ParameterName -Not -Mandatory
            }
        }

        Context 'serialNumber' {
            $ParameterName = 'serialNumber'

            It "is a [string]" {
                $Command | Should -HaveParameter $ParameterName -Type string
            }
            It "is optional" {
                $Command | Should -HaveParameter $ParameterName -Not -Mandatory
            }
        }

        Context 'id' {
            $ParameterName = 'id'

            It "is a [string]" {
                $Command | Should -HaveParameter $ParameterName -Type string
            }
            It "is optional" {
                $Command | Should -HaveParameter $ParameterName -Not -Mandatory
            }
        }

    }

    Context "ByCompanyGroup" {

        # arrange
        $Expected = [pscustomobject]@{
            companyGroup = 'companyGroup'
            firstName = 'firstName'
            lastName = 'lastName'
            name = 'name'
            fromDate = '07/22/2020 20:00:00'
            toDate = '07/22/2020 21:00:00'
            isDriver = $true
            keyId = 'keyId'
            keywords = 'keywords'
            securityGroup = 'securityGroup'
            serialNumber = 'serialNumber'
            id = 'b1234'
        }

        it "creates a UserSearch object" {
            # act
            $Actual = $Expected | New-UserSearch

            # assert
            $Actual.companyGroup | Should -Be $Expected.companyGroup
            $Actual.firstName | Should -Be $Expected.firstName
            $Actual.lastName | Should -Be $Expected.lastName
            $Actual.name | Should -Be $Expected.name
            $Actual.fromDate | Should -Be $Expected.fromDate
            $Actual.toDate | Should -Be $Expected.toDate
            $Actual.isDriver | Should -Be $Expected.isDriver
            $Actual.keyId | Should -Be $Expected.keyId
            $Actual.keywords | Should -Be $Expected.keywords
            $Actual.securityGroup | Should -Be $Expected.securityGroup
            $Actual.serialNumber | Should -Be $Expected.serialNumber
            $Actual.id | Should -Be $Expected.id
        }

    }

    Context "ByDriverGroup" {

        # arrange
        $Expected = [pscustomobject]@{
            driverGroup = 'driverGroup'
            firstName = 'firstName'
            lastName = 'lastName'
            name = 'name'
            fromDate = '07/22/2020 20:00:00'
            toDate = '07/22/2020 21:00:00'
            isDriver = $true
            keyId = 'keyId'
            keywords = 'keywords'
            securityGroup = 'securityGroup'
            serialNumber = 'serialNumber'
            id = 'b1234'
        }

        it "creates a UserSearch object" {
            # act
            $Actual = $Expected | New-UserSearch

            # assert
            $Actual.driverGroup | Should -Be $Expected.driverGroup
            $Actual.firstName | Should -Be $Expected.firstName
            $Actual.lastName | Should -Be $Expected.lastName
            $Actual.name | Should -Be $Expected.name
            $Actual.fromDate | Should -Be $Expected.fromDate
            $Actual.toDate | Should -Be $Expected.toDate
            $Actual.isDriver | Should -Be $Expected.isDriver
            $Actual.keyId | Should -Be $Expected.keyId
            $Actual.keywords | Should -Be $Expected.keywords
            $Actual.securityGroup | Should -Be $Expected.securityGroup
            $Actual.serialNumber | Should -Be $Expected.serialNumber
            $Actual.id | Should -Be $Expected.id
        }

    }

}
