Function Purge-Computer{
    $before = (Get-PSDrive | Where-Object {$_.name -eq 'C'} | select -ExpandProperty free)/1gb
    $user = (Get-WmiObject -Class win32_computersystem | select -ExpandProperty username).split('\')[1]
#exceptions are LoggedinUser, SLAdmin, SLInstaller, Public, TSchedge, Default
    Get-WmiObject -Class Win32_UserProfile | Where-Object {
        $_.localpath -notmatch 'SLadmin'-and
        $_.localpath -notmatch 'SLINSTALLER' -and
        $_.localpath -notmatch $user -and
        $_.localpath -notmatch 'Public' -and
        $_.localpath -notmatch 'Default' -and
        $_.localpath -notmatch 'C:\\WINDOWS' -and
        $_.localpath -notmatch 'Administrator' -and
        $_.localpath -notmatch 'Jobfair' -and
        $_.localpath -notmatch 'tschedge'
        
        

    } | ForEach-Object {

        $_.delete()

    }
$after = (Get-PSDrive | Where-Object {$_.name -eq 'C'} | select -ExpandProperty free)/1gb
$result = $after-$before
Write-Host "$result GB deleted"
}
Purge-Computer
