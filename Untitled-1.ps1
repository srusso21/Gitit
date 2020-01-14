function Change-ComputerDescription {
    [CmdletBinding()]
    param ($Workstation=(Read-Host -Prompt 'Enter Computer Name'),$model = (Read-Host -Prompt 'Enter Computer Model'),$username = (Read-Host -Prompt 'Enter username'),$type = (Read-Host -Prompt 'Enter username'))
        Try{
        <#
        $UserObject  = Get-ADUser -Identity $username -Properties displayname
        Move-ADObject -Identity $UserObject -TargetPath "$OU"
        #>


        $displayname = Get-ADUser -Identity $username -Properties displayname -ErrorAction SilentlyContinue | select -ExpandProperty displayname

    }Catch{}

    if($displayname -ne $null) {
    Write-Host "Changing the description of $workstation to $displayname - $model"

    Set-ADComputer -Identity $workstation -Description "$displayname - $model"
    }else{
            If($username -eq $null){
                # and moving the object to $Type/$Office OU
            Write-Host "Changing the description of $workstation to Available - $model"
            Set-ADComputer -Identity $workstation -Description "Available - $model"

        }else{Write-Host "User not found"}
    }
}