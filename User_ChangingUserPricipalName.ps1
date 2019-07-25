
$user = "ruth"
Set-ADUser -Identity $user -UserPrincipalName "$user@waremalcomb.com"
Get-ADUser -Identity $user | select name,userprincipalname