function Get-Manager {
Param ($who = (Read-Host -Prompt "Enter Employee Name"))
   $user = Get-ADUser -Filter * -Properties Manager,displayname | Where-Object {$_.DisplayName -match "$who"} | select Name,Manager
   $user
   }