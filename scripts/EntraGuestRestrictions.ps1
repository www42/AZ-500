# Minimal scopes (permissions)
Connect-MgGraph

Get-MgContext
Get-MgContext | % Scopes

# Scopes (= permissions) can be added cumulatively
$Scopes = @(
    "User.Read.All"
    "Group.Read.All"
)
Connect-MgGraph -Scopes $Scopes
Disconnect-MgGraph

# Guest access permissions
# https://learn.microsoft.com/en-us/entra/identity/users/users-restrict-guest-permissions
Get-MgPolicyAuthorizationPolicy | Format-List

$guri = Get-MgPolicyAuthorizationPolicy | % GuestUserRoleId
switch ($guri) {
    'a0b1b346-4d3e-4e8b-98f8-753987be497' {
        Write-Host "Permission level: Same as member users'"
    }
    '10dae51f-b6af-4016-8d66-8c2a99b929b3' {
        Write-Host "Permission level: Limited access (default)"
    }
    '2af84b1e-32c8-42b7-82bc-daa82404023b' {
        Write-Host "Permission level: Restricted access"
    }
}

Update-MgPolicyAuthorizationPolicy -GuestUserRoleId '10dae51f-b6af-4016-8d66-8c2a99b929b3'

# List all guest users in Entra
$guestUsers = Get-MgUser -Filter "userType eq 'Guest'"
$guestUsers

