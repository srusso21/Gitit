$offices = "Atlanta", 
"Chicago", 
"Oak Brook", 
"Denver", 
"Denver Civil Engineering", 
"Downtown San Diego", 
"Houston", 
"Irvine", 
"Los Angeles", 
"Mexico City", 
"Miami", 
"New Jersey", 
"New York", 
"Panama", 
"Phoenix", 
"Pleasanton", 
"Princeton", 
"San Diego", 
"San Franciso", 
"Seattle", 
"Toronto",
"Vaughan"

$offices | ForEach-Object {

Copy-Item -Path \\wma-arch.com\r\resour\ITSupport\Software\L2TP_VPN\Content.zip -Destination "C:\Temp\Project\$_\" -Force

















}
