Function Install-Mitel_Remotely {
Param(
$ComputerName = (Read-Host "Enter Computer Name")
)
#$registryPath1 = "HKCU:\Software\ShoreTel\Client"
#$registryPath2 = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Run"
$Session = New-PSSession -ComputerName $ComputerName
$FileLocation = "C:\Temp"
#If((Test-Connection -ComputerName $ComputerName -Count 1 -BufferSize 16 -Quiet) -eq $true) {
If((Test-Path "C:\Temp") -eq $false){
New-Item -Path "C:\Temp" -ItemType Directory -Force | Out-Null
}

Write-host "Copying the Necessary Files"

Copy-Item "\\irvshrtel\c$\Install\ShoreTel software\MiVC_Connect_Client_213.100.3570.0\install-win\MitelConnect.exe" -Destination "C:\Temp" -ToSession $Session | Out-Null
#Write-Host "Adding Registry Keys"
#New-Item -Path $registryPath1 -ErrorAction SilentlyContinue
#New-ItemProperty -Path $registryPath2 -Name Mitel -Value "C:\Program Files (x86)\Mitel\Connect\Mitel.exe" -PropertyType String -Force | Out-Null
#New-ItemProperty -Path $registryPath1 -Name Server -Value Irvshrtel -PropertyType String -Force | Out-Null
#New-ItemProperty -Path $registryPath1 -Name Servername -Value irvshrtel -PropertyType String -Force | Out-Null
#New-ItemProperty -Path $registryPath1 -Name AutoLogin -Value 1 -PropertyType DWORD -Force | Out-Null
#New-ItemProperty -Path $registryPath1 -Name IsSSO -Value 1 -PropertyType DWORD -Force | Out-Null
Invoke-Command -Session $Session -ScriptBlock {
Get-Process  | Where-Object {$_.Name -eq 'Mitel' -or $_.Name -eq 'shoretel'} | Stop-Process -Force | Out-Null
Write-Host "Installing Program"
Start-Process -FilePath 'C:\Temp\MitelConnect.exe' -ArgumentList '/S /v/qn' -Wait | Out-Null
Write-Host "Program Installed"
Remove-Item -LiteralPath "C:\Temp\MitelConnect.exe" -Force | Out-Null
Write-Host "Install File Removed"
}
}

