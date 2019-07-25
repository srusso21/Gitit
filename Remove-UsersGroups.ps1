function Remove-UsersGroups {
$username = Read-Host "Enter Username"
(get-aduser $username -Properties memberof).memberof | ForEach-Object {Remove-ADGroupMember -Identity $_ -Members $username -Confirm:$false}
}