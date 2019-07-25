




Get-ADGroup -Filter * | Where-Object {$_.name -match ""}

function Get-UserToComputer {

    #Which User
    Param ($who = (Read-Host -Prompt "Enter Employee Name"))

    #Grab User Information
    $users      = Get-ADUser -Filter * -Properties DisplayName | Where-Object {$_.DisplayName -match "$who"}

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

    $comp      = Get-ADComputer -Filter * -Properties Description | Where-Object {$_.Description -match "$Name" -and $_.distinguishedname -notmatch "retired"}

    	
 	if($comp -eq $null){

		write-host "There is no computer!"

	} else{

    #Found the right user now add to the right group

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
                UserPhone                 = $users.HomePhone
    }

	
	$comp      = Get-ADComputer -Filter * -Properties Description | Where-Object {$_.Description -match "$Name" -and $_.distinguishedname -notmatch "retired"}
     Try{
    $connected = Test-Connection -ComputerName $comp.Name -Count 1 -Quiet -ErrorAction SilentlyContinue
    }
    Catch{}

    $UserObject | Select-Object UserDisplayName,UserSamAccountName,UserEmailAddress,UserDistinguishedName,UserOffice,UserDepartment,UserTitle,UserPhone	
	if($comp -eq $null){write-host "There is no computer!"}
	else{    

    $ComputerObject = New-Object -TypeName PSObject -Property @{            
                ComputerName              = $comp.Name
                ComputerSamAccountname    = $comp.SamAccountname
                ComputerDescription       = $comp.Description
                ComputerDistinguishedname = $comp.Distinguishedname
                IsConnected               = $Connected
    }

    $ComputerObject | Select-Object ComputerName,samaccountname,ComputerDescription,ComputerDistinguishedname,IsConnected}

}
#0 Users
if(@($users).count -eq 0){
	write-host "No users found"
}
}

