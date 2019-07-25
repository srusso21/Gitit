$OU = 'OU=Denver,'
(Get-ADUser -Filter * | Where-Object {$_.distinguishedname -match $OU}).samaccountname | ForEach-Object {Set-ADUser -Identity $_ -UserPrincipalName "$_@waremalcomb.com"} 
(Get-ADUser -Filter * | Where-Object {$_.distinguishedname -match $OU}).UserPrincipalName 
