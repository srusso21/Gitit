function Check-Membership {
$test = Read-host 'Enter SamAccountName'

try{$User = Get-ADUser -Identity $test}catch{}
try{$computer = Get-ADComputer -Identity $test}catch{}

if($user -ne $null){
$groups = Get-ADUser -Properties memberof -Identity $User | Select-Object -ExpandProperty memberof
If($groups.count -ge 2){
foreach($g in $groups){
Get-ADGroup -Identity $g | select -ExpandProperty name
}
}
}
if($computer -ne $null){
$groups1 = Get-ADComputer -Properties memberof -Identity $computer | Select-Object -ExpandProperty memberof
If($groups1.count -ge 2){
foreach($g1 in $groups1){
Get-ADGroup -Identity $g1 | select -ExpandProperty name
}
}
}
}
