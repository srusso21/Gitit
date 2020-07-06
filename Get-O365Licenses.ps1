#copy Email to clipboard
$Admin = ([adsi]"LDAP://$(whoami /fqdn)").mail
$Admin | clip

#connect to MS Online
Connect-MsolService
$users= Import-Csv "C:\Users\srusso\Downloads\users_6_18_2020 3_40_47 PM.csv"
$final = $users | Where-Object -Property licenses -NE "$null" | Select-Object @{Name='SAMAccountName';Expression={$_.userprincipalname -replace '@waremalcomb.com',''}},licenses,userprincipalname | ForEach-Object {
$userObject = Get-ADUser -Identity $_.samaccountname -Properties office,department,displayname,emailaddress,title | select office,department,displayname,emailaddress,title
$status = Get-MsolUser -UserPrincipalName $_.userprincipalname | Select-Object -ExpandProperty StrongAuthenticationRequirements | select -ExpandProperty state
$Result = [PSCustomObject]@{
Name = $userObject.displayname
Email = $userObject.emailaddress
Title = $userObject.title
Office = $userObject.office
Department = $userObject.department
SAMAccountName = $_.SAMAccountName
licenses = $_.licenses
Status = $status
}
$Result
}
$final
$final | Export-Csv "C:\Users\srusso\OneDrive - Ware Malcomb\Documents\GitHub\O365Licenses.csv" -Force -NoTypeInformation