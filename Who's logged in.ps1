function Get-LoggedInUser {
    Param ($Comp = (Read-Host -prompt "What is the workstation number?"))
    Invoke-Command -ComputerName $Comp -ScriptBlock {(Get-WmiObject -Class win32_process | Where-Object {$_.name -Match 'explorer'}).getowner().user[0]}}