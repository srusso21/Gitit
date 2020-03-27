$ComputerName = Get-WmiObject -Class win32_computersystem | Select-Object -ExpandProperty name
Write-Host -ForegroundColor Green "Checking whether you have the Package in your C:\temp"
Write-Host -ForegroundColor Green "Welcome
-----------------------------------
Workstation Number : $ComputerName
-----------------------------------"
If((Test-Path -Path "C:\temp\Package.zip") -eq $false){
Write-Host -ForegroundColor Green "Checking whether you have the Package in your C:\temp"
$L2TP = "\\wma-arch.com\r\resour\ITSupport\Software\L2TP_VPN\Package.zip"
Copy-Item -Path "$L2TP" -Destination "C:\Temp" -Force
Write-Host -ForegroundColor Green "Package delivered"
}
If(Test-Path -Path "C:\temp\Package.zip"){
Write-Host -ForegroundColor Green "Beginning Install...
-----------------------------------
When the script is complete instruct
the user to To disconnect from the VPN,
then use the WM VPN Desktop Icon to connect
to the VPN from now on.
-----------------------------------"

Write-Host -ForegroundColor Green "Removing Current VPNs"
Get-VpnConnection -AllUserConnection | Where-Object -FilterScript {$_.connectionstatus -ne 'connected'} | ForEach-Object {Get-VpnConnection -AllUserConnection -Name $_.name | Remove-VpnConnection -Force -ErrorAction SilentlyContinue}
Write-Host -ForegroundColor Green "Unzipping the Package.zip"
Expand-Archive -Path "C:\temp\Package.zip" -DestinationPath "C:\Temp" -Force
Write-Host -ForegroundColor Green "-----------------------------------
Copy the batch files to C:\Programdata
to be invoked by the desktop icon
-----------------------------------"
Copy-Item -Path "C:\temp\VPN*.bat" -Destination "C:\ProgramData" -Force

$ConnectedVPN = Get-VpnConnection -AllUserConnection | Where-Object -FilterScript {$_.connectionstatus -eq 'connected'} | Select-Object -ExpandProperty name
Write-Host -ForegroundColor Green "Currently connected to $ConnectedVPN"
Write-Host -ForegroundColor Green "Reinstalling all VPNs, except $ConnectedVPN"
Get-Item -Path "C:\temp\All\*\wm_vpn.exe" | Select-Object -ExpandProperty fullname | ForEach-Object {Start-Process -FilePath $_ -WindowStyle Hidden -ErrorAction SilentlyContinue}
Write-Host -ForegroundColor Green "Disabling IPv6 on all adapters"
Get-NetAdapter | Select-Object -ExpandProperty name | ForEach-Object {Disable-NetAdapterBinding -Name $_ -ComponentID ms_tcpip6}
Write-Host -ForegroundColor Green "Finding the users region"
$userobject = Import-Csv -Path "C:\temp\data.csv"
$Officeobject = Import-Csv -Path "C:\temp\Regions.csv"
$username = ((Get-WmiObject -Class win32_computersystem | Select-Object -ExpandProperty username) -split "wma-arch.com\\")[1]
$OU =  ((($userobject | Where-Object {$_.samaccountname -eq "$username"} | Select-Object -ExpandProperty distinguishedname) -split ',')[2] -split 'OU=')[1]
$Region = $Officeobject | Where-Object {$_.office -eq "$OU"} | Select-Object -ExpandProperty region
Write-Host -ForegroundColor Green "-----------------------------------
Found!
-----------------------------------
Username: $username
OU      : $OU
Region  : $Region
-----------------------------------"
$folderPath1 = "C:\users\$username\desktop"
$folderPath2 = "C:\users\$username\OneDrive - Ware Malcomb\Desktop"
$fileName ="wm vpn.lnk"
$Filepath1 = "$folderPath1\$fileName"
$FilePath2 = "$folderPath2\$fileName"
Write-Host -ForegroundColor Green "Removing old WM VPN connection, if not connected"
Get-VpnConnection -AllUserConnection | Where-Object -FilterScript {$_.name -eq 'WM VPN'} | Remove-VpnConnection -Force
Write-Host -ForegroundColor Green "Checking to see is user signed
into OneDrive and mapped their
desktop which changes the path
breaking any shortcuts, Also whether
they have the desktop shortcut.
-----------------------------------"
$VL1 = Test-Path -Path $Filepath1
$VL2 = Test-Path -Path $FilePath2
$VL3 = If(($VL1 -eq $false) -and ($VL2 -eq $false)){$true}
Write-Host -ForegroundColor Green "Setting the Region for the desktop shortcut"
$linkArgs = '/c "C:\programdata\VPNScript-'+"$Region"+'.bat"'
If($VL1){
Write-Host -ForegroundColor Green "Found a desktop icon in $Filepath1"
Copy-Item -Path 'C:\temp\WM VPN.lnk' -Destination $folderPath1 -Force
$list = Get-ChildItem -Path $folderPath1 -Filter $fileName -Recurse  | Where-Object { $_.Attributes -ne "Directory"} | Select-Object -ExpandProperty FullName
$obj = New-Object -ComObject WScript.Shell
ForEach($lnk in $list)
      {
      $obj = New-Object -ComObject WScript.Shell
      $link = $obj.CreateShortcut($lnk)
      #If you need workingdirectory change please uncomment the below line.
      $link.WorkingDirectory = "C:\"
      $link.Arguments = "$linkArgs"
      $link.TargetPath = "C:\Windows\System32\cmd.exe"
      $link.Save()
  }
}
If($VL2){
Write-Host -ForegroundColor Green "Found a desktop icon in $Filepath2"
Copy-Item -Path 'C:\temp\WM VPN.lnk' -Destination $folderPath2 -Force
$list = Get-ChildItem -Path $folderPath2 -Filter $fileName -Recurse  | Where-Object { $_.Attributes -ne "Directory"} | Select-Object -ExpandProperty FullName
$obj = New-Object -ComObject WScript.Shell
ForEach($lnk in $list)
      {
      $obj = New-Object -ComObject WScript.Shell
      $link = $obj.CreateShortcut($lnk)
      #If you need workingdirectory change please uncomment the below line.
      $link.WorkingDirectory = "C:\"
      $link.Arguments = "$linkArgs"
      $link.TargetPath = "C:\Windows\System32\cmd.exe"
      $link.Save()
  }
}
If($VL3){
If(Test-Path $folderPath2){
Copy-Item -Path 'C:\temp\WM VPN.lnk' -Destination $folderPath2 -Force
$list = Get-ChildItem -Path $folderPath2 -Filter $fileName -Recurse  | Where-Object { $_.Attributes -ne "Directory"} | Select-Object -ExpandProperty FullName
$obj = New-Object -ComObject WScript.Shell
ForEach($lnk in $list)
      {
      $obj = New-Object -ComObject WScript.Shell
      $link = $obj.CreateShortcut($lnk)
      #If you need workingdirectory change please uncomment the below line.
      $link.WorkingDirectory = "C:\"
      $link.Arguments = "$linkArgs"
      $link.TargetPath = "C:\Windows\System32\cmd.exe"
      $link.Save()
  }
}
}else{
Copy-Item -Path 'C:\temp\WM VPN.lnk' -Destination $folderPath1 -Force
$list = Get-ChildItem -Path $folderPath1 -Filter $fileName -Recurse  | Where-Object { $_.Attributes -ne "Directory"} | Select-Object -ExpandProperty FullName
$obj = New-Object -ComObject WScript.Shell
ForEach($lnk in $list)
{
      $obj = New-Object -ComObject WScript.Shell
      $link = $obj.CreateShortcut($lnk)
      #If you need workingdirectory change please uncomment the below line.
      $link.WorkingDirectory = "C:\"
      $link.Arguments = "$linkArgs"
      $link.TargetPath = "C:\Windows\System32\cmd.exe"
      $link.Save()
  }
}

$value = "90"
$VPNList = (Get-VPNConnection -AllUserConnection).name
Write-Host -ForegroundColor Green "Changing the Network Interfaces"
$Interface = Get-NetIPInterface | Where-Object -FilterScript {($_.InterfaceAlias -match "Local Area Connection") -or ($_.InterfaceAlias -match "Ethernet") -or ($_.InterfaceAlias -match "Wi-Fi")} | Select-Object -Property ifIndex,InterfaceAlias,InterfaceMetric | Sort-Object -Property InterfaceMetric
$Interface | Where-Object -FilterScript {$_.InterfaceAlias -match "Wi-Fi"} | Select-Object -ExpandProperty ifIndex | ForEach-Object -Process {Set-NetIPInterface -InterfaceIndex $_ -InterfaceMetric ($value+2)}
$Interface | Where-Object -FilterScript {$_.InterfaceAlias -match "Local Area Connection"} | Select-Object -ExpandProperty ifIndex | ForEach-Object -Process {Set-NetIPInterface -InterfaceIndex $_ -InterfaceMetric ($value+2)}
$Interface | Where-Object -FilterScript {$_.InterfaceAlias -match "Ethernet"} | Select-Object -ExpandProperty ifIndex | ForEach-Object -Process {Set-NetIPInterface -InterfaceIndex $_ -InterfaceMetric ($value+1)}
Write-Host -ForegroundColor Green "Setting up Split Tunneling on all of the VPNs
Adding Routes to each VPN"
$VPNList = (Get-VPNConnection -AllUserConnection).name
ForEach ($Connection in $VPNList){
Set-VpnConnection -SplitTunneling $True -AllUserConnection -TunnelType L2tp -EncryptionLevel Optional -Name $Connection -WarningAction SilentlyContinue
Add-VpnConnectionRoute -ConnectionName $Connection -DestinationPrefix 10.1.0.0/16
Add-VpnConnectionRoute -ConnectionName $Connection -DestinationPrefix 10.1.100.0/24
Add-VpnConnectionRoute -ConnectionName $Connection -DestinationPrefix 10.1.254.0/24
Add-VpnConnectionRoute -ConnectionName $Connection -DestinationPrefix 10.11.0.0/16
Add-VpnConnectionRoute -ConnectionName $Connection -DestinationPrefix 10.11.254.0/24
Add-VpnConnectionRoute -ConnectionName $Connection -DestinationPrefix 10.12.0.0/16
Add-VpnConnectionRoute -ConnectionName $Connection -DestinationPrefix 10.12.254.0/24
Add-VpnConnectionRoute -ConnectionName $Connection -DestinationPrefix 10.13.0.0/16
Add-VpnConnectionRoute -ConnectionName $Connection -DestinationPrefix 10.13.254.0/24
Add-VpnConnectionRoute -ConnectionName $Connection -DestinationPrefix 10.14.0.0/16
Add-VpnConnectionRoute -ConnectionName $Connection -DestinationPrefix 10.15.254.0/24
Add-VpnConnectionRoute -ConnectionName $Connection -DestinationPrefix 10.16.254.0/24
Add-VpnConnectionRoute -ConnectionName $Connection -DestinationPrefix 10.2.0.0/16
Add-VpnConnectionRoute -ConnectionName $Connection -DestinationPrefix 10.20.254.0/24
Add-VpnConnectionRoute -ConnectionName $Connection -DestinationPrefix 10.21.254.0/24
Add-VpnConnectionRoute -ConnectionName $Connection -DestinationPrefix 10.26.0.0/16
Add-VpnConnectionRoute -ConnectionName $Connection -DestinationPrefix 10.27.0.0/16
Add-VpnConnectionRoute -ConnectionName $Connection -DestinationPrefix 10.28.0.0/25
Add-VpnConnectionRoute -ConnectionName $Connection -DestinationPrefix 10.29.0.0/16
Add-VpnConnectionRoute -ConnectionName $Connection -DestinationPrefix 10.29.254.0/24
Add-VpnConnectionRoute -ConnectionName $Connection -DestinationPrefix 10.3.0.0/16
Add-VpnConnectionRoute -ConnectionName $Connection -DestinationPrefix 10.3.254.0/24
Add-VpnConnectionRoute -ConnectionName $Connection -DestinationPrefix 10.4.0.0/16
Add-VpnConnectionRoute -ConnectionName $Connection -DestinationPrefix 10.4.254.0/24
Add-VpnConnectionRoute -ConnectionName $Connection -DestinationPrefix 10.4.26.0/24
Add-VpnConnectionRoute -ConnectionName $Connection -DestinationPrefix 10.5.0.0/16
Add-VpnConnectionRoute -ConnectionName $Connection -DestinationPrefix 10.5.254.0/24
Add-VpnConnectionRoute -ConnectionName $Connection -DestinationPrefix 10.6.0.0/16
Add-VpnConnectionRoute -ConnectionName $Connection -DestinationPrefix 10.6.252.0/24
Add-VpnConnectionRoute -ConnectionName $Connection -DestinationPrefix 10.8.254.0/24
Add-VpnConnectionRoute -ConnectionName $Connection -DestinationPrefix 10.9.0.0/16
Add-VpnConnectionRoute -ConnectionName $Connection -DestinationPrefix 10.9.254.0/24
Add-VpnConnectionRoute -ConnectionName $Connection -DestinationPrefix 192.168.0.0/24
Add-VpnConnectionRoute -ConnectionName $Connection -DestinationPrefix 192.168.1.0/24
Add-VpnConnectionRoute -ConnectionName $Connection -DestinationPrefix 192.168.11.0/24
Add-VpnConnectionRoute -ConnectionName $Connection -DestinationPrefix 192.168.12.0/24
Add-VpnConnectionRoute -ConnectionName $Connection -DestinationPrefix 192.168.13.0/24
Add-VpnConnectionRoute -ConnectionName $Connection -DestinationPrefix 192.168.14.0/24
Add-VpnConnectionRoute -ConnectionName $Connection -DestinationPrefix 192.168.15.0/24
Add-VpnConnectionRoute -ConnectionName $Connection -DestinationPrefix 192.168.16.0/24
Add-VpnConnectionRoute -ConnectionName $Connection -DestinationPrefix 192.168.19.0/24
Add-VpnConnectionRoute -ConnectionName $Connection -DestinationPrefix 192.168.2.0/24
Add-VpnConnectionRoute -ConnectionName $Connection -DestinationPrefix 192.168.20.0/24
Add-VpnConnectionRoute -ConnectionName $Connection -DestinationPrefix 192.168.21.0/24
Add-VpnConnectionRoute -ConnectionName $Connection -DestinationPrefix 192.168.23.0/24
Add-VpnConnectionRoute -ConnectionName $Connection -DestinationPrefix 192.168.24.0/24
Add-VpnConnectionRoute -ConnectionName $Connection -DestinationPrefix 192.168.25.0/24
Add-VpnConnectionRoute -ConnectionName $Connection -DestinationPrefix 192.168.252.0/24
Add-VpnConnectionRoute -ConnectionName $Connection -DestinationPrefix 192.168.253.0/24
Add-VpnConnectionRoute -ConnectionName $Connection -DestinationPrefix 192.168.254.0/24
Add-VpnConnectionRoute -ConnectionName $Connection -DestinationPrefix 192.168.3.0/24
Add-VpnConnectionRoute -ConnectionName $Connection -DestinationPrefix 192.168.4.0/24
Add-VpnConnectionRoute -ConnectionName $Connection -DestinationPrefix 192.168.5.0/24
Add-VpnConnectionRoute -ConnectionName $Connection -DestinationPrefix 192.168.6.0/24
Add-VpnConnectionRoute -ConnectionName $Connection -DestinationPrefix 192.168.8.0/24
Add-VpnConnectionRoute -ConnectionName $Connection -DestinationPrefix 192.168.9.0/24
}
$installedVPNs = Get-VpnConnection -AllUserConnection | Select-Object -ExpandProperty name | ForEach-Object {($_ -split "wm vpn ")[1]}
Write-Host -ForegroundColor Green "-----------------------------------
VPN INSTALL SUCCESSFUL!
-----------------------------------
Instruct the user to disconnect from the
VPN then reconnect using the desktop icon.
-----------------------------------
Currently Installed VPNs: $installedVPNs

"

}
