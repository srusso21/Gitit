$Credential = Get-Credential -Credential wma-arch.com\srusso
Invoke-Command -ComputerName (Read-Host -Prompt "What computer?") -Credential $Credential -ScriptBlock{
$sophos = Get-WmiObject -Class win32_product | Where-Object {$_.vendor -like "sophos*"}
Get-Process | Where-Object {$_.vendor -like "sophos*"} | Stop-Process
Get-Service | Where-Object {$_.vendor -like "sophos*"} | Stop-Service
$sophos.Uninstall()
}