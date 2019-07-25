function Get-UserGroup {
param ($who = (Read-Host -Prompt "Enter Username"))
$data = (Get-ADUser -Identity $who -Properties memberof).memberof
Foreach($d in $data){Get-ADGroup -Identity $d | Select-Object name} 
}