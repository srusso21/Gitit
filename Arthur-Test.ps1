$name = "vArthur"
$users = Get-ADUser -Filter * -Properties DisplayName,EmailAddress,Office,Department,Title,HomePhone | Where-Object {$_.DisplayName -match "$name"}
$i = 0

if($users.count -gt 1){
	while($i -LT $users.count){
		$string = "Press "
		$string += $i+1
		$string += " for "
		$string += $users.DisplayName[$i]
		$string += "`n"
		write-host $string
		$i++
	}
	$answer = read-host "Answer "

	$name = $users.DisplayName[($answer-1)]
	$users[($answer-1)]

	$comp = Get-ADComputer -Filter * -Properties Description | Where-Object {$_.Description -match "$name" -and $_.distinguishedname -notmatch "retired"}	
	if($comp -eq $null){
		write-host "There is no computer!"
	} else{$comp}

}

if(@($users).count -eq 1){
	$users
	$comp = Get-ADComputer -Filter * -Properties Description | Where-Object {$_.Description -match "$name" -and $_.distinguishedname -notmatch "retired"}	
	if($comp -eq $null){write-host "There is no computer!"}
	else{$comp}

}
if(@($users).count -eq 0){
	write-host "No users found"
}

