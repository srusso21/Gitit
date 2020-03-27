
#Specify Computername
param (
    [Parameter(Mandatory = $True)]$ComputerName
    )

$Logonserver = ($env:LOGONSERVER -split "\\")[2]
Write-Host -ForegroundColor Green "Pinging $ComputerName"

If(Test-Connection -ComputerName $ComputerName -Count 1 -Quiet -BufferSize 8){
    Write-Host -ForegroundColor Green "$ComputerName connected"
    $RemoteUNC = "\\$ComputerName\C$"
    Set-Location -Path $RemoteUNC
    Write-Host -ForegroundColor Green "Checking for Path $RemoteUNC\Temp"
If((Test-Path -Path "$RemoteUNC\Temp") -eq $false){Write-Host -ForegroundColor Green "Created $RemoteUNC\Temp directory"
    New-Item -Path "$RemoteUNC" -ItemType Directory -Name "Temp" -Force}
    Write-Host -ForegroundColor Green "Copying Install-WMVPN.ps1 to $RemoteUNC\Temp"
    #Invoke-Command -ComputerName $Logonserver -ScriptBlock {
    Copy-Item -Path "\\wma-arch.com\r\resour\ITSupport\Software\L2TP_VPN\Install-WMVPN.ps1" -Destination "$RemoteUNC\temp" -Force
    #}
    $Copy1 = Test-Path -Path "$RemoteUNC\temp\Install-WMVPN.ps1"
    If($Copy1){Write-Host -ForegroundColor Green "Script Copy Successful"}
        Write-Host -ForegroundColor Green "Copying Package.zip to $RemoteUNC\Temp"
        #Invoke-Command -ComputerName $Logonserver -ScriptBlock {
        Copy-Item -Path "\\wma-arch.com\r\resour\ITSupport\Software\L2TP_VPN\Package.zip" -Destination "$RemoteUNC\Temp" -Force
        #}
        $Copy2 = Test-Path -Path "$RemoteUNC\temp\Package.zip"
        If($Copy2){Write-Host -ForegroundColor Green "Package Copy Successful"}
            Write-Host -ForegroundColor Green "Beginning VPN install on $ComputerName"
            Invoke-Command -ComputerName $Computername -ScriptBlock {
            Set-ExecutionPolicy -ExecutionPolicy Bypass -Force
            Invoke-Expression -Command "C:\Temp\Install-WMVPN.ps1"
            }
    Set-Location -Path "\\wma-arch.com\r\resour\ITSupport\Software\L2TP_VPN"
}else{
Write-Host -ForegroundColor Green "$ComputerName is not pingable"
}