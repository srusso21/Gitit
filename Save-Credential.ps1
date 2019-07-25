$credential = Get-Credential -Credential srusso@waremalcomb.com

$credential.Password | ConvertFrom-SecureString | Set-Content c:\users\srusso\enc_password.txt