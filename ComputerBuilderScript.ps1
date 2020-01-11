#Install Script for USA Only
#create user account to install called ComputerBuilder
#add ComputerBuilder account to Registry to auto login

Set-itemProperty -path 'hklm:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\' -name 'DefaultUserName' -value 'CBuilder'
Set-itemProperty -path 'hklm:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\' -name 'DefaultDomainName' -value 'wma-arch.com'
Set-itemProperty -path 'hklm:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\' -name 'AutoAdminLogon' -value '1'
Set-itemProperty -path 'hklm:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\' -name 'DefaultPassword' -value 'W@reM@lcomb1!'

#Install AutoCAD 2017
If(Test-Path "C:\Program Files\Autodesk\AutoCAD 2017\acad.exe") {Write-Host "AutoCAD 2017 is Installed"}
Else {
    Start-Process \\wma-arch.com\r\Resour\ITSupport\Software\AutoDesk\AutoCAD\AutoCAD2017a\Img\setup.exe -ArgumentList "/qb /I \\wma-arch.com\r\Resour\ITSupport\Software\AutoDesk\AutoCAD\AutoCAD2017a\Img\AutoCAD 2017 USA.ini /Trial /language en-us" -Wait
    }

#If ((Test-PendingReboot).isrebootpending) {
#    Restart-Computer

#Install Revit 2017
If(Test-Path "C:\Program Files\Autodesk\Revit 2017\Revit.exe") {Write-Host "Revit 2017 is Installed"}
Else {
    Start-Process \\wma-arch.com\r\Resour\ITSupport\Software\AutoDesk\RevitSeries\2017a\Img\Setup.exe -ArgumentList "/qb /I \\wma-arch.com\r\Resour\ITSupport\Software\AutoDesk\RevitSeries\2017a\Img\Revit 2017 US.ini /Trial /language en-us" -Wait
    }

    #Install AutoCAD 2019
If(Test-Path "C:\Program Files\Autodesk\AutoCAD 2019\acad.exe") {Write-Host "AutoCAD 2019 is Installed"}
Else {
    Start-Process \\wma-arch.com\r\Resour\ITSupport\Software\AutoDesk\AutoCAD\AutoCAD2019a\Img\setup.exe -ArgumentList "/qb /I \\wma-arch.com\r\Resour\ITSupport\Software\AutoDesk\AutoCAD\AutoCAD2019a\Img\AutoCAD 2019 USA.ini /Trial /language en-us" -Wait
    }

#If ((Test-PendingReboot).isrebootpending) {
#    Restart-Computer

#Install Revit 2019
If(Test-Path "C:\Program Files\Autodesk\Revit 2019\Revit.exe") {Write-Host "Revit 2019 is Installed"}
Else {
    Start-Process \\wma-arch.com\r\Resour\ITSupport\Software\AutoDesk\RevitSeries\2019a\Img\Setup.exe -ArgumentList "/qb /I \\wma-arch.com\r\Resour\ITSupport\Software\AutoDesk\RevitSeries\2019a\Img\Revit 2019 US.ini /Trial /language en-us" -Wait
    }

#Install Bluebeam 2018
If(Test-Path "C:\Program Files\Bluebeam Software\Bluebeam Revu\2018\Revu\Revu.exe") {Write-Host "BlueBeam 2018 is Installed"}
Else {
    Start-Process C:\Windows\System32\msiexec.exe -ArgumentList '/i"\\wma-arch.com\r\Resour\ITSupport\Software\BlueBeam\MSIBluebeamRevu18.6.0x64\Bluebeam Revu x64 18.msi" BB_SERIALNUMBER=9811547 BB_PRODUCTKEY=WXYE5-1EFDN7A BB_EDITION=1 /qn' -Wait
    }

<#Install Adobe CC
If(Test-Path "C:\Program Files (x86)\Adobe\Adobe Creative Cloud\ACC\Creative Cloud.exe") {Write-Host "Adobe CC is Installed"}
Else {
    Start-Process "\\wma-arch.com\r\Resour\ITSupport\Software\Adobe\AdobeCC\2018-09-11_AdobeCC\Build\setup.exe" -Wait
    }

#Install Sketchup 2018
If(Test-Path "C:\Program Files\SketchUp\SketchUp 2018\SketchUp.exe") {Write-Host "Sketchup 2018 is Installed"}
Else {
    Start-Process C:\Windows\System32\msiexec.exe -ArgumentList '/i"\\wma-arch.com\r\Resour\ITSupport\Software\Sketchup\Sketchup2018\SketchUp2018-x64.msi" /passive' -Wait
    }
#>
#"C:\Program Files\Lumion 8.5\Lumion.exe"