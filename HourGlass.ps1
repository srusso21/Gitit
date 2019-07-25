Try{New-PSDrive -Name Software -PSProvider FileSystem -Root \\wma-arch.com\r\Resour\ITSupport\Software\}Catch{}
Copy-Item -Path Software:\HG\Hourglass.exe -Destination "C:\ProgramData"
$action  = New-ScheduledTaskAction -Execute cmd.exe -Argument '/c start "" C:\ProgramData\Hourglass.exe'
$trigger = New-ScheduledTaskTrigger -AtLogOn 
Register-ScheduledTask -Action $action -Trigger $trigger -TaskName "Hourglass" -Description "TimesheetChecker" -ErrorAction SilentlyContinue
Start-ScheduledTask -TaskName "hourglass"