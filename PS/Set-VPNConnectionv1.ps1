$ServerAddress = "wm-irvine-firewall-nrgwdtpdqc.dynamic-m.com"
$ConnectionName = "WM VPN"
$PresharedKey = "ZFRY<o>SohZvu)thGVp<uR31"
Add-VpnConnection -Name $ConnectionName -ServerAddress $ServerAddress -TunnelType L2tp -L2tpPsk $PresharedKey -AuthenticationMethod Pap -AllUserConnection -EncryptionLevel NoEncryption