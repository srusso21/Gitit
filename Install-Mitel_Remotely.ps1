Param(
$ComputerName = (Read-Host "Enter Computer Name")
)

$Session = New-PSSession -ComputerName $ComputerName

Invoke-Command -Session $Session -ScriptBlock {
    Remove-Item -Path "C:\temp" -Force -Recurse -ErrorAction SilentlyContinue
    New-Item -Path "C:\Temp\" -ItemType Directory -Force | Out-Null
}
Write-host "Copying the Necessary Files"
Copy-Item "\\irvshrtel\c$\Install\ShoreTel software\MiVC_Connect_Client_213.100.3570.0\install-win\MitelConnect.exe" -Destination "C:\Temp\" -ToSession $Session | Out-Null    
Invoke-Command -Session $Session -ScriptBlock {    
    Get-Process  | Where-Object {$_.Name -eq 'Mitel' -or $_.Name -eq 'shoretel'} | Stop-Process -Force | Out-Null
    Write-Host "Installing Program"
    Start-Process -FilePath 'C:\Temp\MitelConnect.exe' -ArgumentList '/S /v/qn' -Wait | Out-Null
    Write-Host "Program Installed"
    #Remove-Item -LiteralPath "C:\Temp\MitelConnect.exe" -Force | Out-Null
    #Write-Host "Install File Removed"
}
Get-PSSession | Remove-PSSession

