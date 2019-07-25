﻿Get-ADUser -Filter *  -Properties Streetaddress | Where-Object {$_.DistinguishedName -match "OU=Users,OU=Chicago,"} | ForEach-Object {Set-ADUser -Identity $_ -StreetAddress "1315 22nd Street, Suite 410"}