Start-Process C:\Windows\System32\msiexec.exe -ArgumentList "/x{7346B4A0-1700-0510-0000-705C0D862004} /passive /norestart" -Wait

Start-Process C:\Windows\System32\msiexec.exe -ArgumentList "/x{28B89EEF-0001-0000-0102-CF3F3A09B77D} /passive /norestart" -Wait

Start-Process \\wma-arch.com\r\Resour\ITSupport\Software\AutoDesk\AutoCAD\AutoCAD2017_sa\Img\Setup.exe -ArgumentList "/qb /I AutoCAD 2017 USA SA.ini /Trial /language en-us" -Wait

Start-Process \\wma-arch.com\r\Resour\ITSupport\Software\AutoDesk\RevitSeries\2017_sa\Img\Setup.exe  -ArgumentList "/qb /I Revit 2017 US SA.ini /Trial /language en-us" -Wait
