
Function Check-Computer {

$Installed = @()
$NotInstalled = @()
$Installed += '___Installed___'
$NotInstalled += '___NotInstalled___'
#"AutoCAD 2017"
if(Test-Path -Path 'C:\Program Files\Autodesk\AutoCAD 2017\acad.exe'){
$Installed += "AutoCAD 2017"
}else{
$NotInstalled += "AutoCAD 2017"
}

#"Revit 2017
if(Test-Path -Path 'C:\Program Files\Autodesk\Revit 2017\Revit.exe'){
$Installed += "Revit 2017"
}else{
$NotInstalled += "Revit 2017"
}

#"AutoCAD 2019"
if((Test-Path -Path 'C:\Program Files\Autodesk\AutoCAD 2019\acad.exe')){
$Installed += "AutoCAD 2019"
}else{
$NotInstalled += "AutoCAD 2019"
}

#"Revit 2019"
if(Test-Path -Path 'C:\Program Files\Autodesk\Revit 2019\Revit.exe'){
$Installed += "Revit 2019"
}else{
$NotInstalled += "Revit 2019"
}

#"Mitel"
if(Test-Path -Path 'C:\Program Files (x86)\Mitel\Connect\Mitel.exe'){
$Installed += "Mitel"
}else{
$NotInstalled += "Mitel"
}

#"Bluebeam"
if((Test-Path -Path 'C:\Program Files\Bluebeam Software\Bluebeam Revu\2017\Revu\Revu.exe') -or (Test-Path -Path 'C:\Program Files\Bluebeam Software\Bluebeam Revu\2018\Revu\Revu.exe')){
$Installed += "Bluebeam"
}else{
$NotInstalled += "Bluebeam"
}

#"Microsoft Office"
if((Test-Path -Path 'C:\Program Files\Microsoft Office\root\Office16\OUTLOOK.EXE') -or (Test-Path -Path 'C:\Program Files (x86)\Microsoft Office\Office15\OUTLOOK.EXE') -or (Test-Path -Path 'C:\Program Files (x86)\Microsoft Office\Office14\OUTLOOK.EXE') -or (Test-Path -Path 'C:\Program Files\Microsoft Office\Office15\OUTLOOK.EXE')){
$Installed += "Microsoft Office"
}else{
$NotInstalled += "Microsoft Office"
}

#"Newforma"
if((Test-Path -Path 'C:\Program Files\Newforma\Eleventh Edition\Project Center\ProjectCenter.exe') -or (Test-Path -Path 'C:\Program Files\Newforma\Eleventh Edition\Project Center\ProjectCenter.exe')){
$Installed += "Newforma"
}else{
$NotInstalled += "Newforma"
}

#"Newforma"
if((Test-Path -Path 'C:\Program Files\Newforma\Eleventh Edition\Project Center\ProjectCenter.exe') -or (Test-Path -Path 'C:\Program Files\Newforma\Eleventh Edition\Project Center\ProjectCenter.exe')){
$Installed += "Newforma"
}else{
$NotInstalled += "Newforma"
}

#"Slack"
if(Test-Path -Path "C:\Users\$env:username\AppData\Local\slack\slack.exe"){
$Installed += "Slack"
}else{
$NotInstalled += "Slack"
}

#"7-Zip"
if(Test-Path -Path 'C:\Program Files\7-Zip\7zFM.exe'){
$Installed += "7-Zip"
}else{
$NotInstalled += "7-Zip"
}

#"Chrome"
if(Test-Path -Path 'C:\Program Files (x86)\Google\Chrome\Application\chrome.exe'){
$Installed += "Chrome"
}else{
$NotInstalled += "Chrome"
}

#"Google Earth Pro"
if(Test-Path -Path 'C:\Program Files\Google\Google Earth Pro\client\googleearth.exe'){
$Installed += "Google Earth Pro"
}else{
$NotInstalled += "Google Earth Pro"
}
$Installed
$NotInstalled
}
