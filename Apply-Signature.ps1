function Apply-Signature {
#Identify Outlook

$path1    = "C:\Program Files (x86)\Microsoft Office\Office14\OUTLOOK.EXE"
$path2    = "C:\Program Files (x86)\Microsoft Office\Office15\OUTLOOK.EXE"
$path3    = "C:\Program Files\Microsoft Office\Office15\OUTLOOK.EXE"
$path4    = "C:\Program Files (x86)\Microsoft Office\Office16\OUTLOOK.EXE"
$path5    = "C:\Program Files\Microsoft Office\root\Office16\OUTLOOK.EXE"

#select the name of the signatures you would like to apply
#$NewSigName   = "WM Signature WM HTML"
#$ReplySigName = "WM Signature WM HTML - Reply"
$NewSigName   = "WM Signature"
$ReplySigName = "WM Signature - Reply"

#2010 x32
If(Test-Path -Path $path1){Write-host "Office 2010 Installed";$Regpath1 = "HKCU:\Software\Microsoft\Office\14.0\Outlook\Setup";$RegPath2 = "HKCU:\Software\Microsoft\Office\14.0\Common\MailSettings"} 
#2013 x32
If(Test-Path -Path $path2){Write-host "Office 2013 x32 Installed";$Regpath1 = "HKCU:\Software\Microsoft\Office\15.0\Outlook\Setup";$RegPath2 = "HKCU:\Software\Microsoft\Office\15.0\Common\MailSettings"}
#2013 x64
If(Test-Path -Path $path3){Write-host "Office 2013 x64 Installed";$Regpath1 = "HKCU:\Software\Microsoft\Office\15.0\Outlook\Setup";$RegPath2 = "HKCU:\Software\Microsoft\Office\15.0\Common\MailSettings"} 
#2016 x32
If(Test-Path -Path $path4){Write-host "Office 2016 x32 Installed";$Regpath1 = "HKCU:\Software\Microsoft\Office\16.0\Outlook\Setup";$RegPath2 = "HKCU:\Software\Microsoft\Office\16.0\Common\MailSettings"} 
#2016 x64
If(Test-Path -Path $path5){
Write-host "Office 2016 x64 Installed";
$Regpath1 = "HKCU:\Software\Microsoft\Office\16.0\Outlook\Setup";
$RegPath2 = "HKCU:\Software\Microsoft\Office\16.0\Common\MailSettings"} 

#remove existing signature names from registry
Remove-ItemProperty -Path $RegPath2 -Name "NewSignature"
Remove-ItemProperty -Path $RegPath2 -Name "ReplySignature"


#1st Action – Close Outlook.exe process
$application = "Outlook"
Write-Host "Closing $application"
Get-Process | Where-Object {$_.name -match "$application"} | Stop-Process -Force | Out-Null
Write-Host "$application Closed"
<#2nd Action – Copy Signature files#>
$sig = "$env:appdata\Microsoft\Signatures"
#Deleting Current Signatures
Remove-Item -Recurse -Force $sig
explorer $env:map
Do{
timeout /t 5 | Out-Null
Test-Path $sig | Out-Null
}until(Test-Path $sig)

Try{Remove-ItemProperty -Path $Regpath1 -Name "First-Run"}Catch{}

New-ItemProperty -Path "$RegPath2" -Name "NewSignature" -Value "$NewSigName"
New-ItemProperty -Path "$RegPath2" -Name "ReplySignature" -Value "$ReplySigName"



New-ItemProperty -Path "HKCU:\Software\Microsoft\Office\16.0\Common\MailSettings" -Name "NewSignature" -Value "WM Signature"
New-ItemProperty -Path "HKCU:\Software\Microsoft\Office\16.0\Common\MailSettings" -Name "ReplySignature" -Value "WM Signature - Reply"

New-ItemProperty -Path "$RegPath2" -Name "ReplySignature" -Value "$ReplySigName"


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
Apply-Signature
