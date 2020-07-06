$s = Get-ADUser -Properties emailaddress -Filter * | select emailaddress,name,samaccountname
$s | Export-Csv -NoTypeInformation C:\temp\aduserexport.csv
explorer C:\temp\aduserexport.csv
$r = Get-ADcomputer -Properties description -Filter * | select name,description
$r | Export-Csv -NoTypeInformation C:\temp\adcomputerexport.csv

$Final = $r | foreach {

$Result = [PSCustomObject]@{
WSnumber      = $_.name
UserFullname  = ($_.description -split " - ")[0]
WSmodel       = ($_.description -split " - ")[1]
}
$Result
}
$final | select UserFullname,WSnumber,WSmodel | Export-Csv -NoTypeInformation C:\temp\adcomputerexport1.csv
explorer C:\temp\adcomputerexport1.csv
