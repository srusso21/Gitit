$CSV = "C:\temp\Test02.csv"

Get-ADUser -Filter * -Properties Displayname,samaccountname | select Displayname,samaccountname | Export-Csv $CSV

$Imported = Import-Csv -Path $CSV

$Imported | Where-Object {$_.samaccountname -match 'Srusso'} | select displayname
