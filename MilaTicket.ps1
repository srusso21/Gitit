<#
$milaBefore    = Get-MailboxFolderPermission -Identity mvolkova@waremalcomb.com:\calendar
$vincentBefore = Get-MailboxFolderPermission -Identity vmassaro@waremalcomb.com:\calendar
$alexBefore    = Get-MailboxFolderPermission -Identity amorales@waremalcomb.com:\calendar
$abbyBefore    = Get-MailboxFolderPermission -Identity ang@waremalcomb.com:\calendar
$chrisBefore   = Get-MailboxFolderPermission -Identity cdionne@waremalcomb.com:\calendar
#>

$mila   = "mvolkova@waremalcomb.com:\calendar"
$vincent = "vmassaro@waremalcomb.com:\calendar"
$alex    = "almorales@waremalcomb.com:\calendar"
$abby    = "ang@waremalcomb.com:\calendar"
$chris   = "cdionne@waremalcomb.com:\calendar"
$richard = "rgardner@waremalcomb.com:\calendar"
$Andrew = "AZertuche@waremalcomb.com:\calendar"
$Michael   = "mpetersen@waremalcomb.com:\calendar"
$monica = "mmunozdiaz@waremalcomb.com:\calendar"
$Bryan = "BMaeda@waremalcomb.com:\calendar"
$angel = "amorales@waremalcomb.com:\calendar"

Add-MailboxFolderPermission -Identity $chris -user almorales@waremalcomb.com -AccessRights reviewer
Add-MailboxFolderPermission -Identity $chris -user cdionne@waremalcomb.com -AccessRights reviewer
Add-MailboxFolderPermission -Identity $chris -user mvolkova@waremalcomb.com -AccessRights reviewer
Add-MailboxFolderPermission -Identity $chris -user ang@waremalcomb.com -AccessRights reviewer
Add-MailboxFolderPermission -Identity $chris -user vmassaro@waremalcomb.com -AccessRights reviewer
Add-MailboxFolderPermission -Identity $chris -user rgardner@waremalcomb.com -AccessRights reviewer
Add-MailboxFolderPermission -Identity $chris -user AZertuche@waremalcomb.com -AccessRights reviewer
Add-MailboxFolderPermission -Identity $chris -user mpetersen@waremalcomb.com -AccessRights reviewer
Add-MailboxFolderPermission -Identity $chris -user mmunozdiaz@waremalcomb.com -AccessRights reviewer
Add-MailboxFolderPermission -Identity $chris -user BMaeda@waremalcomb.com -AccessRights reviewer
Add-MailboxFolderPermission -Identity $chris -user amorales@waremalcomb.com -AccessRights reviewer

Add-MailboxFolderPermission -Identity $mila -user almorales@waremalcomb.com -AccessRights reviewer
Add-MailboxFolderPermission -Identity $mila -user cdionne@waremalcomb.com -AccessRights reviewer
Add-MailboxFolderPermission -Identity $mila -user mvolkova@waremalcomb.com -AccessRights reviewer
Add-MailboxFolderPermission -Identity $mila -user ang@waremalcomb.com -AccessRights reviewer
Add-MailboxFolderPermission -Identity $mila -user vmassaro@waremalcomb.com -AccessRights reviewer
Add-MailboxFolderPermission -Identity $mila -user rgardner@waremalcomb.com -AccessRights reviewer
Add-MailboxFolderPermission -Identity $mila -user ang@waremalcomb.com -AccessRights reviewer
Add-MailboxFolderPermission -Identity $mila -user mmunozdiaz@waremalcomb.com -AccessRights reviewer
Add-MailboxFolderPermission -Identity $mila -user mpetersen@waremalcomb.com -AccessRights reviewer
Add-MailboxFolderPermission -Identity $mila -user BMaeda@waremalcomb.com -AccessRights reviewer
Add-MailboxFolderPermission -Identity $mila -user amorales@waremalcomb.com -AccessRights reviewer

Add-MailboxFolderPermission -Identity $abby -user almorales@waremalcomb.com -AccessRights reviewer
Add-MailboxFolderPermission -Identity $abby -user cdionne@waremalcomb.com -AccessRights reviewer
Add-MailboxFolderPermission -Identity $abby -user mvolkova@waremalcomb.com -AccessRights reviewer
Add-MailboxFolderPermission -Identity $abby -user ang@waremalcomb.com -AccessRights reviewer
Add-MailboxFolderPermission -Identity $abby -user vmassaro@waremalcomb.com -AccessRights reviewer
Add-MailboxFolderPermission -Identity $abby -user rgardner@waremalcomb.com -AccessRights reviewer
Add-MailboxFolderPermission -Identity $abby -user ang@waremalcomb.com -AccessRights reviewer
Add-MailboxFolderPermission -Identity $abby -user mmunozdiaz@waremalcomb.com -AccessRights reviewer
Add-MailboxFolderPermission -Identity $abby -user mpetersen@waremalcomb.com -AccessRights reviewer
Add-MailboxFolderPermission -Identity $abby -user BMaeda@waremalcomb.com -AccessRights reviewer
Add-MailboxFolderPermission -Identity $abby -user amorales@waremalcomb.com -AccessRights reviewer

Add-MailboxFolderPermission -Identity $alex -user almorales@waremalcomb.com -AccessRights reviewer
Add-MailboxFolderPermission -Identity $alex -user cdionne@waremalcomb.com -AccessRights reviewer
Add-MailboxFolderPermission -Identity $alex -user mvolkova@waremalcomb.com -AccessRights reviewer
Add-MailboxFolderPermission -Identity $alex -user ang@waremalcomb.com -AccessRights reviewer
Add-MailboxFolderPermission -Identity $alex -user vmassaro@waremalcomb.com -AccessRights reviewer
Add-MailboxFolderPermission -Identity $alex -user rgardner@waremalcomb.com -AccessRights reviewer
Add-MailboxFolderPermission -Identity $alex -user ang@waremalcomb.com -AccessRights reviewer
Add-MailboxFolderPermission -Identity $alex -user mmunozdiaz@waremalcomb.com -AccessRights reviewer
Add-MailboxFolderPermission -Identity $alex -user mpetersen@waremalcomb.com -AccessRights reviewer
Add-MailboxFolderPermission -Identity $alex -user BMaeda@waremalcomb.com -AccessRights reviewer
Add-MailboxFolderPermission -Identity $alex -user amorales@waremalcomb.com -AccessRights reviewer

Add-MailboxFolderPermission -Identity $vincent -user almorales@waremalcomb.com -AccessRights reviewer
Add-MailboxFolderPermission -Identity $vincent -user cdionne@waremalcomb.com -AccessRights reviewer
Add-MailboxFolderPermission -Identity $vincent -user mvolkova@waremalcomb.com -AccessRights reviewer
Add-MailboxFolderPermission -Identity $vincent -user ang@waremalcomb.com -AccessRights reviewer
Add-MailboxFolderPermission -Identity $vincent -user vmassaro@waremalcomb.com -AccessRights reviewer
Add-MailboxFolderPermission -Identity $vincent -user rgardner@waremalcomb.com -AccessRights reviewer
Add-MailboxFolderPermission -Identity $vincent -user ang@waremalcomb.com -AccessRights reviewer
Add-MailboxFolderPermission -Identity $vincent -user mmunozdiaz@waremalcomb.com -AccessRights reviewer
Add-MailboxFolderPermission -Identity $vincent -user mpetersen@waremalcomb.com -AccessRights reviewer
Add-MailboxFolderPermission -Identity $vincent -user BMaeda@waremalcomb.com -AccessRights reviewer
Add-MailboxFolderPermission -Identity $vincent -user amorales@waremalcomb.com -AccessRights reviewer

Add-MailboxFolderPermission -Identity $richard -user almorales@waremalcomb.com -AccessRights reviewer
Add-MailboxFolderPermission -Identity $richard -user cdionne@waremalcomb.com -AccessRights reviewer
Add-MailboxFolderPermission -Identity $richard -user mvolkova@waremalcomb.com -AccessRights reviewer
Add-MailboxFolderPermission -Identity $richard -user ang@waremalcomb.com -AccessRights reviewer
Add-MailboxFolderPermission -Identity $richard -user vmassaro@waremalcomb.com -AccessRights reviewer
Add-MailboxFolderPermission -Identity $richard -user rgardner@waremalcomb.com -AccessRights reviewer
Add-MailboxFolderPermission -Identity $richard -user ang@waremalcomb.com -AccessRights reviewer
Add-MailboxFolderPermission -Identity $richard -user mmunozdiaz@waremalcomb.com -AccessRights reviewer
Add-MailboxFolderPermission -Identity $richard -user Mpetersen@waremalcomb.com -AccessRights reviewer
Add-MailboxFolderPermission -Identity $richard -user BMaeda@waremalcomb.com -AccessRights reviewer
Add-MailboxFolderPermission -Identity $richard -user amorales@waremalcomb.com -AccessRights reviewer

Add-MailboxFolderPermission -Identity $andrew -user almorales@waremalcomb.com -AccessRights reviewer
Add-MailboxFolderPermission -Identity $andrew -user cdionne@waremalcomb.com -AccessRights reviewer
Add-MailboxFolderPermission -Identity $andrew -user mvolkova@waremalcomb.com -AccessRights reviewer
Add-MailboxFolderPermission -Identity $andrew -user ang@waremalcomb.com -AccessRights reviewer
Add-MailboxFolderPermission -Identity $andrew -user vmassaro@waremalcomb.com -AccessRights reviewer
Add-MailboxFolderPermission -Identity $andrew -user rgardner@waremalcomb.com -AccessRights reviewer
Add-MailboxFolderPermission -Identity $andrew -user AZertuche@waremalcomb.com -AccessRights reviewer
Add-MailboxFolderPermission -Identity $andrew -user mpetersen@waremalcomb.com -AccessRights reviewer
Add-MailboxFolderPermission -Identity $andrew -user mmunozdiaz@waremalcomb.com -AccessRights reviewer
Add-MailboxFolderPermission -Identity $andrew -user BMaeda@waremalcomb.com -AccessRights reviewer
Add-MailboxFolderPermission -Identity $andrew -user amorales@waremalcomb.com -AccessRights reviewer

Add-MailboxFolderPermission -Identity $michael -user almorales@waremalcomb.com -AccessRights reviewer
Add-MailboxFolderPermission -Identity $michael -user cdionne@waremalcomb.com -AccessRights reviewer
Add-MailboxFolderPermission -Identity $michael -user mvolkova@waremalcomb.com -AccessRights reviewer
Add-MailboxFolderPermission -Identity $michael -user ang@waremalcomb.com -AccessRights reviewer
Add-MailboxFolderPermission -Identity $michael -user vmassaro@waremalcomb.com -AccessRights reviewer
Add-MailboxFolderPermission -Identity $michael -user rgardner@waremalcomb.com -AccessRights reviewer
Add-MailboxFolderPermission -Identity $michael -user AZertuche@waremalcomb.com -AccessRights reviewer
Add-MailboxFolderPermission -Identity $michael -user mpetersen@waremalcomb.com -AccessRights reviewer
Add-MailboxFolderPermission -Identity $michael -user mmunozdiaz@waremalcomb.com -AccessRights reviewer
Add-MailboxFolderPermission -Identity $michael -user BMaeda@waremalcomb.com -AccessRights reviewer
Add-MailboxFolderPermission -Identity $michael -user amorales@waremalcomb.com -AccessRights reviewer

Add-MailboxFolderPermission -Identity $monica -user almorales@waremalcomb.com -AccessRights reviewer
Add-MailboxFolderPermission -Identity $monica -user cdionne@waremalcomb.com -AccessRights reviewer
Add-MailboxFolderPermission -Identity $monica -user mvolkova@waremalcomb.com -AccessRights reviewer
Add-MailboxFolderPermission -Identity $monica -user ang@waremalcomb.com -AccessRights reviewer
Add-MailboxFolderPermission -Identity $monica -user vmassaro@waremalcomb.com -AccessRights reviewer
Add-MailboxFolderPermission -Identity $monica -user rgardner@waremalcomb.com -AccessRights reviewer
Add-MailboxFolderPermission -Identity $monica -user AZertuche@waremalcomb.com -AccessRights reviewer
Add-MailboxFolderPermission -Identity $monica -user mpetersen@waremalcomb.com -AccessRights reviewer
Add-MailboxFolderPermission -Identity $monica -user mmunozdiaz@waremalcomb.com -AccessRights reviewer
Add-MailboxFolderPermission -Identity $monica -user BMaeda@waremalcomb.com -AccessRights reviewer
Add-MailboxFolderPermission -Identity $monica -user amorales@waremalcomb.com -AccessRights reviewer

Add-MailboxFolderPermission -Identity $Bryan -user almorales@waremalcomb.com -AccessRights reviewer
Add-MailboxFolderPermission -Identity $Bryan -user cdionne@waremalcomb.com -AccessRights reviewer
Add-MailboxFolderPermission -Identity $Bryan -user mvolkova@waremalcomb.com -AccessRights reviewer
Add-MailboxFolderPermission -Identity $Bryan -user ang@waremalcomb.com -AccessRights reviewer
Add-MailboxFolderPermission -Identity $Bryan -user vmassaro@waremalcomb.com -AccessRights reviewer
Add-MailboxFolderPermission -Identity $Bryan -user rgardner@waremalcomb.com -AccessRights reviewer
Add-MailboxFolderPermission -Identity $Bryan -user AZertuche@waremalcomb.com -AccessRights reviewer
Add-MailboxFolderPermission -Identity $Bryan -user mpetersen@waremalcomb.com -AccessRights reviewer
Add-MailboxFolderPermission -Identity $Bryan -user mmunozdiaz@waremalcomb.com -AccessRights reviewer
Add-MailboxFolderPermission -Identity $Bryan -user BMaeda@waremalcomb.com -AccessRights reviewer
Add-MailboxFolderPermission -Identity $Bryan -user amorales@waremalcomb.com -AccessRights reviewer

Add-MailboxFolderPermission -Identity $angel -user almorales@waremalcomb.com -AccessRights reviewer
Add-MailboxFolderPermission -Identity $angel -user cdionne@waremalcomb.com -AccessRights reviewer
Add-MailboxFolderPermission -Identity $angel -user mvolkova@waremalcomb.com -AccessRights reviewer
Add-MailboxFolderPermission -Identity $angel -user ang@waremalcomb.com -AccessRights reviewer
Add-MailboxFolderPermission -Identity $angel -user vmassaro@waremalcomb.com -AccessRights reviewer
Add-MailboxFolderPermission -Identity $angel -user rgardner@waremalcomb.com -AccessRights reviewer
Add-MailboxFolderPermission -Identity $angel -user AZertuche@waremalcomb.com -AccessRights reviewer
Add-MailboxFolderPermission -Identity $angel -user mpetersen@waremalcomb.com -AccessRights reviewer
Add-MailboxFolderPermission -Identity $angel -user mmunozdiaz@waremalcomb.com -AccessRights reviewer
Add-MailboxFolderPermission -Identity $angel -user BMaeda@waremalcomb.com -AccessRights reviewer
Add-MailboxFolderPermission -Identity $angel -user amorales@waremalcomb.com -AccessRights reviewer


