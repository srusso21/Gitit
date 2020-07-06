Function Expand-Zips {
param($ZipsDirectory)
$destinationPath = 'C:\temp\'
$ZipsObject = Get-ChildItem -Path $ZipsDirectory | Where-Object {$_.name -like '*.ZIP'}
$Zips = $ZipsObject.name

foreach($zip in $Zips){
$name = ($zip -split ".zip")[0]
New-Item -Path $destinationPath -Name $name -ItemType Directory -Force -ErrorAction SilentlyContinue
If(Test-Path -Path "$destinationPath\$name"){
Expand-Archive -Path $path -DestinationPath "$destinationPath\$name"
}
}
}