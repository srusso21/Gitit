function Uninstall-Software {
param(
$Program = (Read-Host -Prompt 'Enter software name')
)
$software = Get-WmiObject -Class win32_product | Where-Object {$_.name -match "$Program"}
$ProgramToUninstall = $software.name
$confirmation = Read-Host "Are you Sure You Want To Uninstall $ProgramToUninstall"
if ($confirmation -eq 'y') {
  $software.uninstall | Out-Null
  

}
}
<#

$list = 'host1','host2','host3'   # your hosts go here
$name = 'appname'                 # your application name goes here (as displayed by win32_product instance)
$list | foreach {
    $hostname = $_
    gwmi win32_product -filter "Name = '$name'" -namespace root/cimv2 -comp $_ | foreach {
        if ($_.uninstall().returnvalue -eq 0) { write-host "Successfully uninstalled $name from $($hostname)" }
        else { write-warning "Failed to uninstall $name from $($hostname)." }
    }
}

#>