$who  = Read-Host -Prompt "Show me who's assign to"
$comp = Get-ADComputer -Filter * -Properties Description | Where-Object {$_.Description -match "$who"}
$comp | select name,description,distinguishedname
<#Enter-PSSession -ComputerName   | ForEach-Object {

    Enter-PSSession -ComputerName $_

}
#>