<#
.SYNOPSIS
The object used to specify the arguments when searching for a User/Driver.

.PARAMETER companyGroups	
Search for Users who are a member this GroupSearch. Available GroupSearch options are: Id  Cannot be used with DriverGroups.

.PARAMETER driverGroups
Search for Users who are assigned a Driver Key which is a member of the GroupSearch. Available GroupSearch options are: Id  Cannot be used with CompanyGroups.

.PARAMETER firstName
Search for Users with this first name. Wildcard can be used by prepending/appending "%" to string. Example "%firstName%". This property is negatable. If the first character of this search property is '!', then the API will know to negate the search logic. (e.g. field = "!John%", is equivalent to: WHERE NOT LIKE 'John%')

.PARAMETER fromDate
Search for Users that were active at this date or after. Set to UTC now to search for only currently active (non-archived) users.

.PARAMETER isDriver
Only search for Users who have a Driver Key assigned.

.PARAMETER keyId
Search for a User who is associated with this Driver Key Id.

.PARAMETER keywords
Search for entities that contain specific keywords in all wildcard string-searchable fields.

.PARAMETER lastName
Search for Users with this last name. Wildcard can be used by prepending/appending "%" to string. Example "%lastName%". This property is negatable. If the first character of this search property is '!', then the API will know to negate the search logic. (e.g. field = "!John%", is equivalent to: WHERE NOT LIKE 'John%')

.PARAMETER name
Search for Users with this email/log-on name. Wildcard can be used by prepending/appending "%" to string. Example "%name%". This property is negatable. If the first character of this search property is '!', then the API will know to negate the search logic. (e.g. field = "!John%", is equivalent to: WHERE NOT LIKE 'John%')

.PARAMETER securityGroups
Search for Users who are assigned to a specific Security Clearance which is a member of the GroupSearch. Available GroupSearch options are: Id

.PARAMETER serialNumber
Search for a User who is associated with this Driver Serial Number.

.PARAMETER toDate
Search for Users that were active at this date or before.

.PARAMETER id
Search for an entry based on the specific Id.

.LINK
https://developers.geotab.com/myGeotab/apiReference/objects/UserSearch
#>

function New-GeotabUserSearch {

    [CmdletBinding()]
    param (
        [Parameter(ValueFromPipelineByPropertyName,ParameterSetName='ByCompanyGroup')]
        [string[]]$companyGroup,

        [Parameter(ValueFromPipelineByPropertyName,ParameterSetName='ByDriverGroup')]
        [string[]]$driverGroup,

        [Parameter(ValueFromPipelineByPropertyName)]
        [string]$firstName,

        [Parameter(ValueFromPipelineByPropertyName)]
        [string]$lastName,

        [Parameter(ValueFromPipelineByPropertyName)]
        [string]$name,

        [Parameter(ValueFromPipelineByPropertyName)]
        [datetime]$fromDate,

        [Parameter(ValueFromPipelineByPropertyName)]
        [datetime]$toDate,

        [Parameter(ValueFromPipelineByPropertyName)]
        [bool]$isDriver,

        [Parameter(ValueFromPipelineByPropertyName)]
        [string]$keyId,

        [Parameter(ValueFromPipelineByPropertyName)]
        [string]$keywords,

        [Parameter(ValueFromPipelineByPropertyName)]
        [string[]]$securityGroup,

        [Parameter(ValueFromPipelineByPropertyName)]
        [string]$serialNumber,

        [Parameter(ValueFromPipelineByPropertyName)]
        [string]$id
    )

    begin {}
    process
    {
        $UserSearch = @{}

        if ($companyGroup) { $UserSearch['companyGroup'] = $companyGroup }
        if ($driverGroup) { $UserSearch['driverGroup'] = $driverGroup }
        if ($firstName) { $UserSearch['firstName'] = $firstName }
        if ($lastName) { $UserSearch['lastName'] = $lastName }
        if ($name) { $UserSearch['name'] = $name }
        if ($fromDate) { $UserSearch['fromDate'] = $fromDate }
        if ($toDate) { $UserSearch['toDate'] = $toDate }
        if ($isDriver) { $UserSearch['isDriver'] = $isDriver }
        if ($keyId) { $UserSearch['keyId'] = $keyId }
        if ($keywords) { $UserSearch['keywords'] = $keywords }
        if ($securityGroup) { $UserSearch['securityGroup'] = $securityGroup }
        if ($serialNumber) { $UserSearch['serialNumber'] = $serialNumber }
        if ($id) { $UserSearch['id'] = $id }

        [pscustomobject]$UserSearch
    }
    end {}

}
