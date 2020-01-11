$EnteredUser = Read-host "uname:"
$User = (Get-ADUser -Identity $EnteredUser).samaccountname
$Folder = "\\wma-arch.com\users\users\$User"
$dUser = "wma-arch.com\$User"
$Acl = Get-Acl $Folder
$AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule($dUser,"FullControl","ContainerInherit,ObjectInherit","None","Allow")
$Acl.SetAccessRule($AccessRule)
<#
Set-Location \\wma-arch.com\Users\Users
$folders = Get-ChildItem \\wma-arch.com\Users\Users | select -ExpandProperty name
foreach($folder in $folders){
$user = "wma-arch.com\"+$folder
$fsr = [System.Security.AccessControl.AccessControlType]::Allow
}
$emptyACL = New-Object System.Security.AccessControl.DirectorySecurity::FullControl
#>