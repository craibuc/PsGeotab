BeforeAll {

    # /PsGeotab
    $ProjectDirectory = Split-Path -Path (Split-Path -Path $PSScriptRoot -Parent) -Parent

    # /PsGeotab/PsGeotab/Public
    $PublicPath = Join-Path $ProjectDirectory "/PsGeotab/Public/"

    # New-GeotabUserSearch.ps1
    $sut = (Split-Path -Leaf $PSCommandPath) -replace '\.Tests\.', '.'

    # . /PsGeotab/PsGeotab/Public/New-GeotabUserSearch.ps1
    . (Join-Path $PublicPath $sut)

}

Describe "New-GeotabUserSearch" -Tag 'unit' {

    Context "Parameter validation" {
        BeforeAll {
            $Command = Get-Command 'New-GeotabUserSearch'
        }
        
        Context 'companyGroup' {
            BeforeAll { $ParameterName = 'companyGroup' }
            
            It "is a [String[]]" {
                $Command | Should -HaveParameter $ParameterName -Type string[]
            }
            It "is optional" {
                $Command | Should -HaveParameter $ParameterName -Not -Mandatory
            }
        }

        Context 'driverGroup' {
            BeforeAll { $ParameterName = 'driverGroup'}

            It "is a [String[]]" {
                $Command | Should -HaveParameter $ParameterName -Type string[]
            }
            It "is optional" {
                $Command | Should -HaveParameter $ParameterName -Not -Mandatory
            }
        }

        Context 'firstName' {
            BeforeAll { $ParameterName = 'firstName' }

            It "is a [String]" {
                $Command | Should -HaveParameter $ParameterName -Type string
            }
            It "is optional" {
                $Command | Should -HaveParameter $ParameterName -Not -Mandatory

            }
        }

        Context 'lastName' {
            BeforeAll { $ParameterName = 'lastName' }

            It "is a [String]" {
                $Command | Should -HaveParameter $ParameterName -Type string
            }
            It "is optional" {
                $Command | Should -HaveParameter $ParameterName -Not -Mandatory
            }
        }

        Context 'name' {
            BeforeAll { $ParameterName = 'name' }

            It "is a [String]" {
                $Command | Should -HaveParameter $ParameterName -Type string
            }
            It "is optional" {
                $Command | Should -HaveParameter $ParameterName -Not -Mandatory
            }
        }

        Context 'fromDate' {
            BeforeAll { $ParameterName = 'fromDate' }

            It "is a [datetime]" {
                $Command | Should -HaveParameter $ParameterName -Type datetime
            }
            It "is optional" {
                $Command | Should -HaveParameter $ParameterName -Not -Mandatory
            }
        }

        Context 'toDate' {
            BeforeAll { $ParameterName = 'toDate' }

            It "is a [datetime]" {
                $Command | Should -HaveParameter $ParameterName -Type datetime
            }
            It "is optional" {
                $Command | Should -HaveParameter $ParameterName -Not -Mandatory
            }
        }

        Context 'isDriver' {
            BeforeAll { $ParameterName = 'isDriver' }

            It "is a [boolean]" {
                $Command | Should -HaveParameter $ParameterName -Type boolean
            }
            It "is optional" {
                $Command | Should -HaveParameter $ParameterName -Not -Mandatory
            }
        }

        Context 'keyId' {
            BeforeAll { $ParameterName = 'keyId' }

            It "is a [string]" {
                $Command | Should -HaveParameter $ParameterName -Type string
            }
            It "is optional" {
                $Command | Should -HaveParameter $ParameterName -Not -Mandatory
            }
        }

        Context 'keywords' {
            BeforeAll { $ParameterName = 'keywords' }

            It "is a [string]" {
                $Command | Should -HaveParameter $ParameterName -Type string
            }
            It "is optional" {
                $Command | Should -HaveParameter $ParameterName -Not -Mandatory
            }
        }

        Context 'securityGroup' {
            BeforeAll { $ParameterName = 'securityGroup' }

            It "is a [string[]]" {
                $Command | Should -HaveParameter $ParameterName -Type string[]
            }
            It "is optional" {
                $Command | Should -HaveParameter $ParameterName -Not -Mandatory
            }
        }

        Context 'serialNumber' {
            BeforeAll { $ParameterName = 'serialNumber' }

            It "is a [string]" {
                $Command | Should -HaveParameter $ParameterName -Type string
            }
            It "is optional" {
                $Command | Should -HaveParameter $ParameterName -Not -Mandatory
            }
        }

        Context 'id' {
            BeforeAll { $ParameterName = 'id' }

            It "is a [string]" {
                $Command | Should -HaveParameter $ParameterName -Type string
            }
            It "is optional" {
                $Command | Should -HaveParameter $ParameterName -Not -Mandatory
            }
        }

    }

    Context "ByCompanyGroup" {

        BeforeAll {

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

        }

        BeforeEach {
            # act
            $Actual = $Expected | New-GeotabUserSearch
        }

        it "creates a UserSearch object" {

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

        BeforeAll {

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

        }

        BeforeEach {
            # act
            $Actual = $Expected | New-GeotabUserSearch
        }

        it "creates a UserSearch object" {
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
