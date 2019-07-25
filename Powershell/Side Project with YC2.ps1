$displayname = @()
$names = get-content "c:\user.txt"
foreach ($name in $names) {


$displaynamedetails = Get-ADUser -filter { DisplayName -eq $name } -server "Domain name "| Select samAccountName

$displayname += $displaynamedetails

}

$displayname | Export-Csv "C:\Samaccountname.csv"