$ServerAddress = "wm-irvine-firewall-nrgwdtpdqc.dynamic-m.com"
$ConnectionName = "WM VPN"
$PresharedKey = "ZFRY<o>SohZvu)thGVp<uR31"
$Destination = "Your internal subnet here example 10.0.0.0/8"
Add-VpnConnection -Name $ConnectionName -ServerAddress $ServerAddress -TunnelType L2tp -L2tpPsk $PresharedKey -AuthenticationMethod Pap -Force
Start-Sleep -m 100
Set-VpnConnection -Name $ConnectionName -SplitTunneling $True
Start-Sleep -m 100
Add-Vpnconnectionroute -Connectionname $ConnectionName -DestinationPrefix $Destination