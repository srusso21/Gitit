function New-Shortcut {
param(
    [string][Parameter(Mandatory=$true)]$ShortcutPath,
    [string][Parameter(Mandatory=$true)]$ShortcutName,
    [string][Parameter(Mandatory=$true)]$Program,
    [string][Parameter]$Arguments
)
$Arguments = "timeout /t 5"
$TotalArguments = "/c"+" "+"""$Arguments"""
$obj = New-Object -ComObject WScript.Shell
$Shortcut = $obj.CreateShortcut($ShortcutPath)
$Shortcut.TargetPath = "$Program"
$Shortcut.Arguments = "$TotalArguments" 
#Need to Find more Window Styles
#$obj.WindowStyle = 7
#$obj.IconLocation = $IconFilePath,0
[string]$Shortcut.WorkingDirectory = "C:\Temp"
$Shortcut.Fullname = "$ShortcutPath\$ShortcutName.lnk"
$Shortcut.Save()
}