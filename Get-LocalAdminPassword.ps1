param ($computername = (Read-Host -Prompt "Enter Computername"))
(Get-ADComputer -Identity $computername -Properties ms-mcs-admPwd | select ms-mcs-admPwd).'ms-mcs-admPwd'