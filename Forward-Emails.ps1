Try{Connect-EXOPSSession -UserPrincipalName (Get-ADUser "$env:USERNAME").UserPrincipalName

}
Catch{}

$user = Read-Host -Prompt 'Enter Username'

#for 365 which needs upn
$upn = "$user"+"@waremalcomb.com"

#note this is the ad account object even though I only use the emailaddress
$Manager = get-aduser (get-aduser $user -properties * | Select -ExpandProperty Manager) -properties *

Set-Mailbox -Identity $upn -ForwardingSMTPAddress $Manager.emailaddress

#disables active sync
Set-CASMailbox -Identity $upn -ActiveSyncEnabled $False 

#gives manager full access
Add-MailboxPermission -identity $upn -User $Manager.emailaddress -AccessRights FullAccess -InheritanceType all

#hide from the GAL
Set-ADUser $user -Replace @{msExchHideFromAddressLists=$true}

#d/c
get-pssession | remove-pssession
<#
#compliance center connect from my custom functions
connect-compliance

# Create Compliance Search - Export Email

$SearchName = "Export - " + (get-aduser $user).Name
New-ComplianceSearch -ExchangeLocation $upn -Name $SearchName -Description "Termination"


# Start Compliance Search and wait to complete
Start-ComplianceSearch $SearchName
<# MS Broke all of this "-Export " anyway, it totally doesn't work anymore :(
do{
Start-Sleep -s 5
$complianceSearch = Get-ComplianceSearch $SearchName
}while ($complianceSearch.Status -ne 'Completed')

New-ComplianceSearchAction -SearchName $SearchName -Export -NotifyEmail "$env:USERNAME@waremalcomb.com" -Format FxStream -ArchiveFormat PerUserPST

#Wait for Export to complete
do{
Start-Sleep -s 5
$complete = Get-ComplianceSearchAction -Identity $ExportName
}while ($complete.Status -ne 'Completed')
>
#>