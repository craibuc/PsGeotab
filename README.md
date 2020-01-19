# PsGeotab
PowerShell module that wraps the Geotab API.

## Installation

### Git

``` powershell
# change to Module directory
PS> Push-Location ~\Documents\WindowsPowerShell\Modules

# clone repository
PS> git clone git@github.com:craibuc/PsGeotab.git

# return to original location
PS> Pop-Location
```

### Manual

- Get the latest version of the file from `https://github.com/craibuc/PsGeotab/releases`
- Unzip the archive
- Rename the directory to `PsGeotab`
- Move the directory to `~\Documents\WindowsPowerShell\Modules`

```powershell
# get latest version of module
#Invoke-WebRequest -Uri 'https://github.com/craibuc/PsGeotab/releases/latest' -OutFile ~\Downloads\PsGeotab.zip

# unzip
#Expand-Archive ~\Downloads\PsGeotab.zip

#rename
#PS> Rename-Item -Path PsGeotab-[version] -NewName PsGeotab

# move to Module directory
#PS> Move-Item -Path .\PsGeotab -Destination ~\Documents\WindowsPowerShell\Modules

# unblock module's files
PS> Get-ChildItem -Path . -Recurse | Unblock-File 
```

## Usage

### Get-Session
```powershell
# create a session using the credentials and database provided by Geotab
PS> $Session = Get-Session -Database 'Database' -Credential (Get-Credential)
```
### Get-Device

```powershell
# search for a device by the `Name` property
Get-Device -Session $Session -name '80012%' | 
    # choosing specific properties
    Select-Object vehicleIdentificationNumber, licensePlate, name, vehicleIdentificationNumber, id, serialNumber, deviceType, activeFrom, activeTo | 
    # sort it by `Name`
    Sort-Object name | 
    # format it as CSV
    ConvertTo-Csv | 
    # save it to a file on the current user's desktop
    Out-File "~/Desktop/com.geotab.devices.csv"
```

## Integration Testing

### Save Geotab credentials to file in the module's root diretory.
```powershell
# change to the module's direcoty
PS> Push-Location ~\Documents\WindowsPowerShell\Modules\PsGeotab

# create the credential
PS> $Credential = Get-Credential

# add the database as a custom property
PS> $Credential | Add-Member -NotePropertyName 'Database' -NotePropertyValue 'my_database'

# save the credential to a file
PS> $Credential | Export-CliXml ".\credential.xml"

# return to original location
PS> Pop-Location
```

### Run the integration tests
```powershell
# change to the module's direcoty
PS> Push-Location ~\Documents\WindowsPowerShell\Modules\PsGeotab

# run tests
PS> Invoke-Pester -tag integration

# return to original location (if desired)
PS> Pop-Location
```

## Contributors
- [Craig Buchanan](https://github.com/craibuc/)