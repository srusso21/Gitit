$VPNUsers = Get-ADGroupMember -Identity 'vpn remote access'
Foreach($user in $VPNUsers) {

$Email = (Get-ADUser -Properties emailaddress -Identity $user.samaccountname).emailaddress

New-Object -TypeName PSObject -Property @{
                DisplayName = $user.name
                Username = $user.samaccountname
                EmailAddress = $Email
            } | Select-Object displayname,username,emailaddress | Export-Csv -Path "c:\temp\VPN Users.csv" -append    
        }


