Param ($who = (Read-Host -Prompt "Show me who's assign to"))
Invoke-Command -ComputerName $Comp -ScriptBlock {(Get-WmiObject -Class win32_process | Where-Object {$_.name -Match 'explorer'}).getowner().user}
