$Murillo = Get-ADUser EMurillo | Select-Object -ExpandProperty samaccountname
$Bello = Get-ADUser hbello | Select-Object -ExpandProperty samaccountname

$BelloTitle = 'Job Captain'
$MurilloTitle = 'Production Coordinator'

Write-Host "Old Titles"

Get-ADUser -Identity $Bello -Properties title | Select-Object name,title
Get-ADUser -Identity $Murillo -Properties title | Select-Object name,title

Write-Host "Setting New Titles"

Set-ADUser -Identity $Bello -Title $BelloTitle
Set-ADUser -Identity $Murillo -Title $MurilloTitle 

Write-Host "New Titles"

Get-ADUser -Identity $Bello -Properties title | Select-Object name,title
Get-ADUser -Identity $Murillo -Properties title | Select-Object name,title
