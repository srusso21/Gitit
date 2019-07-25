#Set-ExecutionPolicy -ExecutionPolicy Bypass
$office = Read-Host "Enter Office Name"
$computers = Get-ADComputer -Filter * | Where-Object {$_.distinguishedname -match "$office"}

Foreach($Comp in $Computers){
$comp = "ws-1934"
Write-Host "Attempting to connect to $Comp"
If(Test-Connection -BufferSize 8 -ComputerName $Comp -Count 1 -Quiet){
Write-Host "$Comp.name is connected"
Invoke-Command -ComputerName $Comp -ScriptBlock {
Enable-BitLocker C: -StartupKeyProtector -StartupKeyPath \\wma-arch.com\irvine\Admin\IT\Users\SRusso\Keys\ -SkipHardwareTest
} -Credential "wma-arch.com\$env:username"
}
