param (
[Parameter(Mandatory = $true)]$ComputerName,
[Parameter(Mandatory = $false)]$FileName,
[Parameter(Mandatory = $true)]$FilePath)

$RemotePath       = "\\$ComputerName\c$\Temp"

$WorkingDirectory = "C:\Temp"
         

If(Test-Connection -ComputerName "$ComputerName" -BufferSize 1 -Count 1 -Quiet){
If(($FileName) -ne $null){
Copy-Item -Path "$FilePath\$FileName" -Destination $RemotePath -Force
}
if(($FileName) -eq $null){
Copy-Item -Path "$FilePath" -Destination $RemotePath -Force -Recurse}
}
}}else{Write-Host -ForegroundColor Red "Can't Ping $ComputerName"}
