﻿set-VpnConnection -Name "WM VPN" -AllUserConnection -SplitTunneling $True
Add-VpnConnectionRoute -ConnectionName "WM VPN" -DestinationPrefix 192.168.0.0/24 -passthru
Add-VpnConnectionRoute -ConnectionName "WM VPN" -DestinationPrefix 192.168.1.0/24 -passthru
Add-VpnConnectionRoute -ConnectionName "WM VPN" -DestinationPrefix 192.168.2.0/24 -passthru
Add-VpnConnectionRoute -ConnectionName "WM VPN" -DestinationPrefix 192.168.3.0/24 -passthru
Add-VpnConnectionRoute -ConnectionName "WM VPN" -DestinationPrefix 192.168.4.0/24 -passthru
Add-VpnConnectionRoute -ConnectionName "WM VPN" -DestinationPrefix 192.168.5.0/24 -passthru
Add-VpnConnectionRoute -ConnectionName "WM VPN" -DestinationPrefix 192.168.6.0/24 -passthru
Add-VpnConnectionRoute -ConnectionName "WM VPN" -DestinationPrefix 192.168.7.0/24 -passthru
Add-VpnConnectionRoute -ConnectionName "WM VPN" -DestinationPrefix 192.168.8.0/24 -passthru
Add-VpnConnectionRoute -ConnectionName "WM VPN" -DestinationPrefix 192.168.9.0/24 -passthru
Add-VpnConnectionRoute -ConnectionName "WM VPN" -DestinationPrefix 192.168.10.0/24 -passthru
Add-VpnConnectionRoute -ConnectionName "WM VPN" -DestinationPrefix 192.168.11.0/24 -passthru
Add-VpnConnectionRoute -ConnectionName "WM VPN" -DestinationPrefix 192.168.12.0/24 -passthru
Add-VpnConnectionRoute -ConnectionName "WM VPN" -DestinationPrefix 192.168.13.0/24 -passthru
Add-VpnConnectionRoute -ConnectionName "WM VPN" -DestinationPrefix 192.168.14.0/24 -passthru
Add-VpnConnectionRoute -ConnectionName "WM VPN" -DestinationPrefix 192.168.15.0/24 -passthru
Add-VpnConnectionRoute -ConnectionName "WM VPN" -DestinationPrefix 192.168.16.0/24 -passthru
Add-VpnConnectionRoute -ConnectionName "WM VPN" -DestinationPrefix 192.168.17.0/24 -passthru
Add-VpnConnectionRoute -ConnectionName "WM VPN" -DestinationPrefix 192.168.18.0/24 -passthru
Add-VpnConnectionRoute -ConnectionName "WM VPN" -DestinationPrefix 192.168.19.0/24 -passthru
Add-VpnConnectionRoute -ConnectionName "WM VPN" -DestinationPrefix 192.168.20.0/24 -passthru
Add-VpnConnectionRoute -ConnectionName "WM VPN" -DestinationPrefix 192.168.21.0/24 -passthru
Add-VpnConnectionRoute -ConnectionName "WM VPN" -DestinationPrefix 192.168.23.0/24 -passthru
Add-VpnConnectionRoute -ConnectionName "WM VPN" -DestinationPrefix 192.168.24.0/24 -passthru
Add-VpnConnectionRoute -ConnectionName "WM VPN" -DestinationPrefix 10.1.50.0/24 -PassThru
Add-VpnConnectionRoute -ConnectionName "WM VPN" -DestinationPrefix 10.1.1.0/24 -PassThru
Add-VpnConnectionRoute -ConnectionName "WM VPN" -DestinationPrefix 10.1.0.0/24 -PassThru
