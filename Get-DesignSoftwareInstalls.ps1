$s18 = Get-ChildItem "\\wma-arch.com\irvine\Temp\Apps\Sketchup\2018"
$s19 = Get-ChildItem "\\wma-arch.com\irvine\Temp\Apps\Sketchup\2019"
$a   = Get-ChildItem "\\wma-arch.com\irvine\Temp\Apps\Adobe"
$l85 = Get-ChildItem "\\wma-arch.com\irvine\Temp\Apps\Lumion\8.5"

$AllUsersandEmails = (Get-ADUser -Properties emailaddress -Filter *)

$list1 = $s18 | ForEach-Object {ConvertFrom-String -InputObject $_ -Delimiter "_" -PropertyNames "Name","Workstation"} 
$list2 = $s19 | ForEach-Object {ConvertFrom-String -InputObject $_ -Delimiter "_" -PropertyNames "Name","Workstation"}
$list3 = $a   | ForEach-Object {ConvertFrom-String -InputObject $_ -Delimiter "_" -PropertyNames "Name","Workstation"}
$list4 = $l85 | ForEach-Object {ConvertFrom-String -InputObject $_ -Delimiter "_" -PropertyNames "Name","Workstation"}

$list1names = $list1.name
$list2names = $list2.name
$list3names = $list3.name
$list4names = $list4.name

$s18emails = Foreach($1 in $list1names){
$AllUsersandEmails | Where-Object {$_.samaccountname -eq $1 -and $_.samaccountname -ne "Srusso"  -and $_.samaccountname -ne "kcontrera" -and $_.samaccountname -ne "jhodges" -and $_.samaccountname -ne "cevans" -and $_.samaccountname -ne "alabastida"} | select -ExpandProperty emailaddress
}
$s19emails = Foreach($2 in $list2names){
$AllUsersandEmails | Where-Object {$_.samaccountname -eq $2 -and $_.samaccountname -ne "Srusso"  -and $_.samaccountname -ne "kcontrera" -and $_.samaccountname -ne "jhodges" -and $_.samaccountname -ne "cevans" -and $_.samaccountname -ne "alabastida"} | select -ExpandProperty emailaddress
}
$aemails = Foreach($3 in $list3names){
$AllUsersandEmails | Where-Object {$_.samaccountname -eq $3 -and $_.samaccountname -ne "Srusso"  -and $_.samaccountname -ne "kcontrera" -and $_.samaccountname -ne "jhodges" -and $_.samaccountname -ne "cevans" -and $_.samaccountname -ne "alabastida"} | select -ExpandProperty emailaddress
}
$l85emails = Foreach($4 in $list4names){
$AllUsersandEmails | Where-Object {$_.samaccountname -eq $4 -and $_.samaccountname -ne "Srusso"  -and $_.samaccountname -ne "kcontrera" -and $_.samaccountname -ne "jhodges" -and $_.samaccountname -ne "cevans" -and $_.samaccountname -ne "alabastida"} | select -ExpandProperty emailaddress
}
Write-Host -ForegroundColor DarkYellow 'Use $s18emails for Sketchup2018 emails'
Write-Host -ForegroundColor Magenta 'Use $s19emails for Sketchup2019 emails'
Write-Host -ForegroundColor Green 'Use $aemails for Adobe emails'
Write-Host -ForegroundColor Yellow 'Use $l85emails for Lumion8.5 emails'