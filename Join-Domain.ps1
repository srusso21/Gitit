# Define the variables 
 
# 1.  Specify the new computer name. 
$NewHostName = "ws-2232" 
 
# 2.  Specify the domain to join. 
$DomainToJoin = "wma-arch.com" 
 
# 3.  Specify the OU where to put the computer account in the domain.  Use the OU's distinguished name. 
$OU = "OU=Test Computers,OU=ADMIN,DC=wma-arch,DC=com" 
 
 
# Join the computer to the domain, rename it, and restart it. 
Add-Computer -DomainName $DomainToJoin -OUPath $OU -NewName $NewHostName -Restart
