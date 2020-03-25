$installer = 'WareMalcomb_FamilyBrowser_v1.11_2019.exe'
$zip = 'WM Browser.zip'
$source = '\\wma-arch.com\r\Resour\Revit\Support\Applications\Family_Browser\'
$destination = 'C:\ProgramData\WM Browser'
$InstallPath1 = 'C:\ProgramData\Autodesk\Revit\Addins\2019\WareMalcomb\WareMalcomb_FamilyBrowser.dll'
If(Test-Path "C:\ProgramData\Autodesk\Revit\Addins\2019\WareMalcomb\unins000.exe"){
        Start-Process -FilePath "C:\ProgramData\Autodesk\Revit\Addins\2019\WareMalcomb\unins000.exe" -ArgumentList "/Silent" -Wait
        Write-Host -ForegroundColor Green "Old version uninstalled"
        }
Set-Location -Path C:\ProgramData\
New-Item -ItemType Directory -Name "WM Browser" -Force -ErrorAction SilentlyContinue | Out-Null 
Set-Location -Path $destination
Copy-Item -Path (($source)+($zip)) -Destination $destination -Force
Copy-Item -Path (($source)+($installer)) -Destination $destination -Force
If((Test-Path 'C:\ProgramData\WM Browser\Images') -eq $false){
    Expand-Archive -Path ".\$zip" -DestinationPath $destination
    }
If((Get-Process -Name 'revit' -ErrorAction SilentlyContinue)){
    Write-Host -ForegroundColor Yellow "Please close Revit"
    Do{
        TIMEOUT /T 3 /NOBREAK | Out-Null
    }Until((Get-Process -Name 'revit' -ErrorAction SilentlyContinue) -eq $null)
    }
$ProcessActive = Get-Process Revit -ErrorAction SilentlyContinue
If($ProcessActive -eq $null){
    Start-Process -FilePath ".\$installer" -ArgumentList "/SP- /SILENT /NORESTART" -Wait
    Remove-Item -Path 'C:\ProgramData\WM Browser\WareMalcomb_FamilyBrowser_v1.11_2019.exe' -Force -Confirm:$false
    Remove-Item -Path 'C:\ProgramData\WM Browser\WM Browser.zip' -Force -Confirm:$false
    If(Test-Path "C:\ProgramData\Autodesk\Revit\Addins\2019\WareMalcomb\unins000.exe"){
        Write-Host -ForegroundColor Green "Family Browser installed"
        }
    }