function Connect-ExchangeOnPrem {
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri http://irvmail01.wma-arch.com/PowerShell/ -Authentication Kerberos
Import-PSSession $Session -DisableNameChecking
}