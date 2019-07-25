If ((((Get-ItemProperty HKLM:\SOFTWARE\Autodesk\AutoCAD\R21.0\ACAD-0001:409).serialnumber) -eq "397-90226182") -eq $True) {
    Start-Process C:\Windows\System32\msiexec.exe -ArgumentList "/x{28B89EEF-0001-0000-0102-CF3F3A09B77D} /passive" -wait
    }
