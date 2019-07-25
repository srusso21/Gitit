function Test-RebootRequired{
    # Initialize result array
    $result = @{
        CBSRebootPending = (Get-ChildItem "HKLM:Software\Microsoft\Windows\CurrentVersion\Component Based Servicing\RebootPending" -ErrorAction SilentlyContinue).CBSRebootPending
        WindowsUpdateRebootRequired = (Get-Item "HKLM:SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update\RebootRequired" -ErrorAction SilentlyContinue).WindowsUpdateRebootRequired
        FileRenamePending = (Get-ItemProperty "HKLM:SYSTEM\CurrentControlSet\Control\Session Manager" -Name PendingFileRenameOperations -ErrorAction SilentlyContinue).FileRenamePending
        SCCMRebootPending = $false
	}

    # Complete result Array with SCCM client status
    try 
    { 
        $util = [wmiclass]"\\.\root\ccm\clientsdk:CCM_ClientUtilities"
        $status = $util.DetermineIfRebootPending()
        if(($status -ne $null) -and $status.RebootPending){
            $result.SCCMRebootPending = $true
        }
    }catch{}

    # Normalize Result Array
    if ($result.CBSRebootPending -eq $null){ $result.CBSRebootPending = $false }
    if ($result.WindowsUpdateRebootRequired -eq $null){ $result.WindowsUpdateRebootRequired = $false }
    if ($result.FileRenamePending -eq $null){ $result.FileRenamePending = $false }

    #Return Reboot required
    return $result.ContainsValue($true)
}
Function Set-AutoLogon{

    [CmdletBinding()]
    Param(
        
        [Parameter(Mandatory=$True,ValueFromPipeline=$true,ValueFromPipelineByPropertyName=$true)]
        [String[]]$DefaultUsername,

        [Parameter(Mandatory=$True,ValueFromPipeline=$true,ValueFromPipelineByPropertyName=$true)]
        [String[]]$DefaultPassword,

        [Parameter(Mandatory=$False,ValueFromPipeline=$true,ValueFromPipelineByPropertyName=$true)]
        [AllowEmptyString()]
        [String[]]$AutoLogonCount,

        [Parameter(Mandatory=$False,ValueFromPipeline=$true,ValueFromPipelineByPropertyName=$true)]
        [AllowEmptyString()]
        [String[]]$Script
                
    )

    Begin
    {
        #Registry path declaration
        $RegPath = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon"
        $RegROPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce"
    
    }
    
    Process
    {

        try
        {
            #setting registry values
            Set-ItemProperty $RegPath "AutoAdminLogon" -Value "1" -type String  
            Set-ItemProperty $RegPath "DefaultUsername" -Value "$DefaultUsername" -type String  
            Set-ItemProperty $RegPath "DefaultPassword" -Value "$DefaultPassword" -type String
            if($AutoLogonCount)
            {
                
                Set-ItemProperty $RegPath "AutoLogonCount" -Value "$AutoLogonCount" -type DWord
            
            }
            else
            {

                Set-ItemProperty $RegPath "AutoLogonCount" -Value "10" -type DWord

            }
            if($Script)
            {
                
                Set-ItemProperty $RegROPath "(Default)" -Value "'C:\Windows\System32\WindowsPowerShell\v1.0\Powershell.exe -executionPolicy Unrestricted -File ' + "\\wma-arch.com\r\Resour\ITSupport\Scripts\PowerShell\Apps_Script.ps1"" -type String
            
            }
            else
            {
            
                Set-ItemProperty $RegROPath "(Default)" -Value "" -type String
            
            }        
        }

        catch
        {

            Write-Output "An error had occured $Error"
            
        }
    }
    
    End
    {
        
        #End

    }

}
Set-AutoLogon -DefaultUsername 'wma-arch.com\Sladmin' -DefaultPassword 'sl@dmin1'
#Install Software

#Check if AutoCAD 2017 is installed
if((Test-Path -Path "C:\Program Files\Autodesk\AutoCAD 2017\acad.exe") -eq $false){

#Install AutoCAD 2017
Start-Process '\\wma-arch.com\r\Resour\ITSupport\Software\AutoDesk\AutoCAD\AutoCAD2017a\Img\setup.exe' -ArgumentList "/qb /I \\wma-arch.com\r\Resour\ITSupport\Software\AutoDesk\AutoCAD\AutoCAD2017a\Img\AutoCAD 2017 USA.ini /Trial /language en-us" -Wait

}
#Reboot if Necessary
#If(Test-RebootRequired -eq $true){Restart-Computer -Force}

#Check if Revit 2017 is installed
if((Test-Path -Path "C:\Program Files\Autodesk\Revit 2017\revit.exe") -eq $false){
#Install Revit 2017
Start-Process '\\wma-arch.com\r\Resour\ITSupport\Software\AutoDesk\RevitSeries\2017a\Img\Setup.exe' -ArgumentList '/qb /I \\wma-arch.com\r\Resour\ITSupport\Software\AutoDesk\RevitSeries\2017a\Img\Revit 2017 US.ini /Trial /language en-us' -Wait 
}
#Reboot if Necessary
#If(Test-RebootRequired -eq $true){Restart-Computer -Force}

#Check if AutoCAD 2019 is installed
if((Test-Path -Path "C:\Program Files\Autodesk\AutoCAD 2019\acad.exe") -eq $false){
#Install AutoCAD 2019
Start-Process '\\wma-arch.com\r\Resour\ITSupport\Software\AutoDesk\AutoCAD\AutoCAD2019a\Img\Setup.exe' -ArgumentList "/qb /I \\wma-arch.com\r\Resour\ITSupport\Software\AutoDesk\AutoCAD\AutoCAD2019a\Img\AutoCAD 2019 USA.ini /Trial /language en-us" -Wait
}
#Reboot if Necessary
#If(Test-RebootRequired -eq $true){Restart-Computer -Force}

#Check if Revit 2019 is installed
if((Test-Path -Path "C:\Program Files\Autodesk\Revit 2019\revit.exe") -eq $false){

#Install Revit 2019
Start-Process '\\wma-arch.com\r\Resour\ITSupport\Software\AutoDesk\RevitSeries\2019a\Img\Setup.exe' -ArgumentList '/qb /I \\wma-arch.com\r\Resour\ITSupport\Software\AutoDesk\RevitSeries\2019a\Img\Revit 2019 US.ini /Trial /language en-us' -Wait 

}
#Reboot if Necessary
#If(Test-RebootRequired -eq $true){Restart-Computer -Force}

#Check if Bluebeam 2018 is installed
if ((Test-Path -Path "C:\Program Files\Bluebeam Software\Bluebeam Revu\2018\Revu\Revu.exe") -eq $false){

#Install BlueBeam 2018
Start-Process '\\wma-arch.com\r\resour\itsupport\software\autodesk\autoCAD\Autocad 2017a\IMG\setup.exe' -ArgumentList '' -Wait

}
#Reboot if Necessary
If(Test-RebootRequired -eq $true){
Restart-Computer -Force
}