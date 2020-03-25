#$DenverCivilDesktops = Get-ADComputer -Properties description -Filter 'name -like "ws-*"' | Where-Object {$_.distinguishedname -match 'denver-js' -and $_.distinguishedname -match 'computers'} | select name,description
$allassignedcomputers = Get-ADComputer -Properties description,CanonicalName -Filter 'name -like "ws-*"' | Where-Object {$_.distinguishedname -notmatch 'ws-mac' -and $_.description -match '-' -and $_.description -notmatch 'hotel' -and $_.description -notmatch 'retired' -and $_.description -notmatch 'test' -and $_.description -notmatch 'resource' -and $_.description -notmatch 'jobfair' -and $_.description -notmatch 'job fair' -and $_.description -notmatch 'tvpc' -and $_.description -notmatch 'spare' -and $_.description -notmatch 'available' -and $_.distinguishedname -match 'computers' -and $_.distinguishedname -notmatch 'admin' -and $_.description -ne $null} | Sort-Object CanonicalName | select distinguishedname,name,description 
$allassignedcomputers | Export-Csv 'C:\Temp\Desktop Inventory\FinalListCompanywide.csv' -NoTypeInformation
#$allassignedcomputers | Export-Csv 'C:\Temp\Desktop Inventory\all.csv' -NoTypeInformation
#$allassignedcomputers = Import-Csv 'C:\Temp\Desktop Inventory\all.csv'

#$des = ($allassignedcomputers) | ForEach-Object {
#ConvertFrom-String -InputObject $_.description -Delimiter " - " -PropertyNames "User","Model"
#}
#$des | Export-Csv 'C:\Temp\Desktop Inventory\all1.csv' -NoTypeInformation