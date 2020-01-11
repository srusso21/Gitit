function Google{
    Begin{
$query='https://www.google.com/search?q='
}
Process
{
if ($args.Count -eq 0)
{
"Args were empty, commiting `$input to `$args"
Set-Variable -Name args -Value (@($input) | % {$_})
"Args now equals $args"
$args = $args.Split()
}
ELSE
{
"Args had value, using them instead"
}

Write-Host $args.Count, "Arguments detected"
"Parsing out Arguments: $args"
for ($i=0;$i -le $args.Count;$i++){
$args | % {"Arg $i `t $_ `t Length `t" + $_.Length, " characters"} }

$args | % {$query = $query + "$_+"}

}
End
{
$url = $query.Substring(0,$query.Length-1)
"Final Search will be $url `nInvoking..."
start "$url"
}
}
