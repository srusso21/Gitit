$SamAccountName = 'srusso'
$Skid = (Get-ADUser -Identity $SamAccountName).sid.value
$newformaaddin = "hkey_users:\"+"$Skid"+"\Software\Microsoft\Office\Outlook\Addins\OutlookAddIn2013"
Set-ItemProperty $newformaaddin -Name loadbehavior -
