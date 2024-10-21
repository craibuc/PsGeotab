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
### Get-GeotabEntity - Device

```powershell
# search for a device by the `Name` property
PS> Get-GeotabEntity -Session $Session -typeName 'Device' -search @{name = '80012%' } | 

    # choosing specific properties
    Select-Object vehicleIdentificationNumber, licensePlate, name, vehicleIdentificationNumber, id, serialNumber, deviceType, activeFrom, activeTo | 

    # sort it by `Name`
    Sort-Object name | 

    # format it as CSV
    ConvertTo-Csv | 

    # save it to a file on the current user's desktop
    Out-File "~/Desktop/com.geotab.devices.csv"
```
### Get-GeotabEntity - Device + StatusData

#### Get the most-recent odometer readings that occured today.

```powershell
# get all devices
PS> Get-GeotabEntity -Session $Session -typeName 'Device' |

    # search diagnostics using defalt parameters
    Search-StatusData -Session $Session | 

    # device id, date of measurement, odometer (miles)
    Select-Object id, dateTime, @{name='odometer'; expression={[math]::Round($_.data * 0.00062137119223733,1)}} | 
    # group by device
    Group-Object deviceId |
    # process each group
    ForEach-Object {

        # select the grouped items (the diagnostics)
        $_.Group | 

        # sort by the date of the reading (newest to oldest)
        Sort-Object -Property dateTime -Descending | 

        # select the first (i.e. most-recent reading)
        Select-Object -First 1
    } |

    # format it as CSV
    ConvertTo-Csv | 

    # save it to a file on the current user's desktop
    Out-File "~/Desktop/com.geotab.odometer.csv"
```

### Search-FuelTaxDetail

```powershell
# create a session
$Session = Get-Session ...

# get a list of devices
Get-GeotabEntity -Session $Session -typeName 'Device' | 

# select the device's `id` property
Select-Object id |

# create a device-search object (the `id` property is passed via pipeline)
New-DeviceSearch | 

# search for fuel-tax details for device within the date range
Search-FuelTaxDetail -Session $Session -FromDate '01/01/2020' -ToDate '03/31/2020 23:59:59' |

# select the desired properties (convert from UTC to local)
Select-Object id, @{name='entertime';expression={([datetime]$_.entertime).ToLocalTime()}}, enterodometer, exitodometer, @{name='exittime';expression={([datetime]$_.exittime).ToLocalTime()}}, jurisdiction | 

# display as a table
Format-Table

```

### Pro Tips

#### Use `$PSDefaultParameterValues` to set a parameter value that is common to multiple functions
```powershell
# rather than this
PS> $Session = Get-Session -Database 'Database' -Credential (Get-Credential)

PS> Get-GeotabEntity -Session $Session -typeName 'Device' | Search-StatusData -Session $Session | ...

# do this
PS> $Session = Get-Session -Database 'Database' -Credential (Get-Credential)

PS> $PSDefaultParameterValues['*:Session'] = $Session

PS> Get-Device | Search-StatusData | ...
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