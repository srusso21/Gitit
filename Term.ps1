#beginnings of term
param (
    #SAM Account works here
    $EnteredUser = (Read-Host -Prompt "Enter Username")
    )

$UserObject = Get-ADUser -Identity $EnteredUser -Properties emailaddress,Manager

#does the user exist?
if($UserObject -eq $null){
    Write-Host 'User does not exist'
    break
    }

#puts your email in clipboard
$Admin = ([adsi]"LDAP://$(whoami /fqdn)").mail
$Admin | clip

$User = $UserObject.samaccountname
$Email = $UserObject.emailaddress
$Upn = $UserObject.UserPrincipalName

#note this is the ad account object even though I only use the emailaddress
#$Manager = get-aduser (get-aduser $user -properties * | Select -ExpandProperty Manager) -properties *
$Manager = Get-ADUser $UserObject.manager -Properties emailaddress
$name = $userobject.name
$ManagerName = $Manager.Name

#totes random
function random-password{
    $chars = @("abcdefghijkmnopqrstuvwxyz", "ABCEFGHJKLMNPQRSTUVWXYZ", "1234567890", "!@#$%^&*()-+")
    $result = ""
        for($i = 0; $i -lt 16; $i++)
        {
            #WARNING this might be REALLLLLLLY dumb, but maybe not?
			$j = Get-Random -Maximum 4
			$result += $chars[$j][(Get-Random -Maximum $chars[$j].Length)]
        }
    return $result
}
$Pass=random-password

#changes password
Set-ADAccountPassword $User -NewPassword (ConvertTo-SecureString -AsPlainText $Pass -force) -reset

#in case you need it?
Write-Host "$User has been reset with Password $pass"

#Clears Department, Office, and Title
Set-ADUser -Identity $User -Title ' ' -Department ' ' -Office ' '
Write-Host 'Department, Office, and Title have been cleared.'

#Hide from GAL
Set-ADUser $user -Replace @{msExchHideFromAddressLists=$true}
Write-Host 'Removed from the Global Address List'

#Prepends description to include date time and user who disabled
#whoami has failed me, had to do janky stuff
$description = "Disabled on " + (Get-Date) + " by " + ([adsi]"WinNT://wma-arch.com/$env:username,user").fullname + " - "
$description += (Get-ADUser $user -Properties Description).Description
Set-ADUser $User -description $description

#disable account
Disable-ADAccount $User
Write-Host "Account has been disabled"

#move to disabled users, need to update 365 / create new OU or mailbox will break on next sync...
Move-ADObject -Identity $UserObject -TargetPath "OU=!Pending Deletion,DC=wma-arch,DC=Com"

#notify Boris that user has been terminated
Send-MailMessage -SmtpServer "192.168.0.7" -To "bshevelev@waremalcomb.com" -From "$admin" -Subject 'Remove BIM360 License' -Body "$name is no longer an employee at Ware Malcomb. Their email was $email.  Please remove their BIM 360 License. Thank you."

#EOnline connect
#Connect-Office365 -Service Exchange -MFA
Connect-ExchangeOnline -ShowProgress $true


Set-CASMailbox -Identity $Email -ActiveSyncEnabled $False
Write-Host 'Active Sync Disabled'

#convert to shared
#Set-Mailbox -identity $upn -Type Shared
#Write-Host 'Mailbox converted to shared'

#forwards email to manager
#Set-Mailbox -Identity $Email -ForwardingSMTPAddress $Manager.emailaddress

#get-inboxrule -mailbox $upn | remove-inboxrule
#Remove-InboxRule "Forward to multiple addresses"
New-InboxRule "Forward to $ManagerName" -Mailbox $upn -RedirectTo $Manager.emailaddress
Write-Host "Emails will be forwarded to $managername"

#gives manager full access
Add-MailboxPermission -identity $Upn -User $Manager.emailaddress -AccessRights FullAccess -InheritanceType all
Write-Host "$name's mailbox has mounted on $managername's Outlook"
Get-PSSession | Remove-PSSession

#connect to MSOL
<<<<<<< HEAD
#Connect-Office365 -Service MSOnline -MFA
#Set-MsolUserLicense -UserPrincipalName $Upn -RemoveLicense (Get-MsolUser -UserPrincipalName $Upn | select -ExpandProperty licenses).AccountSkuId
#Write-Host "E1/E3 license has been removed"
#Get-PSSession | Remove-PSSession
=======
Connect-MSOLService
Set-MsolUserLicense -UserPrincipalName $Upn -RemoveLicense (Get-MsolUser -UserPrincipalName $Upn | select -ExpandProperty licenses).AccountSkuId
Write-Host "E1/E3 license has been removed"
Get-PSSession | Remove-PSSession
>>>>>>> a405e06035ead1a3b1e1b7143e38d4806177eff6

#compliance center connect from Hybrid exoPSSession
Import-Module $((Get-ChildItem -Path $($env:LOCALAPPDATA+"\Apps\2.0\") -Filter Microsoft.Exchange.Management.ExoPowershellModule.dll -Recurse ).FullName|?{$_ -notmatch "_none_"}|select -First 1)
$MFCCPSSession = New-ExoPSSession -ConnectionUri 'https://ps.compliance.protection.outlook.com/PowerShell-LiveId'
import-pssession $MFCCPSSession


# Create Compliance Search - Export Email
$SearchName = "Export - " + (Get-ADUser $User).Name
New-ComplianceSearch -ExchangeLocation $Upn -Name $SearchName -Description "Termination"

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