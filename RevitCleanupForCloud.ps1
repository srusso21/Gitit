If ((Get-Process 'revit' -ErrorAction SilentlyContinue) -eq $null) {
    Remove-Item -Recurse -Path "$env:LOCALAPPDATA\Temp\*" -Exclude "*.htm" -ErrorAction SilentlyContinue
    If((Test-Path "C:\_Revit") -eq $true){
        Remove-Item "c:\_Revit" -Recurse -ErrorAction SilentlyContinue
    }
    If ((Test-Path "$env:LOCALAPPDATA\Autodesk\Revit\PacCache\Logs") -eq $true) {
        Remove-Item -Path "$env:LOCALAPPDATA\Autodesk\Revit\PacCache\Logs" -Exclude "*.log" -Recurse
    }
    If ((Test-Path "$env:LOCALAPPDATA\Autodesk\Revit\Autodesk Revit 2017\CollaborationCache") -eq $true) {
        Remove-Item -Path "$env:LOCALAPPDATA\Autodesk\Revit\Autodesk Revit 2017\CollaborationCache" -Exclude "*.log" -Recurse
    } 
    Remove-Item -Recurse -Path "$env:LOCALAPPDATA\Temp\*" -Exclude "*.htm" -ErrorAction SilentlyContinue
    If((Test-Path "C:\_Revit") -eq $true){
        Remove-Item "c:\_Revit" -Recurse -ErrorAction SilentlyContinue
    }
    If ((Test-Path "$env:LOCALAPPDATA\Autodesk\Revit\PacCache\Logs") -eq $true) {
        Remove-Item -Path "$env:LOCALAPPDATA\Autodesk\Revit\PacCache\Logs" -Exclude "*.log" -Recurse
    }
    If ((Test-Path "$env:LOCALAPPDATA\Autodesk\Revit\Autodesk Revit 2017\CollaborationCache") -eq $true) {
        Remove-Item -Path "$env:LOCALAPPDATA\Autodesk\Revit\Autodesk Revit 2017\CollaborationCache" -Exclude "*.log" -Recurse
    }
Get-ChildItem -Path 'C:\$Recycle.Bin' -Force | Remove-Item -Recurse -ErrorAction SilentlyContinue
$Success = New-Object -ComObject Wscript.Shell
$Success.Popup("Operation Completed",0,"Done",0x1)
}
Else {
$Failed = New-Object -ComObject Wscript.Shell
$Failed.Popup("Make sure Revit and/or AutoCAD, then try again.",0,"Done",0x1)
}
