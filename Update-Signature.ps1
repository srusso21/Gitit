Function Update-Signature{
param(
[Parameter(Mandatory = $True, Position = 1)]
[string]$Samaccountname = (Read-Host "Enter Username"),
[Parameter(Mandatory = $True, Position = 2)]
[string]$Title = (Read-Host "Enter New Title"),
[Parameter(Mandatory = $True, Position = 3)]
[string]$computernname = (Read-Host "Enter Computername")
)
Set-ADUser -Identity $Samaccountname -Title $Title
$UserObject = Get-ADUser -Identity $Samaccountname -Properties Title
$displayname = $UserObject.name
$NewTitle = $UserObject.title
Write-Host "In AD,the title for $displayname is now $NewTitle"
    If(Test-Connection -ComputerName $computernname -BufferSize 8 -Count 1 -Quiet){

        IF(Test-Path "\\$computernname\c$\users\$Samaccountname\AppData\Roaming\Microsoft\Signatures\WM Signature.htm"){

        Remove-Item "\\$computernname\c$\users\$Samaccountname\AppData\Roaming\Microsoft\Signatures\*" -Force 
            If(Test-Path "\\$computernname\c$\users\$Samaccountname\AppData\Roaming\Microsoft\Signatures\WM Signature.htm"){
            Write-Host "Signature is still there"

            }Else{
            Write-Host "Signature has been removed, please have $displayname run %map% or reboot to update their signature or reboot"
            }
    
        }Else{
        Write-Host "There is no signature Present, please have $displayname run %map% or reboot to update their signature "
        }
    }else{
    Write-Host "Please connect computer to the network"
    }
}