Invoke-Command -ComputerName irvdc1 -ScriptBlock {
function Get-AnyEmployee {

    #Which User
    Param ($who = (Read-Host -Prompt "Enter First or Last Name"))

    #Grab User Information
    $users      = Get-ADUser -Filter * -Properties * | Where-Object {$_.DisplayName -match "$who"}

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
                DisplayName                = $users[($answer-1)].DisplayName
                SamAccountname             = $users[($answer-1)].SamAccountName
                EmailAddress               = $users[($answer-1)].EmailAddress
                DN                         = $users[($answer-1)].DistinguishedName
                Office                     = $users[($answer-1)].Office
                Department                 = $users[($answer-1)].Department
                Title                      = $users[($answer-1)].Title
                TelephoneNumber            = $users[($answer-1)].telephonenumber
                DirectLine                 = $users[($answer-1)].HomePhone
       }

	$UserObject | Select-Object DisplayName,SamAccountname,EmailAddress,DN,Office,Department,Title,TelephoneNumber,DirectLine

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
                Description               = $comp.Description
                ComputerDN                = $comp.Distinguishedname
                IsConnected               = $Connected
    }

    $ComputerObject | Select-Object ComputerName,Description,ComputerDN,IsConnected
}

}
#1 User
if(@($users).count -eq 1){
	$Name = $users.DisplayName

    $UserObject = New-Object -TypeName PSObject -Property @{
                DisplayName                = $users.DisplayName
                SamAccountname             = $users.SamAccountName
                EmailAddress               = $users.EmailAddress
                DN                         = $users.DistinguishedName
                Office                     = $users.Office
                Department                 = $users.Department
                Title                      = $users.Title
                TelephoneNumber            = $users.telephonenumber
                DirectLine                 = $users.HomePhone
                   }


	$comp      = Get-ADComputer -Filter * -Properties Description,samaccountname | Where-Object {$_.Description -match "$Name" -and $_.distinguishedname -notmatch "retired"}
     Try{
    $connected = Test-Connection -ComputerName $comp.Name -Count 1 -Quiet -ErrorAction SilentlyContinue
    }
    Catch{}

    $UserObject | Select-Object DisplayName,SamAccountname,EmailAddress,DN,Office,Department,Title,TelephoneNumber,DirectLine

	if($comp -eq $null){write-host "There is no computer!"}
	else{

    $ComputerObject = New-Object -TypeName PSObject -Property @{
                ComputerName              = $comp.Name
                Description               = $comp.Description
                ComputerDN                = $comp.Distinguishedname
                IsConnected               = $Connected
    }

    $ComputerObject | Select-Object ComputerName,Description,ComputerDN,IsConnected}

}
#0 Users
if(@($users).count -eq 0){
	write-host "No users found"
}
}
Get-AnyEmployee 'staci tave'
}

