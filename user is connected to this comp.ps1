$Workstation = Get-ADComputer -Filter 'name -like "ws-*"' -Properties * | Where-Object {$_.enabled -eq "$true" -and $_.distinguishedname -notmatch "OU=ADMIN,DC=wma-arch,DC=com"}

Foreach($comp in $Workstation){
If ((Test-Connection -ComputerName $Comp.name -Count 1 -BufferSize 16 -Quiet) -eq $true ){

$user = Invoke-Command -ComputerName $Comp.name -ScriptBlock {(Get-CimInstance cim_computersystem -Property *).username -split 'wma-arch.com\\'}
$DisplayName = (Get-ADUser -Identity "$user" -Properties displayname).displayname
$computername = $comp.name
 Write-host "$DisplayName is using $computername"
 Remove-Variable $user
}
}
