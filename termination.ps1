#beginnings of term
function random-password 
{ 
    $chars = @("abcdefghijkmnopqrstuvwxyz", "ABCEFGHJKLMNPQRSTUVWXYZ", "1234567890", "!@#$%^&*()-+") 
    $result = "" 
        for($i = 0; $i -lt 12; $i++) 
        { 
            #WARNING this might be REALLLLLLLY dumb, but maybe not?
            $j = Get-Random -Maximum 4            
            $result += $chars[$j][(Get-Random -Maximum $chars[$j].Length)] 
        } 
    return $result 
}
"srusso@waremalcomb.com" |clip
#SAM Account works here
$user = Read-Host "Enter Username to Terminate"
#for 365 which needs upn
$upn = "$user"+"@waremalcomb.com"
#note this is the ad account object even though I only use the emailaddress
$Manager = get-aduser (get-aduser $user -properties * | Select -ExpandProperty Manager) -properties *
#totes random
$pass=random-password 
#changes password
Set-ADAccountPassword $user -NewPassword (ConvertTo-SecureString -AsPlainText $pass -force) -reset
#in case you need it? 
write-host "$user has been reset with Password $pass"
#Prepends description to include date time and user who disabled
#whoami has failed me, had to do janky stuff
$description = "Disabled on " + (Get-Date) + " by " + ([adsi]"WinNT://wma-arch.com/$env:username,user").fullname + " - "
$description += (Get-ADUser $user -Properties Description).Description
Set-aduser $user -description $description
#disable account
Disable-ADAccount $user
#move to disabled users, need to update 365 / create new OU or mailbox will break on next sync...
Move-ADObject -Identity (get-aduser $user) -TargetPath "OU=!Pending Deletion,DC=wma-arch,DC=Com"

Connect-Office365 -Service MSOnline -MFA
Set-MsolUserLicense -UserPrincipalName $upn -RemoveLicense (Get-MsolUser -UserPrincipalName $upn | select -ExpandProperty licenses).AccountSkuId

get-pssession | remove-pssession
#------Exchane thoughts: If we convert to shared, then grab license right away "Set-msoluser" then we can't forward email
#EOnline connect
Connect-Office365 -Service Exchange -MFA

#forwards email to manager
Set-Mailbox -Identity $upn -ForwardingSMTPAddress $Manager.emailaddress
#disables active sync
Set-CASMailbox -Identity $upn -ActiveSyncEnabled $False 
#gives manager full access
Add-MailboxPermission -identity $upn -User $Manager.emailaddress -AccessRights FullAccess -InheritanceType all

#d/c
get-pssession | remove-pssession

#compliance center connect from my custom functions
Connect-Office365 -Service SecurityAndCompliance -MFA
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