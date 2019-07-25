#Lab
#1. Get-CimInstance -ClassName cim_operatingsystem -Property * | select version,osarchitecture
#2. 
#3. 
# Get-cimclass, get-ciminstance, new-ciminstance #Get-CimInstance -CimSession $CimSession -ClassName Win32_GroupUser | Where {$_.GroupComponent.Name -eq 'Administrators'}#Get-CimInstance -CimSession $CimSession -ClassName Cim_OperatingSystem | Select-Object -Property Caption,Version,OSArchitecture#$CimSession = New-CimSession -ComputerName PowershellClassMSsaisoft.westus2.cloudapp.azure.com -Credential (Get-Credential -UserName 'class\ClassAdmin' -Message 'Enter Password')
