
<#Find out OU, copy files, based on OU, invoke command to execute.

#Splitting the Array
$NumberOfArrays = 10
$NewArrays = @{}
$i = 0
$comps | ForEach-Object  {
    $NewArrays[$i % $NumberOfArrays] += @($_)
    $i++
}

#

$0 = ForEach ($c in $NewArrays[0]){
If(Test-Connection -ComputerName $c -Quiet -Count 1 -BufferSize 8){
#Find out OU, copy files, based on OU, invoke command to execute.

}
}
$1 = ForEach ($c in $NewArrays[1]){
If(Test-Connection -ComputerName $c -Quiet -Count 1 -BufferSize 8){
#Find out OU, copy files, based on OU, invoke command to execute.
Write-Host $c
}
}
$2 = ForEach ($c in $NewArrays[2]){
If(Test-Connection -ComputerName $c -Quiet -Count 1 -BufferSize 8){
#Find out OU, copy files, based on OU, invoke command to execute.
Write-Host $c
}
}
$3 = ForEach ($c in $NewArrays[3]){
If(Test-Connection -ComputerName $c -Quiet -Count 1 -BufferSize 8){
#Find out OU, copy files, based on OU, invoke command to execute.
Write-Host $c
}
}
$4 = ForEach ($c in $NewArrays[4]){
If(Test-Connection -ComputerName $c -Quiet -Count 1 -BufferSize 8){
#Find out OU, copy files, based on OU, invoke command to execute.
Write-Host $c
}
}
$5 = ForEach ($c in $NewArrays[5]){
If(Test-Connection -ComputerName $c -Quiet -Count 1 -BufferSize 8){
#Find out OU, copy files, based on OU, invoke command to execute.
Write-Host $c
}
}
$6 = ForEach ($c in $NewArrays[6]){
If(Test-Connection -ComputerName $c -Quiet -Count 1 -BufferSize 8){
#Find out OU, copy files, based on OU, invoke command to execute.
Write-Host $c
}
}
$7 = ForEach ($c in $NewArrays[7]){
If(Test-Connection -ComputerName $c -Quiet -Count 1 -BufferSize 8){
#Find out OU, copy files, based on OU, invoke command to execute.
Write-Host $c
}
}
$8 = ForEach ($c in $NewArrays[8]){
If(Test-Connection -ComputerName $c -Quiet -Count 1 -BufferSize 8){
#Find out OU, copy files, based on OU, invoke command to execute.
Write-Host $c
}
}
$9 = ForEach ($c in $NewArrays[9]){
If(Test-Connection -ComputerName $c -Quiet -Count 1 -BufferSize 8){
#Find out OU, copy files, based on OU, invoke command to execute.
Write-Host $c
}
}
#>