$Phoenix = (Get-ADComputer -Filter 'name -like "ws-*"' | Where-Object {$_.distinguishedname -match 'phoenix'}).name
$Report = C:\Temp\PhoenixMitelInstall.csv
Foreach($P in $Phoenix) {
if((Test-Connection -ComputerName $P -Quiet) -eq $true){
If((Test-Path -Path "C:\temp\mitelconnect.exe") -eq $true){
    $session = New-PSSession -ComputerName $P
    Invoke-Command -Session $Session -ScriptBlock {
        Get-Process  | Where-Object {$_.Name -eq 'Mitel' -or $_.Name -eq 'shoretel'} | Stop-Process -Force | Out-Null
        Write-Host "Installing Program" | Export-CSV $Report -append
        Start-Process -FilePath 'C:\Temp\MitelConnect.exe' -ArgumentList '/S /v/qn' -Wait | Out-Null
        Write-Host "Program Installed" | Export-CSV $Report -append
        Remove-Item -LiteralPath "C:\Temp\MitelConnect.exe" -Force | Out-Null
        Get-PSSession | Remove-PSSession
        Write-Host "Install File Removed" | Export-CSV $Report -append

    }
}
else{
    Write-Host "Installer will be copied now" | Export-CSV $Report -append
    $session = New-PSSession -ComputerName $P 
    Copy-Item "\\irvshrtel\c$\Install\ShoreTel software\MiVC_Connect_Client_213.100.3570.0\install-win\MitelConnect.exe" -Destination "C:\Temp" -ToSession $Session | Out-Null

    Write-Host "Mitel Installer has been copied to $P Successfully" | Export-CSV $Report -append
    Invoke-Command -Session $Session -ScriptBlock {
        Get-Process  | Where-Object {$_.Name -eq 'Mitel' -or $_.Name -eq 'shoretel'} | Stop-Process -Force | Out-Null
        Write-Host "Installing Program" | Export-CSV $Report -append
        Start-Process -FilePath 'C:\Temp\MitelConnect.exe' -ArgumentList '/S /v/qn' -Wait | Out-Null
        Write-Host "Program Installed" | Export-CSV $Report -append
        Remove-Item -LiteralPath "C:\Temp\MitelConnect.exe" -Force | Out-Null
        Get-PSSession | Remove-PSSession
        Write-Host "Install File Removed" | Export-CSV $Report -append
    }
}
#Send-MailMessage -From srusso@waremalcomb.com -SmtpServer webmail.waremalcomb.com -To srusso@waremalcomb.com -Body "Mitel copied to $P Successfully"
}
Else{
    Write-Host "$P not connected" | Export-CSV $Report -append
    }
}
