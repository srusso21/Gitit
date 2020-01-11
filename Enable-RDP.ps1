Param($comp =(Read-Host -Prompt "Enter Computername"))
try{
If(Test-Connection -ComputerName $comp -BufferSize 8 -Count 1 -Quiet){
Invoke-Command -ComputerName $comp -ScriptBlock {
Set-ItemProperty 'HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server\' -Name "fDenyTSConnections" -Value 0
Set-ItemProperty 'HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp\' -Name "UserAuthentication" -Value 1
Enable-NetFirewallRule -DisplayGroup "Remote Desktop" -PassThru
If((Get-ItemProperty 'HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server\' | select -ExpandProperty fDenyTSConnections) -eq 0){
Write-Host "RDP enabled"
}else{
Write-Host "RDP could not connect to the machine, please look at the script."

}
}
}
}catch{}
