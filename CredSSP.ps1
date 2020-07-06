$credential = Get-Credential -Credential (whoami)

Invoke-Command -ComputerName irvdeploy  -ScriptBlock {Enable-WSManCredSSP -Role Client -DelegateComputer irvtask.wma-arch.com -Force}

$session = New-PSSession irvdeploy -Credential $credential -Authentication Credssp

Invoke-Command -Session $session -ScriptBlock {Test-Path \\wma-arch.com\r\resour\ITSupport\Software\L2TP_VPN\Install-WMVPN.ps1}
<#
Invoke-Command -Session $session -ScriptBlock {

  Import-Module -Name \\dc1\Share\PSWindowsUpdate }

Invoke-Command -Session $session -ScriptBlock {Get-WUHistory }#>