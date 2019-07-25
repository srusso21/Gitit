function Find-Computer {
    Param (
    $who = (Read-Host -Prompt "Enter Employee Name")
    )
    $comp = Get-ADComputer -Filter * -Properties Description | Where-Object {$_.Description -match "$who" -and $_.distinguishedname -notmatch "retired"}
    $comp | select name,description,distinguishedname

}