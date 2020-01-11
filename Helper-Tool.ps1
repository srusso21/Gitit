#Identify managers distinguishedname
$bryan = (Get-ADUser bshimoda |select -ExpandProperty distinguishedname)
$jinger = (Get-ADUser jtapia |select -ExpandProperty distinguishedname)

#get users who have the managers above
$usergroup = Get-ADUser -Properties manager,emailaddress,displayname -Filter * | Where-Object {$_.manager -eq $jinger -or $_.manager -eq $bryan} | Select -ExpandProperty name

#Get computers that start with ws- that are not disabled
$computergroup = Get-ADComputer -Properties description -Filter "name -like 'ws-*'" | Where-Object {$_.enabled -ne $false} | Sort-Object -Property name -Descending 

#Build group where it looks for the users name in the description of the computer in AD
$group =  foreach($user in $usergroup){
$computergroup | Where-Object {$_.description -match $user} 
}
#compile list of descriptions of each $user 
$List = $group | select -ExpandProperty description

#Create Object from the list of strings
$List | ForEach-Object {ConvertFrom-String -InputObject $_ -Delimiter " - " -PropertyNames "Name","Model"}

  



