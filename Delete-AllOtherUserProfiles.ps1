$space = (Get-PSDrive | Where-Object {$_.name -eq 'C'} | select -ExpandProperty free)/1gb

function Get-LoggedOnUser
 {
     [CmdletBinding()]
     param
     (
         [Parameter()]
         [ValidateScript({ Test-Connection -ComputerName $_ -Quiet -Count 1 })]
         [ValidateNotNullOrEmpty()]
         [string[]]$ComputerName = $env:COMPUTERNAME
     )
     foreach ($comp in $ComputerName)
     {
         $output = @{ 'ComputerName' = $comp }
         $output.UserName = (Get-WmiObject -Class win32_computersystem -ComputerName $comp).UserName
         [PSCustomObject]$output
     }
 }
$user = (Get-LoggedOnUser | select -ExpandProperty username).split('\')[1]
#exceptions are LoggedinUser, SLAdmin, SLInstaller, Public, TSchedge, Default
Get-WmiObject -Class Win32_UserProfile | Where-Object {
    $_.localpath -notmatch 'SLadmin'-and
    $_.localpath -notmatch 'SLINSTALLER' -and
    $_.localpath -notmatch $user -and
    $_.localpath -notmatch 'Public' -and
    $_.localpath -notmatch 'Default' -and
    $_.localpath -notmatch 'C:\\WINDOWS' -and
    $_.localpath -notmatch 'Administrator' -and
    $_.localpath -notmatch 'tschedge'
} | ForEach-Object {

    $_.delete()

}


