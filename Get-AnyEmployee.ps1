function Get-AnyEmployee {

    #Which User
    Param ($who = (Read-Host -Prompt "Enter Employee Name"))

    #Grab User Information
    $users      = Get-ADUser -Filter * -Properties DisplayName,EmailAddress,Office,Department,Title,Manager,HomePhone,telephonenumber | Where-Object {$_.DisplayName -match "$who"}

    #Increment
    $i          = 0

    #More than 1 User
if($users.count -gt 1){
	while($i -LT $users.count){
		$string = "Press "
		$string += $i+1
		$string += " for "
		$string += $users.DisplayName[$i]
		$string += "`n"
		write-host $string
		$i++
	}
	$answer = read-host "Answer "
    
	$Name = $users.DisplayName[($answer-1)]

    

    $UserObject = New-Object -TypeName PSObject -Property @{
                UserDisplayName                = $users[($answer-1)].DisplayName 
                UserSamAccountName             = $users[($answer-1)].SamAccountName
                UserEmailAddress               = $users[($answer-1)].EmailAddress
                UserDistinguishedName          = $users[($answer-1)].DistinguishedName
                UserOffice                     = $users[($answer-1)].Office
                UserDepartment                 = $users[($answer-1)].Department
                UserTitle                      = $users[($answer-1)].Title
                UserManager                    = (Get-ADUser $users[($answer-1)].Manager).name
                UserGerneralLine               = $users[($answer-1)].telephonenumber.Split("x")[0]
                UserExtension                  = $users[($answer-1)].telephonenumber.Split("x")[1]
                UserDirectLine                 = $users[($answer-1)].HomePhone
    }

	$UserObject | Select-Object UserDisplayName,UserSamAccountName,UserEmailAddress,UserDistinguishedName,UserOffice,UserDepartment,UserTitle,UserManager,UserGerneralLine,UserExtension,UserPhone

    $comp      = Get-ADComputer -Filter * -Properties Description,samaccountname | Where-Object {$_.Description -match "$Name" -and $_.distinguishedname -notmatch "retired"}

    	
    Try{
    $connected = Test-Connection -ComputerName $comp.Name -Count 1 -Quiet -ErrorAction SilentlyContinue
    }
    Catch{}

	if($comp -eq $null){

		write-host "There is no computer!"

	} else{

 $ComputerObject = New-Object -TypeName PSObject -Property @{            
                 ComputerName              = $comp.Name
                 ComputerSamAccountName    = $comp.SamAccountName
                 ComputerDescription       = $comp.Description
                 ComputerDistinguishedname = $comp.Distinguishedname
                 IsConnected               = $Connected
    }

    $ComputerObject | Select-Object ComputerName,ComputerSamAccountName,ComputerDescription,ComputerDistinguishedname,IsConnected

}

} 
#1 User
if(@($users).count -eq 1){
	$Name = $users.DisplayName

    $UserObject = New-Object -TypeName PSObject -Property @{
                UserDisplayName           = $users.DisplayName 
                UserSamAccountName        = $users.SamAccountName
                UserEmailAddress          = $users.EmailAddress
                UserDistinguishedName     = $users.DistinguishedName
                UserOffice                = $users.Office
                UserDepartment            = $users.Department
                UserTitle                 = $users.Title
                UserManager               = (Get-ADUser $users.Manager).name
                UserGerneralLine          = $users.telephonenumber.Split("x")[0]
                UserExtension             = $users.telephonenumber.Split("x")[1]
                UserDirectLine            = $users.HomePhone
    }

	
	$comp      = Get-ADComputer -Filter * -Properties Description,samaccountname | Where-Object {$_.Description -match "$Name" -and $_.distinguishedname -notmatch "retired"}
     Try{
    $connected = Test-Connection -ComputerName $comp.Name -Count 1 -Quiet -ErrorAction SilentlyContinue
    }
    Catch{}

    $UserObject | Select-Object UserDisplayName,UserSamAccountName,UserEmailAddress,UserDistinguishedName,UserOffice,UserDepartment,UserTitle,UserManager,UserGerneralLine,UserExtension,UserDirectLine	
	if($comp -eq $null){write-host "There is no computer!"}
	else{    

    $ComputerObject = New-Object -TypeName PSObject -Property @{            
                ComputerName              = $comp.Name
                ComputerSamAccountName    = $comp.SamAccountName
                ComputerDescription       = $comp.Description
                ComputerDistinguishedname = $comp.Distinguishedname
                IsConnected               = $Connected
    }

    $ComputerObject | Select-Object ComputerName,ComputerSamAccountName,ComputerDescription,ComputerDistinguishedname,IsConnected}

}
#0 Users
if(@($users).count -eq 0){
	write-host "No users found"
}
}
<#
    $comp      = Get-ADComputer -Filter * -Properties Description | Where-Object {$_.Description -match "$Name" -and $_.distinguishedname -notmatch "retired"}
    $connected = Test-Connection -ComputerName $comp.Name -Count 1 -Quiet -ErrorAction SilentlyContinue
   
    $UserObject = New-Object -TypeName PSObject -Property @{
                UserDisplayName           = $user.DisplayName 
                UserSamAccountName        = $user.SamAccountName
                UserEmailAddress          = $user.EmailAddress
                UserDistinguishedName     = $user.DistinguishedName
                UserOffice                = $user.Office
                UserDepartment            = $user.Department
                UserTitle                 = $user.Title
                UserPhone                 = $user.HomePhone
    }
    $UserObject | Select-Object UserDisplayName,UserSamAccountName,UserEmailAddress,UserDistinguishedName,UserOffice,UserDepartment,UserTitle,UserPhone

    $ComputerObject = New-Object -TypeName PSObject -Property @{            
                ComputerName              = $comp.Name
                ComputerDescription       = $comp.Description
                ComputerDistinguishedname = $comp.Distinguishedname
                IsConnected               = $Connected
    }
    $ComputerObject | Select-Object ComputerName,ComputerDescription,ComputerDistinguishedname,IsConnected
}
#>