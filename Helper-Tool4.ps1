$audit = Import-Csv -Path "C:\Users\srusso\OneDrive - Ware Malcomb\Documents\_IT\1st Floor Desk Audit.csv"
#$vision = Import-Csv -Path "C:\Users\srusso\OneDrive - Ware Malcomb\Documents\_IT\vision.csv"
$ad = "C:\Users\srusso\OneDrive - Ware Malcomb\Documents\_IT\ad.csv"
$adexport = Get-ADUser -Filter * 
$adexport | Export-Csv -Path $ad -NoTypeInformation
$adobj = Import-Csv -Path $ad
$final = $audit | ForEach-Object {
$Object = [PSCustomObject]@{
Number         = $_.number
Monitors       = $_.Monitors
Dock           = $_.Dock
PowerAdapter   = $_.'Power Adapter'
User1          = $_.User1
User1Fullname  = $_.User1Fullname
Users2         = $_.Users2
User2Fullname  = $_.User2Fullname

}

$user=$null
$user = $_.user1
$userfullname = ($adobj | Where-Object {$_.name -match $user -and $_.DistinguishedName -match 'irvine'}).name
$Object.User1Fullname = $userfullname
$Object
}
#$final | Export-Csv -Path "C:\Users\srusso\OneDrive - Ware Malcomb\Documents\_IT\final.csv"
$FinalObject = Import-Csv -Path "C:\Users\srusso\OneDrive - Ware Malcomb\Documents\_IT\final.csv"
$final2 = $FinalObject | ForEach-Object {
$Object = [PSCustomObject]@{
Number         = $_.number
Monitors       = $_.Monitors
Dock           = $_.Dock
PowerAdapter   = $_.'Power Adapter'
User1          = $_.User1
User1Fullname  = $_.User1Fullname
Users2         = $_.Users2
User2Fullname  = $_.User2Fullname

}

$user2 =$null
$user2 = $object.Users2
$userfullname = ($adobj | Where-Object {$_.name -match $user2 -and $_.DistinguishedName -match 'irvine'}).name
$Object.User2Fullname = $userfullname
$Object
}