function Test-RebootRequired
{
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