 $Exchange = gwmi -Class win32_product | Where-Object {$_.name -like "*exchange*"}
 Get-Service | Where-Object {$_.name -like "*exchange*"} | Stop-service
 Get-process | Where-Object {$_.name -like "*exchange*"} | Stop-Process
 $exchange.uninstall()
