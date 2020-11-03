##
# load (dot-source) *.PS1 files, excluding unit-test scripts (*.Tests.*), and disabled scripts (__*)
#

@("$PSScriptRoot\Public\*.ps1","$PSScriptRoot\Private\*.ps1") | 
    Get-ChildItem -ErrorAction 'Continue' | 
    Where-Object { $_.Name -like '*.ps1' -and $_.Name -notlike '__*' -and $_.Name -notlike '*.Tests*' } | 
    ForEach-Object {

        # dot-source script
        . $_

    }

#
# Create aliases for compatibility
#

Set-Alias -Name 'Get-Session' -Value 'New-GeotabSession'


Register-ArgumentCompleter -CommandName 'Get-GeotabEntity','Set-GeotabEntity' -ParameterName typeName -ScriptBlock {
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameters)

    (Get-GeotabEntityType) | Where-Object {
        $_ -like "$wordToComplete*"
    } | ForEach-Object {
        $_
        #   "'$_'"
    }
}
