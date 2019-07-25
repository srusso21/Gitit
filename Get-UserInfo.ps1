function Get-UserInfo {
Param ($who = (Read-Host -Prompt "Enter Employee Name"))
    $user = Get-ADUser -Filter * -Properties DisplayName,EmailAddress | Where-Object {$_.DisplayName -match "$who"}
    $comp = Get-ADComputer -Filter * -Properties Description | Where-Object {$_.Description -match "$who" -and $_.distinguishedname -notmatch "retired"}
    
    New-Object -TypeName PSObject -Property @{
                UserDisplayName           = $user.DisplayName 
                UserSamAccountName        = $user.SamAccountName
                UserEmailAddress          = $user.EmailAddress
                UserDistinguishedName     = $user.DistinguishedName
                ComputerName              = $comp.Name
                ComputerDescription       = $comp.Description
                ComputerDistinguishedname = $comp.Distinguishedname
    } | Select-Object UserDisplayName,UserSamAccountName,UserEmailAddress,UserDistinguishedName,ComputerName,ComputerDescription,ComputerDistinguishedname
}
