function Add-AdobeUser {
$User       = Read-Host -Prompt 'Enter Username'
$Computer   = Read-Host -Prompt 'Enter Computer'

    If((Get-ADUser -Identity $user) -ne $null){
        Add-ADGroupMember -Identity '.adobeusers' -Members $user
    else{
        Write-Host "$user is not an username"
    }
    }

    If((Get-ADComputer -Identity $Computer) -ne $null){
        Add-ADGroupMember -Identity 'app_adobecc' -Members "$Computer$"
    }else{
        Write-Host "$computer is not an Computer in AD"
    }

Write-Host 'Be sure to add user in adobe console and tell the user to reboot to install'






}