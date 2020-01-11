do{
    $i = 0
$enteredname = Read-Host -Prompt 'Enter Employee Name'
$displayname = Get-ADUser -Filter * -Properties DisplayName | Where-Object {$_.DisplayName -match "$enteredname"} | select -ExpandProperty name


$computers = Get-ADComputer -Filter 'name -like "ws-*"' -Properties description| Where-Object {$_.description -match $displayname -and $_.distinguishedname -notmatch "retired"} | select Name,description
if($displayname.count -gt 1){
    while($i -LT $displayname.count){
		$string = "Press "
		$string += $i+1
		$string += " for "
		$string += $displayname.DisplayName[$i]
		$string += "`n"
		write-host $string
		$i++

}
$answer = read-host "Answer "
$user = $displayname.name[($answer-1)]

if(@($computers).count -eq 1){


}
}while ($true)