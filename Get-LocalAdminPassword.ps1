function Get-LocalAdminPassword {
    param (
        $user = (Read-Host  -Prompt "Enter Computername")
    )
    Get-ADComputer -Identity $user -Properties ms-mcs-admPwd | select -ExpandProperty ms-mcs-admPwd
}
