$Admin = ([adsi]"LDAP://$(whoami /fqdn)").mail
$Admin | clip
Connect-MsolService
$all = Get-MsolUser -All | select UserPrincipalName,Licenses
$final = $all | ForEach-Object {
$Result = [PSCustomObject]@{

UPN      =  $_.UserPrincipalName
Licenses =  $_.licenses.AccountSkuId

}

$result
}
$E3 = $final| where {$_.Licenses -ne $null -and $_.Licenses -match "waremalcomb:ENTERPRISEPACK"}
$E1 = $final| where {$_.Licenses -ne $null -and $_.Licenses -match "waremalcomb:standardPACK"}
$Dynamics = $final| where {$_.Licenses -ne $null -and $_.Licenses -match "waremalcomb:DYN365" }



