# ByPropertyName    # One Property to One Parameter    [PSCustomObject]@{Name = 'WinRM'} | Stop-Service    # Binds the Name Property on a custom object to the Name Parameter through the pipeline on Stop-Service# ByValue    # One Object to One Parameter    [System.ServiceProcess.ServiceController]::new('WinRM') | Stop-Service    # Binds the ServiceController Object to the -InputObject Parameter through the pipeline on Stop-Service
# Do not use Format-Table in Scripting

#Lab 1
#1. Get-Process | where-object {$_.Id -gt 3000}
#2. Get-ADUser -Identity srusso -Properties * | select *
#2.Get-ADUser -Filter{samaccountname -eg "srusso"}
#3. Get-Service | Where-Object {$_.Status -eq "stopped"} | select -last 10

#Lab 2
#1. New-Item -Path "c:\" -Name "RemotingFile_Yousef.txt" -Value "This is a remoting test file"
#2. Invoke-Command -ComputerName PowershellClassMSsaisoft.westus2.cloudapp.azure.com -Credential 'class\ClassAdmin' -ScriptBlock {Get-Content 'C:\remotingtest-moses.txt'}
