$passwordfile = "C:\Temp\Passwordfile.txt"
$user = Get-LoggedOnUser | Select-Object -ExpandProperty UserName
Read-Host "Enter Password" -AsSecureString |  ConvertFrom-SecureString | Out-File $passwordfile
$secpasswd = (Get-Content $passwordfile | ConvertTo-SecureString)
$credential = New-Object System.Management.Automation.PSCredential($user, $secpasswd)