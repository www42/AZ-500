
Connect-AzureAD
Get-AzureADTenantDetail | Format-List DisplayName, `
    @{n="TenantId";e={$_.ObjectId}}, `
    @{n="VerifiedDomains";e={$_.VerifiedDomains.Name}} 

Get-AzureADUser | Format-Table DisplayName,userPrincipalName,UserType,ObjectId

Get-AzureADMSRoleDefinition | Sort-Object DisplayName | Format-Table DisplayName,Description
$Role = Get-AzureADMSRoleDefinition -Filter "displayName eq 'Billing Administrator'"
$Role.RolePermissions.AllowedResourceActions

