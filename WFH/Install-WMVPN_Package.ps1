$Logonserver = ($env:LOGONSERVER -split "\\")[2]
Invoke-Command -ComputerName $Logonserver -ScriptBlock {
Set-ExecutionPolicy Bypass -Force
Compress-Archive -Path "\\wma-arch.com\r\resour\ITSupport\Software\L2TP_VPN\Zip\*" -DestinationPath "\\wma-arch.com\r\resour\ITSupport\Software\L2TP_VPN\Package.zip" -Force
}