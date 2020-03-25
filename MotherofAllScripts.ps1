
$date = ((Get-Date | select -ExpandProperty date) -split " ")[0]
$ComputersList = Get-ADComputer -Filter 'name -like "ws-*"' -Properties CanonicalName,LastLogonDate | Where-Object -FilterScript {$_.lastlogondate -ge (get-date).adddays(-7)} | Sort-Object -Property LastLogonDate -Descending | select -ExpandProperty name
$CompCount = $ComputersList.count
Write-Host -ForegroundColor Green "There are $CompCount computer who have logged in within 7 days of $date"
$connectedList = ForEach($c in $ComputersList){
    If(Test-Connection -ComputerName $c -Quiet -Count 1 -BufferSize 8)
    {$c}
    }
$connectedCount = $connectedList.count
Write-Host -ForegroundColor Green "There are $connectedCount currently connected"
$CopyList = Foreach($connected in $connectedList){
$OU = ((Get-ADComputer -Identity $connected  -Properties CanonicalName).CanonicalName -split "/")[1]
$FilePathOU = "\\wma-arch.com\r\Resour\ITSupport\Software\L2TP_VPN\Distribution\$OU"
Set-Location -Path $FilePathOU
$remotec = "\\$connected\C$"
If((Test-Path "$remotec\temp\Content.zip") -eq $false){Copy-item -Path ".\Content.zip" -Destination "$remotec\temp\" -Force}
If((Test-Path "$remotec\temp\WMVPN.ps1") -eq $false){Copy-item -Path ".\WMVPN.ps1" -Destination "$remotec\temp\" -Force}
}
Write-Host -ForegroundColor Green "Files have been copied"
Write-Host -ForegroundColor Green "Time to run the Scripts"
Invoke-Command -ComputerName $connectedList -ScriptBlock {
    If(((Test-Path -Path "C:\temp\Content.zip" -ErrorAction SilentlyContinue) -and (Test-Path -Path "C:\Temp\WMVPN.ps1" -ErrorAction SilentlyContinue))){
    Set-ExecutionPolicy -ExecutionPolicy Bypass -Force
    #Remove Bad VPNs
    Get-VpnConnection -AllUserConnection | Where-Object -FilterScript {$_.connectionstatus -ne 'connected'} | ForEach-Object {
    #Remove VPN
    Get-VpnConnection -AllUserConnection -Name $_.name | Remove-VpnConnection -Force}
    Set-Location -Path C:\Temp
    .\WMVPN.ps1
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
}
}
