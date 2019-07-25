
Copy-Item "\\wma-arch.com\r\Resour\ITSupport\Software\HG\Hourglass.exe" -Destination "C:\ProgramData" 
$action  = New-ScheduledTaskAction -Execute cmd.exe -Argument '/c start "" C:\ProgramData\Hourglass.exe'
$trigger = New-ScheduledTaskTrigger -AtLogOn 
Register-ScheduledTask -Action $action -Trigger $trigger -TaskName "Hourglass" -Description "TimesheetChecker"
Start-ScheduledTask -TaskName "hourglass"