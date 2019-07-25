$MexicoComputers   = Get-ADComputer -Filter "name -like 'ws-*'" | Where-Object {$_.distinguishedname -match 'Mexico'}
#$RevitSerialnumber = (Get-ItemProperty HKLM:\SOFTWARE\Autodesk\Revit\2017\REVIT-05:0409).serialnumber
#$CADSerialnumber   = (Get-ItemProperty HKLM:\SOFTWARE\Autodesk\AutoCAD\R21.0\ACAD-0001:409).serialnumber

ForEach ($c in $MexicoComputers) {
    
    Invoke-Command -ComputerName $c.name -ScriptBlock {(Get-ItemProperty HKLM:\SOFTWARE\Autodesk\Revit\2017\REVIT-05:0409).serialnumber} 
    
    Invoke-Command -ComputerName $c.name -ScriptBlock {(Get-ItemProperty HKLM:\SOFTWARE\Autodesk\AutoCAD\R21.0\ACAD-0001:409).serialnumber}

    }
