param ([Parameter(Mandatory = $true)]$user)
Get-ADComputer -Identity $user -Properties ms-mcs-admPwd | select -ExpandProperty ms-mcs-admPwd