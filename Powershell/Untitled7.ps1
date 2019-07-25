$computers = Get-ADGroupMember -Identity App_StudioAStandaloneMigration | select name
Foreach ($computer in $computers) {
If (Test-Connection $computers -Count 1 -Quiet) {
    
    $client = $computer.name
    Invoke-Command -ComputerName $client -ScriptBlock {(Get-ItemProperty HKLM:\SOFTWARE\Autodesk\Revit\2017\REVIT-05:0409).serialnumber}

    }
else {
    
    Write-Host "$client is not connected to the Network"

    }
}