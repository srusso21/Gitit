$COMPUTERS1 = Get-ADComputer -Filter {name -like 'ws-*'} | select name
Invoke-Command -ComputerName "$COMPUTERS1" -ScriptBlock {Invoke-GPUpdate} 



