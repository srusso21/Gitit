#Install Script for USA Only

#General
$InstallFolderNetwork      = '\\wma-arch.com\r\Resour\ITSupport\Software\'
$Country                   = 'a'
$2017                      = '2017'
$2018                      = '2018'
$2019                      = '2019'
$LocalDirectory            = "C:\temp\"
$ProgramFiles              = 'C:\Program Files\'
#Part1-Establish Install Folder Paths
#AutoDesk Applications
$Autodesk                  = 'Autodesk'
$AutoCAD                   = 'AutoCAD'       
$Revit                     = 'Revit'
$Img                       = 'Img'
$AutodeskInstallerName     = '.\setup.exe'
#2017 AutoCAD
$2017CADInstallPath        = ($InstallFolderNetwork+$Autodesk+"\"+$AutoCAD+"\"+$AutoCAD+$2017+$Country+"\"+$Img)
$2017CADInstallLocation    = $ProgramFiles+$Autodesk+"\"+$AutoCAD+" "+$2017+"\"+'acad.exe'
$2017CADArgs               = '/qb /I AutoCAD 2017 USA.ini /Trial /language en-us'
#2017 Revit
$2017RevitInstallPath      = ($InstallFolderNetwork+$Autodesk+"\"+$Revit+"\"+$2017+$Country+"\"+"$Img")
$2017RevitInstallLocation  = $ProgramFiles+$Autodesk+"\"+$Revit+" "+$2017+"\"+$Revit+'.exe'
$2017RevitArgs             = '/qb /I Revit 2017 US.ini /Trial /language en-us'
#2019 AutoCAD
$2019CADInstallPath        = ($InstallFolderNetwork+$Autodesk+"\"+$AutoCAD+"\"+$AutoCAD+$2019+$Country+"\"+$Img)
$2019CADInstallLocation    = $ProgramFiles+$Autodesk+"\"+$AutoCAD+" "+$2019+"\"+'acad.exe'
$2019CADArgs               = '/qb /I AutoCAD 2019 USA.ini /Trial /language en-us'
#2019 Revit
$2019RevitInstallPath      = ($InstallFolderNetwork+$Autodesk+"\"+$Revit+"\"+$2019+$Country+"\"+"$Img")
$2019RevitInstallLocation  = $ProgramFiles+$Autodesk+"\"+$Revit+" "+$2019+"\"+$Revit+'.exe'
$2019RevitArgs             = '/qb /I Revit 2019 US.ini /Trial /language en-us'
#Bluebeam 2018.6
$Bluebeam                  = 'Bluebeam'
$BBInstallerFolder         = 'MSIBluebeamRevu18.6.0x64'
$BluebeamInstallPath       = ($InstallFolderNetwork+$Bluebeam+"\"+$BBInstallerFolder)
$BluebeamInstallerName     = 'C:\Windows\system32\msiexec.exe'
$bluebeamArgs              = '/i Bluebeam Revu x64 18.msi BB_SERIALNUMBER=9811547 BB_PRODUCTKEY=WXYE5-1EFDN7A BB_EDITION=1 BB_DEFAULTVIEWER=1 /passive'
#part2-Define local folder

#test if installed

#Install AutoCAD 2017
If((Test-Path "C:\Program Files\Autodesk\AutoCAD 2017\acad.exe") -eq $false){
    Set-Location -Path "$2017CADInstallPath"
    Start-Process -FilePath $AutodeskInstallerName -ArgumentList $2017CADArgs -Wait -Verb RunAs
    do{TIMEOUT /T 10 /NOBREAK | Out-Null}Until((Get-Process -Name setup.exe) -eq $false)
    }
If(Test-Path "C:\Program Files\Autodesk\Revit 2017\Revit.exe") {Write-Host "Revit 2017 is Installed"} 
Else {
    Start-Process -FilePath $AutodeskInstallerName -ArgumentList $2017CADArgs -Wait -Verb RunAs
    do{TIMEOUT /T 10 /NOBREAK | Out-Null}Until((Get-Process -Name setup.exe) -eq $false)
    }
#

#start installing local
#reboot if necessary



    #part3-copy to local
    <#
    
    New-Item -Path ("$LocalDirectory"+"$Foldername") -ItemType Directory -Force
    Set-Location $AutoCADInstallFolder
    Copy-Item -Path ".\$Foldername" -Destination ("$LocalDirectory"+"$foldername") -Force -Recurse -Confirm:$false
    do{

    TIMEOUT /T 5 /NOBREAK | Out-Null
    
    }Until((Test-Path -Path ("$LocalDirectory"+"$Foldername"+"\"+"AutoCAD 2017 USA.lnk")))
    #>
         
        Start-Process -FilePath ".\setup.exe" -ArgumentList "/qb /I AutoCAD 2017 USA.ini /Trial /language en-us" -Wait -Verb RunAs
        do{TIMEOUT /T 10 /NOBREAK | Out-Null}Until((Get-Process -Name setup.exe) -eq $false)
    If(Test-Path "C:\Program Files\Autodesk\AutoCAD 2017\acad.exe" ){
    Write-Host -ForegroundColor Green "Application has been Installed"
    }else{
    Write-Host -ForegroundColor Yellow "Error during Install"
    }
    }
    Write-Host -ForegroundColor Magenta "Application already Installed"
    Write-Host -ForegroundColor Green "Next application"
#If ((Test-PendingReboot).isrebootpending) {
#    Restart-Computer

#Install Revit 2017
If(Test-Path "C:\Program Files\Autodesk\Revit 2017\Revit.exe") {Write-Host "Revit 2017 is Installed"} 
Else {
    Start-Process "$2017RevitInstallPath$AutodeskInstallerName" -ArgumentList (/qb /I "$2017RevitInstallPathAutoCAD 2017 USA.ini" /Trial /language en-us -Wait)
    }

#Install Bluebeam 2018.3
If(Test-Path "C:\Program Files\Bluebeam Software\Bluebeam Revu\2018\Revu\Revu.exe") {Write-Host "BlueBeam 2018 is Installed"} 
Else {
    Start-Process C:\Windows\System32\msiexec.exe -ArgumentList '/i"\\wma-arch.com\r\Resour\ITSupport\Software\BlueBeam\MSIBluebeamRevu18.3.0x64\Bluebeam Revu x64 18.msi" BB_SERIALNUMBER=9811547 BB_PRODUCTKEY=WXYE5-1EFDN7A BB_EDITION=1 /qn' -Wait
    }

#Install Adobe CC
If(Test-Path "C:\Program Files (x86)\Adobe\Adobe Creative Cloud\ACC\Creative Cloud.exe") {Write-Host "Adobe CC is Installed"} 
Else {
    Start-Process "\\wma-arch.com\r\Resour\ITSupport\Software\Adobe\AdobeCC\2018-09-11_AdobeCC\Build\setup.exe" -Wait
    }

#Install Sketchup 2018
If(Test-Path "C:\Program Files\SketchUp\SketchUp 2018\SketchUp.exe") {Write-Host "Sketchup 2018 is Installed"} 
Else {
    Start-Process C:\Windows\System32\msiexec.exe -ArgumentList '/i"\\wma-arch.com\r\Resour\ITSupport\Software\Sketchup\Sketchup2018\SketchUp2018-x64.msi" /passive' -Wait
    }

#"C:\Program Files\Lumion 8.5\Lumion.exe"