$computers = (Get-ADComputer -filter * | where {$_.distinguishedname -match 'cOMPUTERS,ou=mexico'}).nAME
$computers | foreach {
#define a named variable for the computername so that it can be used the Catch
#scriptblock
$computer = $_
Try {
  $os = Get-WmiObject win32_OperatingSystem -computername $computer -ErrorAction Stop
  #continue if there were no errors
  Get-WMIObject Win32_Logicaldisk -filter "deviceid='$($os.systemdrive)'" -ComputerName $computer
}
Catch {
  #$_ is the error object
  Write-Warning "Failed to get OperatingSystem information from $computer. $($_.Exception.Message)"
}
} | Select PSComputername,DeviceID,
@{Name="SizeGB";Expression={$_.Size/1GB -as [int]}},
@{Name="FreeGB";Expression={[math]::Round($_.Freespace/1GB,2)}}, 
@{Name="PercentAvailable";Expression={[math]::Round($_.Freespace/$_.Size,3)*100}}  |
Sort FreeGB | Format-Table –AutoSize