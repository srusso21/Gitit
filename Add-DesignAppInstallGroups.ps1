param(
       [Parameter(Mandatory = $True)]
       $ComputerName
)
$member = (Get-ADComputer -Identity $ComputerName).SamAccountName

Add-ADGroupMember -Identity app_sketchup_2019 -Members $member -PassThru
Add-ADGroupMember -Identity app_adobeCC -Members $member -PassThru