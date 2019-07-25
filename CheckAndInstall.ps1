
Function Check-Computer {

$App ="AutoCAD 2017"
if(Test-Path -Path 'C:\Program Files\Autodesk\AutoCAD 2017\acad.exe'){
Write-host "$App is Installed"
}else{
Write-host "$App is not Installed"
Write-Host "$App is being installed"
Start-Process -FilePath "\\wma-arch.com\r\resour\ITSupport\Software\AutoDesk\AutoCAD\AutoCAD2017a\Img\setup.exe" -ArgumentList "/qb /I \\wma-arch.com\r\resour\ITSupport\Software\AutoDesk\AutoCAD\AutoCAD2017a\Img\AutoCAD 2017 USA.ini /Trial /language en-us" -Wait
}
<#
$App ="Revit 2017"
if(Test-Path -Path 'C:\Program Files\Autodesk\Revit 2017\Revit.exe'){
Write-host "$App is Installed"
}else{
Write-host "$App is not Installed"
Write-Host "$App is being installed"
Start-Process -FilePath "" -ArgumentList "" -Wait
}

$App ="AutoCAD 2019"
if((Test-Path -Path 'C:\Program Files\Autodesk\AutoCAD 2019\acad.exe')){
Write-host "$App is Installed"
}else{
Write-host "$App is not Installed"
Write-Host "$App is being installed"
Start-Process -FilePath "" -ArgumentList "" -Wait
}

$App ="Revit 2019"
if(Test-Path -Path 'C:\Program Files\Autodesk\Revit 2019\Revit.exe'){
Write-host "$App is Installed"
}else{
Write-host "$App is not Installed"
Write-Host "$App is being installed"
Start-Process -FilePath "" -ArgumentList "" -Wait
}

$App ="Mitel"
if(Test-Path -Path 'C:\Program Files (x86)\Mitel\Connect\Mitel.exe'){
Write-host "$App is Installed"
}else{
Write-host "$App is not Installed"
Write-Host "$App is being installed"
Start-Process -FilePath "" -ArgumentList "" -Wait
}

$App ="Bluebeam"
if((Test-Path -Path 'C:\Program Files\Bluebeam Software\Bluebeam Revu\2017\Revu\Revu.exe') -or (Test-Path -Path 'C:\Program Files\Bluebeam Software\Bluebeam Revu\2018\Revu\Revu.exe')){
Write-host "$App is Installed"
}else{
Write-host "$App is not Installed"
Write-Host "$App is being installed"
Start-Process -FilePath "" -ArgumentList "" -Wait
}

$App ="Microsoft Office"
if((Test-Path -Path 'C:\Program Files\Microsoft Office\root\Office16\OUTLOOK.EXE') -or (Test-Path -Path 'C:\Program Files (x86)\Microsoft Office\Office15\OUTLOOK.EXE') -or (Test-Path -Path 'C:\Program Files (x86)\Microsoft Office\Office14\OUTLOOK.EXE') -or (Test-Path -Path 'C:\Program Files\Microsoft Office\Office15\OUTLOOK.EXE')){
Write-host "$App is Installed"
}else{
Write-host "$App is not Installed"
Write-Host "$App is being installed"
Start-Process -FilePath "" -ArgumentList "" -Wait
}

$App ="Newforma x64"
if((Test-Path -Path 'C:\Program Files\Newforma\Eleventh Edition\Project Center\ProjectCenter.exe') -or (Test-Path -Path 'C:\Program Files\Newforma\Eleventh Edition\Project Center\ProjectCenter.exe')){
Write-host "$App is Installed"
}else{
Write-host "$App is not Installed"
Write-Host "$App is being installed"
Start-Process -FilePath "" -ArgumentList "" -Write-host "$App is Installed"
}else{
Write-host "$App is not Installed"
Write-Host "$App is being installed"
Start-Process -FilePath "" -ArgumentList "" -Wait
}

$App ="Slack"
if(Test-Path -Path "C:\Users\$env:username\AppData\Local\slack\slack.exe"){
Write-host "$App is Installed"
}else{
Write-host "$App is not Installed"
Write-Host "$App is being installed"
Start-Process -FilePath "" -ArgumentList "" -Wait
}

$App ="7-Zip"
if(Test-Path -Path 'C:\Program Files\7-Zip\7zFM.exe'){
Write-host "$App is Installed"
}else{
Write-host "$App is not Installed"
Write-Host "$App is being installed"
Start-Process -FilePath "" -ArgumentList "" -Wait
}

$App ="Chrome"
if(Test-Path -Path 'C:\Program Files (x86)\Google\Chrome\Application\chrome.exe'){
Write-host "$App is Installed"
}else{
Write-host "$App is not Installed"
Write-Host "$App is being installed"
Start-Process -FilePath "" -ArgumentList "" -Wait
}

$App ="Google Earth Pro"
if(Test-Path -Path 'C:\Program Files\Google\Google Earth Pro\client\googleearth.exe'){
Write-host "$App is Installed"
}else{
Write-host "$App is not Installed"
Write-Host "$App is being installed"
Start-Process -FilePath "" -ArgumentList "" -Wait
}
}
#>