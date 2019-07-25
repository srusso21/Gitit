[string]$extension = 'pdf'
[string]$executable = "C:\Program Files\Bluebeam Software\Bluebeam Revu\2017\Revu\Revu.exe"

if (-not (Test-Path $executable))
{
	$errorMessage = "`"$executable`" does not exist, not able to create association"

	throw $errorMessage
}
$extension = $extension.trim()
if (-not ($extension.StartsWith(".")))
{
	$extension = ".$extension"
}
$fileType = Split-Path $executable -leaf
$fileType = $fileType.Replace(" ", "_")
$elevated = @"
    cmd /c "assoc $extension=$fileType"
    cmd /c 'ftype $fileType="$executable" "%1" "%*"'
    Get-PSDrive -Name HKCR -PSProvider Registry
    Set-ItemProperty -Path "HKCR:\$fileType" -Name "(Default)" -Value "$fileType file" 
"@
Invoke-Expression $elevated

