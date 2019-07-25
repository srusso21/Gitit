$list = (Get-ADObject -Filter "objectClass -eq 'msFVE-RecoveryInformation'").distinguishedname
$list -split ","[1] <#-replace "CN="," " #>