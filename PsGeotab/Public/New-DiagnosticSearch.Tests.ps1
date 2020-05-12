$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'
. "$here\$sut"

Describe "New-DiagnosticSearch" -Tag 'unit' {

    Context "Parameter validation" {
        it "has 5, optional parameters" {
            Get-Command "New-DiagnosticSearch" | Should -HaveParameter 'code' -Type string
            Get-Command "New-DiagnosticSearch" | Should -HaveParameter 'diagnosticType' -Type string
            Get-Command "New-DiagnosticSearch" | Should -HaveParameter 'name' -Type string
            Get-Command "New-DiagnosticSearch" | Should -HaveParameter 'sourceSearchId' -Type string
            Get-Command "New-DiagnosticSearch" | Should -HaveParameter 'id' -Type string
        }
    }

    # arrange
    $Expected = [pscustomobject]@{
        code = 'code'
        diagnosticType = 'None'
        name = 'name'
        sourceSearchId = '123'
        id = 'b1234'
    }

    Context "Pipeline" {
        it "creates a DiagnosticSearch object" {
            # act
            $Actual = $Expected | New-DiagnosticSearch

            # assert
            $Actual.code | Should -Be $Expected.code
            $Actual.diagnosticType | Should -Be $Expected.diagnosticType
            $Actual.name | Should -Be $Expected.name
            $Actual.sourceSearchId | Should -Be $Expected.sourceSearchId
            $Actual.id | Should -Be $Expected.id
        }
    }

}
