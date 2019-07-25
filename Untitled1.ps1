#Exchange 2010 with current user
$UserCredential = Get-Credential -UserName "$env:USERDOMAIN\$ENV:USERNAME" -Message "Login to the Domain"
$ExchangeOrNLBFQDN = "https://webmail.waremalcomb.com"
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri $ExchangeOrNLBFQDN/PowerShell/ -Authentication basic -AllowRedirection -Credential $UserCredential
Import-PSSession $Session

#(Remove-PSSession $Session once finished)


#$UserCredential = Get-Credential -UserName "$env:USERDOMAIN\$ENV:USERNAME" -Message "Login to the Domain"
#$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://webmail.waremalcomb.com/powershell/ -Credential $UserCredential -Authentication Basic -AllowRedirection