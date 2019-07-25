
(Get-ADUser -Filter *).samaccountname | ForEach-Object {Set-ADUser -Identity $_ -UserPrincipalName "$_@waremalcomb.com"} 

