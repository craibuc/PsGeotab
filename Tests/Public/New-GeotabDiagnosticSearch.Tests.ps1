BeforeAll {

    # /PsGeotab
    $ProjectDirectory = Split-Path -Path (Split-Path -Path $PSScriptRoot -Parent) -Parent

    # /PsGeotab/PsGeotab/Public
    $PublicPath = Join-Path $ProjectDirectory "/PsGeotab/Public/"

    # New-GeotabDiagnosticSearch.ps1
    $sut = (Split-Path -Leaf $PSCommandPath) -replace '\.Tests\.', '.'

    # . /PsGeotab/PsGeotab/Public/New-GeotabDiagnosticSearch.ps1
    . (Join-Path $PublicPath $sut)

}

Describe "New-GeotabDiagnosticSearch" -Tag 'unit' {

    Context "Parameter validation" {

        it "has 5, optional parameters" {
            Get-Command "New-GeotabDiagnosticSearch" | Should -HaveParameter 'code' -Type string
            Get-Command "New-GeotabDiagnosticSearch" | Should -HaveParameter 'diagnosticType' -Type string
            Get-Command "New-GeotabDiagnosticSearch" | Should -HaveParameter 'name' -Type string
            Get-Command "New-GeotabDiagnosticSearch" | Should -HaveParameter 'sourceSearchId' -Type string
            Get-Command "New-GeotabDiagnosticSearch" | Should -HaveParameter 'id' -Type string
        }

    }

    BeforeAll {
        
        # arrange
        $Expected = [pscustomobject]@{
            code = 'code'
            diagnosticType = 'None'
            name = 'name'
            sourceSearchId = '123'
            id = 'b1234'
        }

    }

    Context "Pipeline" {
        it "creates a DiagnosticSearch object" {
            # act
            $Actual = $Expected | New-GeotabDiagnosticSearch

            # assert
            $Actual.code | Should -Be $Expected.code
            $Actual.diagnosticType | Should -Be $Expected.diagnosticType
            $Actual.name | Should -Be $Expected.name
            $Actual.sourceSearchId | Should -Be $Expected.sourceSearchId
            $Actual.id | Should -Be $Expected.id
        }
    }

}
