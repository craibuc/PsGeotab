<#
.SYNOPSIS
Saves Geotab settings to a file in the module's root directory.

.EXAMPLE
PS> .\Save-Settings.ps1

.NOTES
$GeotabSettings = Import-Clixml (Join-Path $Parent 'Settings.Geotab.xml')

#>

# settings' location
$Parent = Split-Path -Path $PSScriptRoot -Parent
$SettingsPath = Join-Path $Parent 'Settings.Geotab.xml'

# settings hash
[pscustomobject]@{
    Credential = Get-Credential -Message 'Supply Geotab credentials'
    Database = Read-Host "Supply the database value"
} | 
# save as Xml
Export-Clixml $SettingsPath

Write-Host "Settings saved to $SettingsPath"
