If ((((Get-ItemProperty HKLM:\SOFTWARE\Autodesk\Revit\2017\REVIT-05:0409).serialnumber) -eq 397-90226182) -eq $true) {
    Start-Process C:\Windows\System32\msiexec.exe -ArgumentList "/x{7346B4A0-1700-0510-0000-705C0D862004} /passive" -wait
    }