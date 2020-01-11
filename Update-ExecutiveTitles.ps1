$Tobin = Get-ADUser tsloane | Select-Object -ExpandProperty samaccountname
$Jay = Get-ADUser jtodisco | Select-Object -ExpandProperty samaccountname
$Ken = Get-ADUser kwink | Select-Object -ExpandProperty samaccountname
$matt = Get-ADUser mbrady | Select-Object -ExpandProperty samaccountname
$larry = Get-ADUser larmstrong | Select-Object -ExpandProperty samaccountname
$LATitle = 'Chairman'
$MBTitle = 'Executive Vice President'
$JTTitle = 'President'
$TSTitle = 'CFO / EVP'
$KWTitle = 'CEO'
Write-Host "Old Titles"
Get-ADUser -Identity $Tobin -Properties title | Select-Object name,title
Get-ADUser -Identity $matt -Properties title | Select-Object name,title
Get-ADUser -Identity $larry -Properties title | Select-Object name,title
Get-ADUser -Identity $Jay  -Properties title | Select-Object name,title
Get-ADUser -Identity $Ken  -Properties title | Select-Object name,title
Write-Host "Setting New Titles"
Set-ADUser -Identity $Tobin -Title $TSTitle
Set-ADUser -Identity $matt -Title $MBTitle
Set-ADUser -Identity $larry -Title $LATitle
Set-ADUser -Identity $Jay -Title $JTTitle
Set-ADUser -Identity $Ken -Title $KWTitle
Write-Host "New Titles"
Get-ADUser -Identity $Tobin -Properties title | Select-Object name,title
Get-ADUser -Identity $matt -Properties title | Select-Object name,title
Get-ADUser -Identity $larry -Properties title | Select-Object name,title
Get-ADUser -Identity $Jay  -Properties title | Select-Object name,title
Get-ADUser -Identity $Ken  -Properties title | Select-Object name,title
