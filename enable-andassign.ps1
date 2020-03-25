$comp='ws-2807'

Enable-RDP -ComputerName $comp 
Assign-WMComputer -ComputerName $comp -UserName srusso
Assign-WMComputer -ComputerName $comp