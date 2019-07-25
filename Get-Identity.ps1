function Get-Identity {
Param (
    $who = (Read-Host -Prompt "Enter Employee Name")
    )
Get-ADUser -Filter * -Properties DisplayName,EmailAddress | Where-Object {$_.DisplayName -match "$who"} | Select-Object Displayname,SamAccountName,EmailAddress,DistinguishedName
}