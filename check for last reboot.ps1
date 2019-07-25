$BimLeads = Get-ADGroupMember App_Autodesk2019-BIMLeads
$BimLeads.name | ForEach-Object {
   Invoke-Command -ComputerName $_ -ScriptBlock {Get-WmiObject win32_operatingsystem | select csname, @{LABEL='LastBootUpTime';EXPRESSION={$_.ConverttoDateTime($_.lastbootuptime)}}}
}