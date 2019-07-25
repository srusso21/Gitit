
Invoke-Command -ComputerName irvdc2 -ScriptBlock {repadmin /replicate "Irvdc2" "irvdc1" 'DC=wma-arch,DC=com'}
