Function Create-Employee {
#add Functions
function Connect-ExchangeOnPrem {
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri http://irvmail01.wma-arch.com/PowerShell/ -Authentication Kerberos
Import-PSSession $Session -DisableNameChecking
}
function Sync-Azure{
Invoke-Command IRVAZADCon01 -ScriptBlock {Import-Module ADSync; Start-ADSyncSyncCycle -PolicyType Delta}
}
function Connect-Office365{
<#
.NOTES
===========================================================================
Created on:   	2/4/2019 10:42 PM
Created by:   	Bradley Wyatt
E-Mail:		Brad@TheLazyAdministrator.com
GitHub:		https://github.com/bwya77
Website:	https://www.thelazyadministrator.com
Organization: 	Porcaro Stolarek Mete Partners; The Lazy Administrator
Filename:     	Connect-Office365.ps1
Version: 	1.0.4
Contributors:   /u/Sheppard_Ra
Changelog:
1.0.4
- Host title will add a service or services you are connected to. If unable to connect it will not display connection status until connection is valid
===========================================================================
.SYNOPSIS
Connect to Office 365 Services
.DESCRIPTION
Connect to different Office 365 Services using PowerShell function. Supports MFA.
.PARAMETER MFA
Description: Specifies MFA requirement to sign into Office 365 services. If set to $True it will use the Office 365 ExoPSSession Module to sign into Exchange & Compliance Center using MFA. Other modules support MFA without needing another external module
.PARAMETER Exchange
Description: Connect to Exchange Online
.PARAMETER SkypeForBusiness
Description: Connect to Skype for Business
.PARAMETER SharePoint
Description: Connect to SharePoint Online
.PARAMETER SecurityandCompliance
Description: Connect to Security and Compliance Center
.PARAMETER AzureAD
Description: Connect to Azure AD V2
.PARAMETER MSOnline
Type: Switch
Description: Connect to Azure AD V1
.PARAMETER Teams
Type: Switch
Description: Connect to Teams
.EXAMPLE
Description: Connect to SharePoint Online
C:\PS> Connect-Office365 -SharePoint
.EXAMPLE
Description: Connect to Exchange Online and Azure AD V1 (MSOnline)
C:\PS> Connect-Office365 -Service Exchange, MSOnline
.EXAMPLE
Description: Connect to Exchange Online and Azure AD V2 using Multi-Factor Authentication
C:\PS> Connect-Office365 -Service Exchange, MSOnline -MFA
.EXAMPLE
Description: Connect to Teams and Skype for Business
C:\PS> Connect-Office365 -Service Teams, SkypeForBusiness
.EXAMPLE
Description: Connect to SharePoint Online
C:\PS> Connect-Office365 -Service SharePoint -SharePointOrganizationName bwya77 -MFA
.LINK
Online version:  https://www.thelazyadministrator.com/2019/02/05/powershell-function-to-connect-to-all-office-365-services
#>
[OutputType()]
[CmdletBinding(DefaultParameterSetName)]
Param (
[Parameter(Mandatory = $True, Position = 1)]
[ValidateSet('AzureAD', 'Exchange', 'MSOnline', 'SecurityAndCompliance', 'SharePoint', 'SkypeForBusiness', 'Teams')]
[string[]]$Service,
[Parameter(Mandatory = $False, Position = 2)]
[Alias('SPOrgName')]
[string]$SharePointOrganizationName,
[Parameter(Mandatory = $False, Position = 3, ParameterSetName = 'Credential')]
[PSCredential]$Credential,
[Parameter(Mandatory = $False, Position = 3, ParameterSetName = 'MFA')]
[Switch]$MFA
)
$getModuleSplat = @{
ListAvailable = $True
Verbose	      = $False
}
If ($MFA -ne $True)
{
Write-Verbose "Gathering PSCredentials object for non MFA sign on"
$Credential = Get-Credential -Message "Please enter your Office 365 credentials"
}
ForEach ($Item in $PSBoundParameters.Service)
{
Write-Verbose "Attempting connection to $Item"
Switch ($Item)
{
AzureAD {
If ($null -eq (Get-Module @getModuleSplat -Name "AzureAD"))
{
Write-Error "SkypeOnlineConnector Module is not present!"
continue
}
Else
{
If ($MFA -eq $True)
{
$Connect = Connect-AzureAD
If ($Connect -ne $Null)
{
If (($host.ui.RawUI.WindowTitle) -notlike "*Connected To:*")
{
$host.ui.RawUI.WindowTitle += " - Connected To: AzureAD"
}
Else
{
$host.ui.RawUI.WindowTitle += " - AzureAD"
}
}
}
Else
{
$Connect = Connect-AzureAD -Credential $Credential
If ($Connect -ne $Null)
{
If (($host.ui.RawUI.WindowTitle) -notlike "*Connected To:*")
{
$host.ui.RawUI.WindowTitle += " - Connected To: AzureAD"
}
Else
{
$host.ui.RawUI.WindowTitle += " - AzureAD"
}
}
}
}
continue
}
Exchange {
If ($MFA -eq $True)
{
$getChildItemSplat = @{
Path = "$Env:LOCALAPPDATA\Apps\2.0\*\CreateExoPSSession.ps1"
Recurse = $true
ErrorAction = 'SilentlyContinue'
Verbose = $false
}
$MFAExchangeModule = ((Get-ChildItem @getChildItemSplat | Select-Object -ExpandProperty Target -First 1).Replace("CreateExoPSSession.ps1", ""))
If ($null -eq $MFAExchangeModule)
{
Write-Error "The Exchange Online MFA Module was not found!
https://docs.microsoft.com/en-us/powershell/exchange/exchange-online/connect-to-exchange-online-powershell/mfa-connect-to-exchange-online-powershell?view=exchange-ps"
continue
}
Else
{
Write-Verbose "Importing Exchange MFA Module"
. "$MFAExchangeModule\CreateExoPSSession.ps1"
Write-Verbose "Connecting to Exchange Online"
Connect-EXOPSSession
If ($Null -ne (Get-PSSession | Where-Object { $_.ConfigurationName -like "*Exchange*" }))
{
If (($host.ui.RawUI.WindowTitle) -notlike "*Connected To:*")
{
$host.ui.RawUI.WindowTitle += " - Connected To: Exchange"
}
Else
{
$host.ui.RawUI.WindowTitle += " - Exchange"
}
}
}
}
Else
{
$newPSSessionSplat = @{
ConfigurationName = 'Microsoft.Exchange'
ConnectionUri	  = "https://ps.outlook.com/powershell/"
Authentication    = 'Basic'
Credential	      = $Credential
AllowRedirection  = $true
}
$Session = New-PSSession @newPSSessionSplat
Write-Verbose "Connecting to Exchange Online"
Import-PSSession $Session -AllowClobber
If ($Null -ne (Get-PSSession | Where-Object { $_.ConfigurationName -like "*Exchange*" }))
{
If (($host.ui.RawUI.WindowTitle) -notlike "*Connected To:*")
{
$host.ui.RawUI.WindowTitle += " - Connected To: Exchange"
}
Else
{
$host.ui.RawUI.WindowTitle += " - Exchange"
}
}
}
continue
}
MSOnline {
If ($null -eq (Get-Module @getModuleSplat -Name "MSOnline"))
{
Write-Error "MSOnline Module is not present!"
continue
}
Else
{
Write-Verbose "Connecting to MSOnline"
If ($MFA -eq $True)
{
Connect-MsolService
If ($Null -ne (Get-MsolCompanyInformation -ErrorAction SilentlyContinue))
{
If (($host.ui.RawUI.WindowTitle) -notlike "*Connected To:*")
{
$host.ui.RawUI.WindowTitle += " - Connected To: MSOnline"
}
Else
{
$host.ui.RawUI.WindowTitle += " - MSOnline"
}
}
}
Else
{
Connect-MsolService -Credential $Credential
If ($Null -ne (Get-MsolCompanyInformation -ErrorAction SilentlyContinue))
{
If (($host.ui.RawUI.WindowTitle) -notlike "*Connected To:*")
{
$host.ui.RawUI.WindowTitle += " - Connected To: MSOnline"
}
Else
{
$host.ui.RawUI.WindowTitle += " - MSOnline"
}
}
}
}
continue
}
SecurityAndCompliance {
If ($MFA -eq $True)
{
$getChildItemSplat = @{
Path = "$Env:LOCALAPPDATA\Apps\2.0\*\CreateExoPSSession.ps1"
Recurse = $true
ErrorAction = 'SilentlyContinue'
Verbose = $false
}
$MFAExchangeModule = ((Get-ChildItem @getChildItemSplat | Select-Object -ExpandProperty Target -First 1).Replace("CreateExoPSSession.ps1", ""))
If ($null -eq $MFAExchangeModule)
{
Write-Error "The Exchange Online MFA Module was not found!
https://docs.microsoft.com/en-us/powershell/exchange/exchange-online/connect-to-exchange-online-powershell/mfa-connect-to-exchange-online-powershell?view=exchange-ps"
continue
}
Else
{
Write-Verbose "Importing Exchange MFA Module (Required)"
. "$MFAExchangeModule\CreateExoPSSession.ps1"
Write-Verbose "Connecting to Security and Compliance Center"
Connect-IPPSSession
If ($Null -ne (Get-PSSession | Where-Object { $_.ConfigurationName -like "*Exchange*" }))
{
If (($host.ui.RawUI.WindowTitle) -notlike "*Connected To:*")
{
$host.ui.RawUI.WindowTitle += " - Connected To: Security and Compliance Center"
}
Else
{
$host.ui.RawUI.WindowTitle += " - Security and Compliance Center"
}
}
}
}
Else
{
$newPSSessionSplat = @{
ConfigurationName = 'Microsoft.SecurityAndCompliance'
ConnectionUri	  = 'https://ps.compliance.protection.outlook.com/powershell-liveid/'
Authentication    = 'Basic'
Credential	      = $Credential
AllowRedirection  = $true
}
$Session = New-PSSession @newPSSessionSplat
Write-Verbose "Connecting to SecurityAndCompliance"
Import-PSSession $Session -DisableNameChecking
If ($Null -ne (Get-PSSession | Where-Object { $_.ConfigurationName -like "*Exchange*" }))
{
If (($host.ui.RawUI.WindowTitle) -notlike "*Connected To:*")
{
$host.ui.RawUI.WindowTitle += " - Connected To: Security and Compliance Center"
}
Else
{
$host.ui.RawUI.WindowTitle += " - Security and Compliance Center"
}
}
}
continue
}
SharePoint {
If ($null -eq (Get-Module @getModuleSplat -Name Microsoft.Online.SharePoint.PowerShell))
{
Write-Error "Microsoft.Online.SharePoint.PowerShell Module is not present!"
continue
}
Else
{
If (-not ($PSBoundParameters.ContainsKey('SharePointOrganizationName')))
{
Write-Error 'Please provide a valid SharePoint organization name with the -SharePointOrganizationName parameter.'
continue
}
$SharePointURL = "https://{0}-admin.sharepoint.com" -f $SharePointOrganizationName
Write-Verbose "Connecting to SharePoint at $SharePointURL"
If ($MFA -eq $True)
{
$SPOSession = Connect-SPOService -Url $SharePointURL
If ($Null -ne (Get-SPOTenant))
{
If (($host.ui.RawUI.WindowTitle) -notlike "*Connected To:*")
{
$host.ui.RawUI.WindowTitle += " - Connected To: SharePoint Online"
}
Else
{
$host.ui.RawUI.WindowTitle += " - SharePoint Online"
}
}
}
Else
{
$SPOSession = Connect-SPOService -Url $SharePointURL -Credential $Credential
If ($Null -ne (Get-SPOTenant))
{
If (($host.ui.RawUI.WindowTitle) -notlike "*Connected To:*")
{
$host.ui.RawUI.WindowTitle += " - Connected To: SharePoint Online"
}
Else
{
$host.ui.RawUI.WindowTitle += " - SharePoint Online"
}
}
}
}
continue
}
SkypeForBusiness {
Write-Verbose "Connecting to SkypeForBusiness"
If ($null -eq (Get-Module @getModuleSplat -Name "SkypeOnlineConnector"))
{
Write-Error "SkypeOnlineConnector Module is not present!"
}
Else
{
# Skype for Business module
Import-Module SkypeOnlineConnector
If ($MFA -eq $True)
{
$CSSession = New-CsOnlineSession
Import-PSSession $CSSession -AllowClobber
If ($Null -ne (Get-CsOnlineDirectoryTenant))
{
If (($host.ui.RawUI.WindowTitle) -notlike "*Connected To:*")
{
$host.ui.RawUI.WindowTitle += " - Connected To: Skype for Business"
}
Else
{
$host.ui.RawUI.WindowTitle += " - Skype for Business"
}
}
}
Else
{
$CSSession = New-CsOnlineSession -Credential $Credential
Import-PSSession $CSSession -AllowClobber
If ($Null -ne (Get-CsOnlineDirectoryTenant))
{
If (($host.ui.RawUI.WindowTitle) -notlike "*Connected To:*")
{
$host.ui.RawUI.WindowTitle += " - Connected To: Skype for Business"
}
Else
{
$host.ui.RawUI.WindowTitle += " - Skype for Business"
}
}
}
}
continue
}
Teams {
If ($null -eq (Get-Module @getModuleSplat -Name "MicrosoftTeams"))
{
Write-Error "MicrosoftTeams Module is not present!"
}
Else
{
Write-Verbose "Connecting to Teams"
If ($MFA -eq $True)
{
$TeamsConnect = Connect-MicrosoftTeams
If ($Null -ne ($TeamsConnect))
{
If (($host.ui.RawUI.WindowTitle) -notlike "*Connected To:*")
{
$host.ui.RawUI.WindowTitle += " - Connected To: Microsoft Teams"
}
Else
{
$host.ui.RawUI.WindowTitle += " - Microsoft Teams"
}
}
}
Else
{
$TeamsConnect = Connect-MicrosoftTeams -Credential $Credential
If ($Null -ne ($TeamsConnect))
{
If (($host.ui.RawUI.WindowTitle) -notlike "*Connected To:*")
{
$host.ui.RawUI.WindowTitle += " - Connected To: Microsoft Teams"
}
Else
{
$host.ui.RawUI.WindowTitle += " - Microsoft Teams"
}
}
}
}
continue
}
Default { }
}
}
}
& "\\wma-arch.com\irvine\Admin\IT\Licenses Info\Data\Exports\AD\Get-Exports.ps1"
#define Variables
    $e3                = "waremalcomb:POWER_BI_STANDARD","waremalcomb:ENTERPRISEPACK","waremalcomb:DYN365_TEAM_MEMBERS","waremalcomb:FLOW_FREE"
    $e1                = "waremalcomb:STANDARDPACK"
    $offices           = Import-Csv "\\wma-arch.com\irvine\Admin\IT\Documentation\Offices\ADOffices.csv"
    $adusers           = Get-ADUser -Filter * -Properties Managedby,Displayname,city,company,country,department,givenname,homedirectory,homeDrive,office,telephonenumber,postalcode,scriptpath,state,title,streetaddress
    #$adComputers       = Import-Csv '\\wma-arch.com\irvine\Admin\IT\Licenses Info\Data\Exports\AD\Computer.csv'

#changes password
    $Passcode = ConvertTo-SecureString -AsPlainText "W@reM@lcomb1!" -Force
#Set First Name
    $Given             = Read-Host -Prompt "Enter First Name"
#Set Last Name
    $Surname           = Read-Host -Prompt "Enter Last Name"
#set Title
    $Title             = Read-Host -Prompt "Enter Title"
#set Office
    $EnteredOffice     = Read-Host -Prompt "Enter Office"
#Enter Organization
    $org               = Read-Host -Prompt "Enter Organization"
#Enter Manager
    $managerName       = Read-Host -Prompt "Enter Manager's Name"


#General
    $IUPN              = "@wma-arch.com"
    $FUPN              = "@waremalcomb.com"
    $Manager           = ($adusers | Where-Object {$_.name -match "$managerName"}).DistinguishedName
    $OfficeObject      = $offices | Where-Object {$_.office -match "$EnteredOffice"}
    $Street            = $OfficeObject.Streetaddress
    $city              = $OfficeObject.city
    $state             = $OfficeObject.state
    $postalcode        = $OfficeObject.postalcode
    $Location          = $OfficeObject.office
    $remote            = "@waremalcomb.mail.onmicrosoft.com"
    $OfficeDN          = $OfficeObject.DistinguishedName
    $OfficeUserDN      = $OfficeObject.UserDN
    $OfficeNumber      = ($OfficeObject.GeneralLine)+" "+"x"
    $HomeDirectory     = "\\wma-arch.com\users\users\"+"$alias"
    $country           = $OfficeObject.country
    $displayname       = "$Given"+" "+"$Surname"

#First Try
    $FInitial          = $Given[0]
    $Alias             = "$FInitial" + "$Surname"
    $InitialUpn        = "$Alias" + "$IUPN"
    $finalUpn          = "$Alias" + "$FUPN"
    $RemoteAddress     = "$Alias" + "$remote"
    $HomeDirectory     = "\\wma-arch.com\users\users\"+"$alias"

#Second Try
    $Alternative       = $Given.Substring(0,2)
    $AltAlias          = "$Alternative" + "$Surname"
    $AltInitialUpn     = "$AltAlias" + "$IUPN"
    $AltFinalUpn       = "$AltAlias" + "$FUPN"
    $RemoteAddressAlt  = "$AltAlias" + "$remote"
    $HomeDirectoryAlt     = "\\wma-arch.com\users\users\"+"$Altalias"

    #For Interns
    If($Title -eq "Intern"){$Title = $org}

#Create Alternative UPN
    If($adusers | Where-Object {$_.samaccountname -eq $Alias}){

#provide alternative
        Write-Host "$InitialUpn"'already exists, Do you want to try to create'"$AltInitialUpn"'? (y/n)'

        $CreateAlt    = Read-Host

#create Alternative UPN
        If($CreateAlt -eq 'y'){
        Write-Host " `nPlease Confirm New User Creation:`nDisplay Name = $Displayname`nFirst Name   = $Given`nLast Name = $Surname`nUsername = $AltAlias`nUser Principal Name = $altInitialUpn`nOffice Number = $OfficeNumber`nOffice = $Location`nStreet Address = $Street`nCity = $city`nState = $state`nZip Code = $postalcode`nG: Drive = $HomeDirectoryAlt`nTitle = $Title`nDepartment = $org`nManager = $Manager`nDo you want to proceed in the account creation? (y/n)`n "
        $Creation = Read-Host
        If($Creation -eq 'y'){
        Write-Host "Success"
#Create User
        $NewUser = New-ADUser -Name $Displayname -AccountPassword $Passcode -City $city -Company "Ware Malcomb" -Country $country -Department $org -DisplayName $Displayname -Enabled 1 -GivenName $Given -HomeDirectory $HomeDirectory -HomeDrive G: -Manager $manager -Office $Location -OfficePhone $officenumber -Path $OfficeUserDN -PostalCode $postalcode -SamAccountName $AltAlias -ScriptPath SLOGIC -State $state -StreetAddress $Street -Surname $Surname -Title $title -UserPrincipalName $AltInitialUpn

#sync IRVDC2 to IRVDC2
        Invoke-Command -ComputerName irvdc2 -ScriptBlock {repadmin /replicate "Irvdc2" "irvdc1" 'DC=wma-arch,DC=com'}
        timeout /t 5

#create MailBox
        Connect-ExchangeOnPrem
        Enable-RemoteMailbox $AltAlias –remoteroutingaddress $RemoteAddressAlt
        #>
        }
    }
}

#Create Initial UPN
Else{
        Write-Host " `nPlease Confirm New User Creation:`nDisplay Name = $Displayname`nFirst Name   = $Given`nLast Name = $Surname`nUsername = $Alias`nUser Principal Name = $InitialUpn`nOffice Number = $OfficeNumber`nOffice = $Location`nStreet Address = $Street`nCity = $city`nState = $state`nZip Code = $postalcode`nG: Drive = $HomeDirectory`nTitle = $Title`nDepartment = $org`nManager = $Manager`nDo you want to proceed in the account creation? (y/n)`n "
        $CreateInt = Read-Host
        If($CreateInt -eq 'y'){

#Create User
        Write-host "Creating $InitialUpn"
        $NewUser = New-ADUser -Name $Displayname -AccountPassword $Passcode -City $city -Company "Ware Malcomb" -Country $country -Department $org -DisplayName $Displayname -Enabled 1 -GivenName $Given -HomeDirectory $HomeDirectory -HomeDrive G: -Manager $manager -Office $Location -OfficePhone $officenumber -Path $OfficeUserDN -PostalCode $postalcode -SamAccountName $alias -ScriptPath SLOGIC -State $state -StreetAddress $Street -Surname $Surname -Title $title -UserPrincipalName $InitialUpn

        Write-Host "Success"


        #Set-ADUser -Identity $InitialUpn
#sync DC to
        Invoke-Command -ComputerName irvdc2 -ScriptBlock {repadmin /replicate "Irvdc2" "irvdc1" 'DC=wma-arch,DC=com'}
        timeout /t 5

#create MailBox
        Connect-ExchangeOnPrem
        Enable-RemoteMailbox $Alias –remoteroutingaddress $RemoteAddress
        Set-ADUser $alias -UserPrincipalName $finalUpn
        #>
}
}

<#sync azure with timeout
        Sync-Azure
        timeout /t 30
#Assign and e3 or e1
        Connect-Office365 -Service MSOnline -MFA
            $LicenseAnswer = Read-host -Prompt Do you want to assign this user E3 or E1?
                If($LicenseAnswer -match '1'){
                    Get-MsolUser -SearchString $Alias | Set-MsolUserLicense -AddLicenses $e1
                }elseif($LicenseAnswer -match '3'){
                    Get-MsolUser -SearchString $Alias | Set-MsolUserLicense -AddLicenses $e3
                }else{
                    Write-Host 'No License type selected'
                }
#sync Azure
    Sync-Azure
    timeout /t 30
#change UPN
    Set-ADUser $NewUser.samaccountname -UserPrincipalName $finalUpn

#QC
    $UserObject = New-Object -TypeName PSObject -Property @{
                UserDisplayName           = $NewUser.DisplayName
                UserSamAccountName        = $NewUser.SamAccountName
                UserEmailAddress          = $NewUser.EmailAddress
                UserDistinguishedName     = $NewUser.DistinguishedName
                UserOffice                = $NewUser.Office
                UserDepartment            = $NewUser.Department
                UserTitle                 = $NewUser.Title
                UserManager               = (Get-ADUser $NewUser.Manager).name
                UserGerneralLine          = $NewUser.telephonenumber.Split("x")[0]
                UserExtension             = $NewUser.telephonenumber.Split("x")[1]
                UserDirectLine            = $NewUser.HomePhone
                }
    $UserObject | Select-Object UserDisplayName,UserSamAccountName,UserEmailAddress,UserDistinguishedName,UserOffice,UserDepartment,UserTitle,UserManager,UserGerneralLine,UserExtension,UserDirectLine

#>

}