function connect-exchange{
$emailusername = "srusso@waremalcomb.com"
$encrypted = Get-Content c:\users\srusso\enc_password.txt | ConvertTo-SecureString
$credential = New-Object System.Management.Automation.PsCredential($emailusername, $encrypted)
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $credential -Authentication Basic -AllowRedirection
Import-PSSession $Session -DisableNameChecking
}

function connect-compliance{
$emailusername = "srusso@waremalcomb.com"
$encrypted = Get-Content c:\users\srusso\enc_password.txt | ConvertTo-SecureString
$credential = New-Object System.Management.Automation.PsCredential($emailusername, $encrypted)
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://ps.compliance.protection.outlook.com/powershell-liveid/ -Credential $credential -Authentication Basic -AllowRedirection
Import-PSSession $Session -DisableNameChecking
}