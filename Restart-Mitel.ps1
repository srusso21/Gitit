Function Restart-Mitel {
param (
$remote = (Read-Host -Prompt 'Enter Remote Computer')

)
#Get-Process -Name Mitel | Stop-Process -Force
#Start-Process Mitel
$session = New-PSSession -ComputerName $remote
Invoke-Command -Session $remote -ScriptBlock {Get-Process Mitel | Stop-Process -Force -ErrorAction SilentlyContinue}
Invoke-WmiMethod -ComputerName $remote -Class win32_process -Name create -ArgumentList "C:\Program Files (x86)\Mitel\Connect\Mitel.exe"




}
