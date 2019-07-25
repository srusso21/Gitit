Param(
$ComputerName = (Read-Host "Enter Computer Name")
)

$Session = New-PSSession -ComputerName $ComputerName

Invoke-Command -Session $Session -ScriptBlock {
    Remove-Item -Path "C:\temp1" -Force -Recurse 
    New-Item -Path "C:\Temp1\" -ItemType Directory -Force | Out-Null
}
Write-host "Copying the Necessary Files"
Copy-Item '\\wma-arch.com\r\Resour\ITSupport\Software\L2TP_VPN' -Destination 'C:\Temp1' -ToSession $Session -Recurse | Out-Null    
Invoke-Command -Session $Session -ScriptBlock {    
    DISM /Online /Enable-Feature /FeatureName:NetFx3 /All | Out-Null
    Write-Host "Installing Program"
    Start-Process -FilePath "C:\Temp\L2TP_VPN\L2TPVPNConfig.exe" -Wait | Out-Null
    Write-Host "Program Installed"
    #Remove-Item -LiteralPath "C:\Temp\MitelConnect.exe" -Force | Out-Null
    #Write-Host "Install File Removed"
}
Get-PSSession | Remove-PSSession

