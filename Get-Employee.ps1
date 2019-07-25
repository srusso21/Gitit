function Get-Employee {

    #Which User
    Param ($who = (Read-Host -Prompt "Enter Employee Name"))

    #Grab User Information
    $user      = Get-ADUser -Filter * -Properties DisplayName,EmailAddress,Office,Department,Title,HomePhone | Where-Object {$_.DisplayName -match "$who"}

    #Increment
    $i = 0

    $comp      = Get-ADComputer -Filter * -Properties Description | Where-Object {$_.Description -match "$who" -and $_.distinguishedname -notmatch "retired"}
    $connected = Test-Connection -ComputerName $comp.Name -Count 1 -Quiet -ErrorAction SilentlyContinue
   
    $AllObjects = New-Object -TypeName PSObject -Property @{
                UserDisplayName           = $user.DisplayName 
                UserSamAccountName        = $user.SamAccountName
                UserEmailAddress          = $user.EmailAddress
                UserDistinguishedName     = $user.DistinguishedName
                UserOffice                = $user.Office
                UserDepartment            = $user.Department
                UserTitle                 = $user.Title
                UserPhone                 = $user.HomePhone
                ComputerName              = $comp.Name
                ComputerDescription       = $comp.Description
                ComputerDistinguishedname = $comp.Distinguishedname
                IsConnected               = $Connected
    } 
    $AllObjects | Select-Object UserDisplayName,UserSamAccountName,UserEmailAddress,UserDistinguishedName,UserOffice,UserDepartment,UserTitle,UserPhone,ComputerName,ComputerDescription,ComputerDistinguishedname,IsConnected
}
