Invoke-Command -ComputerName ws-2115 -ScriptBlock  {

$Autodesk2015 = Get-WmiObject -Class win32_product | Where-Object {$_.name -match 2015}

$Autodesk2015.uninstall()

}