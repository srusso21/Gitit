# "Commercial" "San Ramon"
$export = "C:\Users\srusso\OneDrive - Ware Malcomb\Documents\GitHub\Gitit\Exports\ADAudit.csv"
$Wrong =  Get-ADUser -Filter * -Properties title,department | Where-Object {$_.title -match "Commercial" -or $_.title -match "San Ramon" -or $_.department -match "Commercial" -or $_.department -match "San Ramon"}
$Wrong | select name,title,department | Export-Csv $export -NoTypeInformation