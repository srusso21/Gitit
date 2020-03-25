#Remove Bad VPNs
Get-VpnConnection -AllUserConnection | Where-Object -FilterScript {$_.connectionstatus -ne 'connected'} | ForEach-Object {
            #If cannot ping serveraddress
            If((Test-Connection $_.serveraddress -Count 1 -BufferSize 8 -Quiet) -eq $false){
                #Remove VPN
                Get-VpnConnection -AllUserConnection -Name $_.name | Remove-VpnConnection -Force
                    }
                }

#find User logged in
#$username = ((Get-WmiObject -Class win32_computersystem | select -ExpandProperty username) -split "wma-arch.com\\")[1]
$username = ([adsi]"LDAP://$(whoami /fqdn)") | select -ExpandProperty sAMAccountName

#find User OU
$OU = ((([adsi]"LDAP://$(whoami /fqdn)").distinguishedname -split ",")[2] -split "OU=")[1]

#Desktop Default
$folderPath1 = "C:\users\$username\desktop"

#Desktop OneDrive 
$folderPath2 = "C:\users\$username\OneDrive - Ware Malcomb\Desktop"

#Desktop Shortcut File
$fileName ="wm vpn.lnk" 

#Shortcut Location 1
$Filepath1 = "$folderPath1\$fileName"

#Shortcut Location 2
$FilePath2 = "$folderPath2\$fileName"

#Validation Logic 
$VL1 = try{Test-Path -Path $Filepath1}catch{}
$VL2 = try{Test-Path -Path $Filepath2}catch{}

#Create Directory if not there
$WorkingDir = "C:\ProgramData\VPN"
If((Test-Path $WorkingDir) -eq $false){New-Item -Path $WorkingDir -ItemType Directory}
Set-Location -Path $WorkingDir

#Assign Regions
$regions = Import-Csv -Path \\wma-arch.com\r\Resour\ITSupport\Software\L2TP_VPN\Regions.csv
$regions | Where-Object {$_.office -eq "$OU"} | select -ExpandProperty region

$rasphone1 = "C:\Windows\System32\rasphone.exe -d 'WM VPN "
$rasphone2 = "'"
$regionalVPN = ''
$rasphone  = "$rasphone1"+"$RegionalVPN"+"$rasphone2"

#Batch Script Name
$name1 = "VPNScript-"
$name2 = ".bat"
$name = "$name1"+"$regionalVPN"+"$name2"

$BatchFile = New-Item -Path ".\$name" -Type File -Force

$BatchFileInstructions       = @(
"@echo off"
"$rasphone"
"timeout /t 5 /nobreak"
"net use R: /d"
"subst R: C:\resour"
"%MAP%")

$BatchFileInstructions | Set-Content -Path .\$name

Get-Content .$name

$DesktopShortcutInstructions = 

$ShortcutArgument1 = ' /c "C:\programdata\VPN\VPNScript-'
$ShortcutArgument2 = '.bat"'
$ShortcutArgument = "$ShortcutArgument1"+"$OU"+"$ShortcutArgument2"

Expand-Archive -Path "C:\Temp\Content.zip" -DestinationPath "C:\Temp" -Force
#Copy-Item -Path "C:\Temp\VPN*.bat" -Destination "C:\ProgramData" -Force
Copy-Item -Path 'C:\Temp\WM VPN.lnk' -Destination $folderPath1 -Force
Copy-Item -Path 'C:\Temp\WM VPN.lnk' -Destination $folderPath2 -Force
Get-Item -Path "C:\Temp\All\*\wm_vpn.exe" | select -ExpandProperty fullname | ForEach-Object {Start-Process -FilePath $_ -WindowStyle Hidden}
Get-NetAdapter | select -ExpandProperty name | ForEach-Object {Disable-NetAdapterBinding -Name $_ -ComponentID ms_tcpip6}
If($VL1){
$Path = Get-ChildItem -Path $folderPath1 -Filter $fileName | Where-Object { $_.Attributes -ne "Directory"} | select -ExpandProperty FullName 
$obj = New-Object -ComObject WScript.Shell 
$link = $obj.CreateShortcut($Path)
#If you need workingdirectory change please uncomment the below line.
$link.WorkingDirectory = "C:\"
$link.Arguments = "$ShortcutArgument"
$link.TargetPath = "C:\Windows\System32\cmd.exe"
$link.Save() 
}
If($VL2){
$Path = Get-ChildItem -Path $folderPath2 -Filter $fileName | Where-Object { $_.Attributes -ne "Directory"} | select -ExpandProperty FullName 
$obj = New-Object -ComObject WScript.Shell 
$link = $obj.CreateShortcut($Path)
#If you need workingdirectory change please uncomment the below line.
$link.WorkingDirectory = "C:\"
$link.Arguments = "$ShortcutArgument"
$link.TargetPath = "C:\Windows\System32\cmd.exe"
$link.Save() 
}