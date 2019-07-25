$Remote      = Read-Host "Enter Computername"
$Source      = Read-host "Enter Path of File to Copy"
$Session     = New-PSSession -ComputerName $Remote
$Destination = C:\Temp\
if (!(Test-Path -path $Destination)) {New-Item $destinationFolder -Type Directory}
Copy-Item -Path  $Source -Destination $Destination -Recurse -Force -ToSession $Session