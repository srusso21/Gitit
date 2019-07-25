Connect-Office365 -Service MSOnline -MFA
Get-MsolAccountSku
Get-MsolUser -All | Where-Object {(($_.licenses).AccountSkuId -match "STANDARDPACK" -or ($_.licenses).AccountSkuId -match "ENTERPRISEPACK")} | select Displayname,UserPrincipalName,Licenses 