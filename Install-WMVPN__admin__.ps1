
Set-Location -Path "C:\"
$Temp = "C:\Temp\"
If(Test-Path -Path $Temp){New-Item -Path "C:\" -ItemType Directory -Name "Temp" -Force}
$Report = "_VPN_reporting"
Set-Location -Path $Temp
If((Test-Path -Path "C:\Temp\$Report") -eq $false){New-Item -Path $Temp -ItemType Directory -Name "$Report"}
$date = ((Get-Date | select -ExpandProperty date) -split " ")[0]
$ComputersList = Get-ADComputer -Filter 'name -like "ws-*"' -Properties CanonicalName,LastLogonDate | Where-Object -FilterScript {$_.lastlogondate -ge (get-date).adddays(-7)} | Sort-Object -Property LastLogonDate -Descending | select -ExpandProperty name
$ComputersList | Export-Csv -Path "C:\Temp\$Report\ComputerList.csv" -NoTypeInformation -Force
$CompCount = $ComputersList.count
Write-Host -ForegroundColor Green "There are $CompCount computer who have logged in within 7 days of $date"
$connectedList = ForEach($c in $ComputersList){
    If(Test-Connection -ComputerName $c -Quiet -Count 1 -BufferSize 8)
    {$c}
    }
$connectedCount | Export-Csv -Path "C:\Temp\$Report\connectedList.csv" -NoTypeInformation -Force
$connectedCount = $connectedList.count
Write-Host -ForegroundColor Green "There are $connectedCount currently connected" -Force
Write-Host -ForegroundColor Green "Setting the Execution Policy on the connected machines"
Invoke-Command -ComputerName $connectedList -ScriptBlock {Set-ExecutionPolicy -ExecutionPolicy Bypass -Force}
Write-Host -ForegroundColor Green "Installing the VPN on all the $connectedCount connected machines"
Invoke-Command -FilePath C:\Temp\Install-WMVPN.ps1 -ComputerName $connectedList  | Export-Csv -Path "C:\Temp\$Report\RunningList.csv" -NoTypeInformation -Force