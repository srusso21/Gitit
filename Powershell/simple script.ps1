$SAC = "c:\temp\StudioA_Computers.csv"
Get-ADGroupMember -Identity app_revit2017_usa_studioa | Export-Csv $SAC
Start-Process $SAC