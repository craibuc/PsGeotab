# /PsGeotab
$ProjectDirectory = Split-Path -Path (Split-Path -Path $PSScriptRoot -Parent) -Parent

# /PsGeotab/PsGeotab/Public
$PublicPath = Join-Path $ProjectDirectory "/PsGeotab/Public/"

# /PsGeotab/Tests/Fixtures/
# $FixturesDirectory = Join-Path $ProjectDirectory "/Tests/Fixtures/"

# Search-StatusData.ps1
$sut = (Split-Path -Leaf $PSCommandPath) -replace '\.Tests\.', '.'

# . /PsGeotab/PsGeotab/Public/Search-StatusData.ps1
. (Join-Path $PublicPath $sut)

Describe "Search-GeotabStatusData" {

    It "does something useful" -Skip {
        $true | Should -Be $false
    }

}
