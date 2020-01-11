$ADUserObject = ([adsi]"LDAP://$(whoami /fqdn)") | select extensionAttribute1,displayName,description,streetAddress,l,st,postalCode,mail,telephoneNumber,Title,mobile,homephone
$DestinationPath     = "$env:appdata\Microsoft\Signatures\"
$NewSignatureName    = "WM Signature.html"
$ReplySignatureName  = "WM Signature - Reply.html"
$adExtAttr1          = $ADUserObject.extensionAttribute1
$adFullName          = $ADUserObject.displayName
$adDescription       = $ADUserObject.description
$adAddress           = $ADUserObject.streetAddress
$adCity              = $ADUserObject.l
$adState             = $ADUserObject.st
$adZip               = $ADUserObject.postalCode
$adEmail             = $ADUserObject.mail
$adPhone             = $ADUserObject.telephoneNumber
$adTitle             = $ADUserObject.title
$adMobile            = $ADUserObject.mobile
$adHomePhone         = $ADUserObject.homephone
#New Signature with Variables
$RawHTMLNew          = @"
<p style="margin-bottom: 12.0pt; line-height: normal;"><span style="font-size: 10.0pt; font-family: 'Tahoma',sans-serif;">$adExtAttr1<br /><br /><strong><span style="color: #564c44;">$adFullName$adDescription</span></strong><span style="color: #564c44;"><br />$adTitle</span><br /><span style="color: #d0502b;">P</span><span style="color: #564c44;"> $adPhone <br />$adAddress, $adCity, $adState $adZip <br /></span><span style="color: #d14f2a;">$adEmail</span> </span></p>
<p style="line-height: normal;"><strong><span style="font-size: 16.0pt; font-family: 'Palatino Linotype',serif; color: #564c44;">WARE MALCOMB</span></strong><span style="font-size: 10.0pt; font-family: 'Times New Roman',serif; color: #564c44;"> <br /></span><span style="font-size: 9.0pt; font-family: 'Tahoma',sans-serif; color: #564c44;">ARCHITECTURE</span><span style="font-size: 9.0pt; font-family: 'Arial',sans-serif; color: #d0502b;">&nbsp;|&nbsp;</span><span style="font-size: 9.0pt; font-family: 'Tahoma',sans-serif; color: #564c44;">PLANNING</span><span style="font-size: 9.0pt; font-family: 'Arial',sans-serif; color: #d0502b;">&nbsp;|&nbsp;</span><span style="font-size: 9.0pt; font-family: 'Tahoma',sans-serif; color: #564c44;">INTERIORS</span><span style="font-size: 9.0pt; font-family: 'Times New Roman',serif; color: #564c44;"><br /></span><span style="font-size: 9.0pt; font-family: 'Tahoma',sans-serif; color: #564c44;">BRANDING</span><span style="font-size: 9.0pt; font-family: 'Arial',sans-serif; color: #d0502b;">&nbsp;|&nbsp;</span><span style="font-size: 9.0pt; font-family: 'Tahoma',sans-serif; color: #564c44;">CIVIL ENGINEERING</span><span style="font-size: 9.0pt; font-family: 'Times New Roman',serif; color: #564c44;">&nbsp;</span></p>
<strong><span style="font-size: 10.0pt; font-family: 'Tahoma',sans-serif; color: #d0502b;">Inc. 5000 Fastest-Growing Private Company</span></strong><br /><strong><span style="font-size: 10.0pt; font-family: 'Tahoma',sans-serif; color: #d0502b;">Zweig Best Firm to Work For</span></strong><br /><strong><span style="font-size: 10.0pt; font-family: 'Tahoma',sans-serif; color: #d0502b;">Zweig Hot Firm</span></strong>
"@
#Reply Signature with Variables
$RawHTMLReply        = @"
<p style="line-height: normal;"><span style="font-size: 10.0pt; font-family: 'Tahoma',sans-serif;"><strong><span style="color: #564c44;">$adFullName$adDescription</span></strong><span style="color: #564c44;"><br />$adTitle</span><br /><span style="color: #d0502b;">P</span><span style="color: #564c44;"> $adPhone</span></span></p>
<p style="line-height: normal;"><strong><span style="font-size: 16.0pt; font-family: 'Palatino Linotype',serif; color: #564c44;">WARE MALCOMB</span></strong><span style="font-size: 12.0pt; font-family: 'Times New Roman',serif; color: #564c44;"><br /></span><span style="font-size: 9.0pt; font-family: 'Tahoma',sans-serif; color: #564c44;">ARCHITECTURE</span><span style="font-size: 9.0pt; font-family: 'Arial',sans-serif; color: #d0502b;">&nbsp;|&nbsp;</span><span style="font-size: 9.0pt; font-family: 'Tahoma',sans-serif; color: #564c44;">PLANNING</span><span style="font-size: 9.0pt; font-family: 'Arial',sans-serif; color: #d0502b;">&nbsp;|&nbsp;</span><span style="font-size: 9.0pt; font-family: 'Tahoma',sans-serif; color: #564c44;">INTERIORS</span><span style="font-size: 9.0pt; font-family: 'Times New Roman',serif; color: #564c44;"><br /></span><span style="font-size: 9.0pt; font-family: 'Tahoma',sans-serif; color: #564c44;">BRANDING</span><span style="font-size: 9.0pt; font-family: 'Arial',sans-serif; color: #d0502b;">&nbsp;|&nbsp;</span><span style="font-size: 9.0pt; font-family: 'Tahoma',sans-serif; color: #564c44;">CIVIL ENGINEERING</span></p>
<strong><span style="font-size: 10.0pt; font-family: 'Tahoma',sans-serif; color: #d0502b;">Inc. 5000 Fastest-Growing Private Company</span></strong><br /><strong><span style="font-size: 10.0pt; font-family: 'Tahoma',sans-serif; color: #d0502b;">Zweig Best Firm to Work For</span></strong><br /><strong><span style="font-size: 10.0pt; font-family: 'Tahoma',sans-serif; color: #d0502b;">Zweig Hot Firm</span></strong>
"@
New-Item ("$DestinationPath"+"$NewSignatureName") -ItemType File -Force
New-Item ("$DestinationPath"+"$ReplySignatureName") -ItemType File -Force
Set-Content ("$DestinationPath"+"$NewSignatureName") -Value "$RawHTMLNew"
Set-Content ("$DestinationPath"+"$ReplySignatureName") -Value "$RawHTMLReply"