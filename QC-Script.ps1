#Function QC-Script {}
#$EnteredComputer = Read-Host -Prompt "Enter Computer Name"
#For Remote
#Try{$ComputerObject = Get-ADComputer -Identity $EnteredComputer}catch{}

#Microsoft Office Version Check
#notes 

$OfficeO365     = "C:\Program Files\Microsoft Office\root\Office16\OUTLOOK.EXE"
$Office2016x32  = "C:\Program Files (x86)\Microsoft Office\Office16\OUTLOOK.EXE"
$Office2016x64  = "C:\Program Files\Microsoft Office\root\Office16\OUTLOOK.EXE"
$Office2013x32  = "C:\Program Files (x86)\Microsoft Office\Office15\OUTLOOK.EXE"
$Office2013x64  = "C:\Program Files\Microsoft Office\Office15\OUTLOOK.EXE"

Write-Host "Checking Office Version"
If(Test-Path -Path $OfficeO365){Write-Host "Office 365 Installed"}
If(Test-Path -Path $Office2016x32){Write-Host "Office 2016x32 Installed"}
If(Test-Path -Path $Office2016x64){Write-Host "Office 2016x64 Installed"}
If(Test-Path -Path $Office2013x32){If(){Write-Host "Office 2013x32 Installed"}}
If(Test-Path -Path $Office2013x64){Write-Host "Office 2013x64 Installed"}


Function Check-Outlook{
Write-Host "Checking Office Version"
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
}
Function Check-Mitel

#Mitel Check
Write-Host 'Checking if Mitel is installed'
$MitelPath = "C:\Program Files (x86)\Mitel\Connect\Mitel.exe"
If(Test-Path -Path $Mitel){Write-Host "Mitel Installed"}

#QAP
$QAP_InstallPath  = "\\wma-arch.com\r\Resour\ITSupport\Software\Quick Access Popup\"
$QAP_ProgramPath1 = "C:\Program Files\Quick Access Popup\QuickAccessPopup.exe"
$QAP_Installer    = ".\quickaccesspopup-setup.exe"
$QAP_Args         = "/SP /VERYSILENT"
If((Test-Path -Path $QAP_ProgramPath) -eq $false){
Set-Location -Path $QAP_InstallPath
Start-Process -FilePath "$QAP_Installer" -ArgumentList $QAP_Args -Wait 
Do{timeout /t 5;Test-Path -Path $QAP_ProgramPath | Out-Null}until(Test-Path -Path $QAP_ProgramPath)
If(Test-Path -Path $QAP_ProgramPath){Write-Host "QAP Installed"}
}
<#
#Program Check
Write-Host 'Checking if Program is installed'
$Program = ProgramPath
If(Test-Path -Path $Program){Write-Host "Program Installed"}

#Program Check
Write-Host 'Checking if Program is installed'
$Program = ProgramPath
If(Test-Path -Path $Program){Write-Host "Program Installed"}

#Program Check
Write-Host 'Checking if Program is installed'
$Program = ProgramPath
If(Test-Path -Path $Program){Write-Host "Program Installed"}

#Program Check
Write-Host 'Checking if Program is installed'
$Program = ProgramPath
If(Test-Path -Path $Program){Write-Host "Program Installed"}

#Program Check
Write-Host 'Checking if Program is installed'
$Program = ProgramPath
If(Test-Path -Path $Program){Write-Host "Program Installed"}
#>
