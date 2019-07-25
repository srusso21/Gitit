if((Test-Path -Path "C:\Program Files\Autodesk\Revit 2019\revit.exe") -eq $false){

#Install Revit 2019
Start-Process '\\wma-arch.com\r\Resour\ITSupport\Software\AutoDesk\RevitSeries\2019a\Img\Setup.exe' -ArgumentList '/qb /I \\wma-arch.com\r\Resour\ITSupport\Software\AutoDesk\RevitSeries\2019a\Img\Revit 2019 US.ini /Trial /language en-us' -Wait 

}