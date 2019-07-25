$Path1 = "\\wma-arch.com\irvine\Admin\Proposals\Atlanta Proposals"
$path2 = "\\wma-arch.com\irvine\Admin\Proposals\Mexico Proposals\2019"
Get-Acl -Path $Path1 | Set-Acl -Path $path2


