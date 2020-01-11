Function Reset-Signature {$application = "Outlook"
Write-Host "Closing $application"
Get-Process | Where-Object {$_.name -match "$application"} | Stop-Process -Force | Out-Null
$sig = "$env:appdata\Microsoft\Signatures"
Remove-Item -Recurse -Force $sig
explorer $env:map
Do{
timeout /t 20 | Out-Null
Test-Path $sig

}until(Test-Path $sig)

Try{
$path1 = "C:\Program Files (x86)\Microsoft Office\Office14\OUTLOOK.EXE"
$path2 = "C:\Program Files (x86)\Microsoft Office\Office15\OUTLOOK.EXE"
$path3 = "C:\Program Files\Microsoft Office\Office15\OUTLOOK.EXE"
$path4 = "C:\Program Files (x86)\Microsoft Office\Office14\OUTLOOK.EXE"
$path5 = "C:\Program Files\Microsoft Office\root\Office16\OUTLOOK.EXE"

#2010 x32
If(Test-Path -Path $path1){$outlook = $path1} 
#2013 x32
If(Test-Path -Path $path2){$outlook = $path2}
#2013 x64
If(Test-Path -Path $path3){$outlook = $path3} 
#2016 x32
If(Test-Path -Path $path4){$outlook = $path4} 
#2016 x64
If(Test-Path -Path $path5){$outlook = $path5} 
}Catch{}
Start-Process -FilePath "$outlook"
}
