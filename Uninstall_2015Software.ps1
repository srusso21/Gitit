

$Software = Get-WmiObject -Class Win32_product 
$2015 = $Software | Where-Object {$_.name -match '2015'} 
$2015.uninstall()
