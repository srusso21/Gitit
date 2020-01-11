$comps ="WS-2859", 
"WS-3482", 
"WS-2448", 
"WS-2403", 
"WS-2842"

$Comps | ForEach-Object {
test-Connection $_ -Count 1 -BufferSize 8 -Quiet -ErrorAction SilentlyContinue
    If(Test-Connection $_ -Count 1 -BufferSize 8 -Quiet -ErrorAction SilentlyContinue){
    try{
    
    Invoke-Command -ComputerName $_ -ScriptBlock {
Set-ItemProperty 'HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server\' -Name "fDenyTSConnections" -Value 0
Set-ItemProperty 'HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp\' -Name "UserAuthentication" -Value 1
Enable-NetFirewallRule -DisplayGroup "Remote Desktop"
If((Get-ItemProperty 'HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server\' | select -ExpandProperty fDenyTSConnections) -eq 0){
Write-Host "RDP enabled - $_"
}
}



        <#$out = @{}
        $out.Pingable = $_

        $out
        #>
        Invoke-Command -ErrorAction SilentlyContinue -ComputerName $_ -ScriptBlock{
            function Check-RevitVersion {
                [CmdletBinding()]
                    param
                        (
                        [Parameter()]
                        [ValidateScript({ Test-Connection -ComputerName $_ -Quiet -Count 1 })]
                        [ValidateNotNullOrEmpty()]
                        [string]$ComputerName = $env:COMPUTERNAME
                        )
                        $des   = Get-ADComputer -Properties description
                        $A2017 = Get-ItemProperty -Path HKLM:SOFTWARE\Autodesk\AutoCAD\R21.0\ACAD-0001:409 | Select-Object -ExpandProperty serialnumber
                        $R2017 = Get-ItemProperty -Path HKLM:SOFTWARE\Autodesk\Revit\2017\REVIT-05:0409 | Select-Object -ExpandProperty serialnumber
                        $A2019 = Get-ItemProperty -Path HKLM:SOFTWARE\Autodesk\AutoCAD\R23.0\ACAD-2001:409 | Select-Object -ExpandProperty serialnumber
                        $R2019 = Get-ItemProperty -Path HKLM:SOFTWARE\Autodesk\Revit\2019\REVIT-05:0409| Select-Object -ExpandProperty serialnumber
                        If($A2017 -eq $null){$A2017 = 'Not Installed'} 
                        If($A2019 -eq $null){$A2019 = 'Not Installed'} 
                        If($R2017 -eq $null){$R2017 = 'Not Installed'} 
                        If($R2019 -eq $null){$R2019 = 'Not Installed'} 
    $output = New-Object -TypeName PSObject -Property @{

    ComputerName= $computername
    AutoCAD2017 = $A2017 
    Revit2017   = $R2017
    AutoCAD2019 = $A2019 
    Revit2019   = $R2019
    }

    $output | select computername,AutoCAD2017,Revit2017,AutoCAD2019,Revit2019

    }
    Check-RevitVersion

    }
    #>
    }catch{}
   }
   }
     

