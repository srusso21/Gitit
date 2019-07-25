Get-ADUser -Filter * -Properties Displayname,Emailaddress,whenCreated | select Emailaddress,samaccountname,displayname,whenCreated,distinguishedname | Export-Csv -LiteralPath '\\wma-arch.com\irvine\Admin\IT\Licenses Info\Data\Exports\AD\ADUser.csv' -NoTypeInformation

Get-ADComputer -Filter 'name -like "ws-*"' -Properties description,managedby,whenCreated | select name,description,distinguishedname,managedby,whenCreated | Export-Csv -LiteralPath '\\wma-arch.com\irvine\Admin\IT\Licenses Info\Data\Exports\AD\ADComputer.csv' -NoTypeInformation

Get-ADComputer -Filter "name -like 'ws-*'" -Properties managedby | Select-Object managedby,name | Export-Csv -NoTypeInformation "\\wma-arch.com\irvine\Admin\IT\Licenses Info\Data\Exports\AD\ADComputerManaged.csv"

Get-ADUser -Filter * -Properties Managedby, | Export-Csv '\\wma-arch.com\irvine\Admin\IT\Licenses Info\Data\Exports\AD\User.csv' -NoTypeInformation

Get-ADComputer -Filter 'name -like "ws-*"' -Properties * | Export-Csv '\\wma-arch.com\irvine\Admin\IT\Licenses Info\Data\Exports\AD\Computer.csv' -NoTypeInformation
