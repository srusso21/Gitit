$sam = $env:USERNAME
$Root = [ADSI]''
$Searcher = New-Object System.DirectoryServices.DirectorySearcher($Root)
$Searcher.filter = "(&(objectClass=user)(sAMAccountName= $sam))"
$User = $Searcher.findall()
$title = $User.Properties.title
$mail = $User.Properties.mail
$User.Properties.emailaddress
$changeSigReply =  Get-Content $env:APPDATA\Microsoft\Signatures\WM Signature - Reply.htm -ErrorAction SilentlyContinue  | Select-String $title
if(($changeSig) -eq $null){

Remove-Item $env:APPDATA\Microsoft\Signatures\* -Recurse -Force 

$Success = "Success"

}
