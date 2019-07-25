#Auto Reply
$Username      = Read-Host -Prompt "What is the username?"
$Session       = New-PSSession IRVDC1
$Test          = Get-ADUser -Identity $Username -Properties Manager
$UserObject    = Invoke-Command -Session $Session -ScriptBlock {Get-ADUser -Identity $Username -Properties Manager}
#$UserObject   = Get-ADUser -Identity $Username -Properties Manager 
$Name          = $UserObject.Name
$ManagerObject = Invoke-Command -Session $Session -ScriptBlock {Get-ADUser -Identity $UserObject.Manager -Properties EmailAddress,OfficePhone}
#$ManagerObject= Get-ADUser -Identity $UserObject.Manager -Properties EmailAddress,OfficePhone
$Manager       = $ManagerObject.DistinguishedName.split(',')[0].split('=')[1]
$ManagerEmail  = $ManagerObject.EmailAddress
$ManagerNumber = $ManagerObject.OfficePhone
#Set-MailboxAutoReplyConfiguration -Identity $USER -AutoReplyState Enabled -ExternalMessage {
"$Name is no longer with Ware Malcomb.  Please forward all future correspondence to $Manager, $ManagerEmail $ManagerNumber"
#}