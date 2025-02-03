# Lab 01: Mange user roles
# Exercise 1 - Create a new user and test their application admin rights
# ========================================================================

# Connect to tenant
# ----------------------------
Connect-AzureAD
$tenantDetails = Get-AzureADTenantDetail
$tenantDetails | Format-List DisplayName, `
    @{n="TenantId";e={$_.ObjectId}}, `
    @{n="VerifiedDomains";e={$_.VerifiedDomains.Name}} 

$domainName = Get-AzureADDomain | ? IsDefault -eq $true | % Name
    

# All users
# ----------------------------
Get-AzureADUser | Measure-Object 
Get-AzureADUser | Sort-Object Displayname | Format-Table DisplayName,UserPrincipalName,UserType,ObjectId
    
# New user Chris Green
# ----------------------------
$passwordProfile = New-Object -TypeName Microsoft.Open.AzureAD.Model.PasswordProfile
$passwordProfile.Password = ''
$params = @{
    GivenName = 'Chris'
    Surname = 'Green'
    DisplayName = 'Chris Green'
    UserPrincipalName = "ChrisG@$DomainName"
    MailNickname = 'Chris'
    UsageLocation = 'DE'
    AccountEnabled = $true
    PasswordProfile = $PasswordProfile
}
$user = New-AzureADUser @params


# Remove-AzureAdUser -ObjectId $User.ObjectId

# Exercise 2 - Assign the application admin role and create an app
# ========================================================================

# Built in tenant roles
# ----------------------------
Get-AzureADMSRoleDefinition | Measure-Object
Get-AzureADMSRoleDefinition | Sort-Object DisplayName | Format-Table DisplayName,Description


# Permission of a tenant role
# ----------------------------
# $RoleDisplayName = 'Billing Administrator'
$roleDisplayName = 'Application Administrator'
$roleDisplayName = 'Global Administrator'
$roleDisplayName = 'User Administrator'

$role = Get-AzureADMSRoleDefinition -Filter "displayName eq '$($RoleDisplayName)'"
$role.RolePermissions.AllowedResourceActions


# Role assignments
# ----------------------------
Get-AzureADMSRoleAssignment -Filter "roleDefinitionId eq '$($Role.Id)'"

$roleAssignment = New-AzureADMSRoleAssignment -RoleDefinitionId $Role.Id -PrincipalId $User.ObjectId -DirectoryScopeId '/' 


# Exercise 2 - Remove a role assignment
# ========================================================================

Remove-AzureADMSRoleassignment -Id $RoleAssignment.Id


