function Assign-WMComputer {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $True)]
        $ComputerName,
        [Parameter(Mandatory = $False)]
        $UserName<#,
        [Parameter(ParameterSetName='Extra',Mandatory=$false)][switch]$Offline,      
        [Parameter(ParameterSetName='Extra',Mandatory=$true)][string]$MachineType
        [Parameter(Mandatory = $True)]
        [ValidateSet('Tower','Laptop')]
        $MachineType,
        [Parameter(Mandatory = $True)]
        $ComputerModel
        #>
        )

        $Pingable    = Test-Connection -ComputerName $ComputerName -Count 1 -BufferSize 8 -Quiet -ErrorAction SilentlyContinue

        #User
        If($UserName -ne $null){
        Write-Host -ForegroundColor Green "Looking for $UserName..."
        try{
        $UserObject  = Get-ADUser -Identity $UserName -Properties displayname -ErrorAction SilentlyContinue

        Write-Host -ForegroundColor Green "Found! $UserName"
        $Displayname = $UserObject.displayname

        If($UserObject.DistinguishedName -match 'OU=Resource'){
        $OfficeOU    = ($UserObject.distinguishedname -split 'OU=Resources,')[1]
        }
        If($UserObject.DistinguishedName -match 'OU=Users,'){
        $OfficeOU    = ($UserObject.distinguishedname -split 'OU=Users,')[1]
        }
        }catch{}
        
        }
        If($UserName -ne $null -and $UserObject -eq $null){
        Write-Host "$UserName is not a valid username,Please try again" -ForegroundColor Magenta
        }

        #Find real Computer model if connected
        Write-Host -ForegroundColor Green "If $ComputerName is connected to the network, WMI will pull the Model and MachineType"
        Write-Host -ForegroundColor DarkGreen "-------------------------------------------------------------------------------------"
        If($Pingable){
        
      Try{
        $WMIInfo = Get-WmiObject -ComputerName $ComputerName -Class Win32_computersystem | Select-Object  SystemFamily,PCSystemType,Model
        $ComputerModel = $WMIInfo | Select-Object -ExpandProperty SystemFamily
        $MachineType   = $WMIInfo | Select-Object -ExpandProperty PCSystemType
        If($ComputerModel -match "\w"){
        $ComputerModel = $WMIInfo | Select-Object -ExpandProperty Model
        }
        }catch{}
        if($ComputerModel -eq $null -and $MachineType -eq $null){
        Write-Host -ForegroundColor Magenta "$ComputerName is able to be Pinged but not able to use WinRM, may need to be rejoined to domain" 
        }
        }
        If($MachineType -eq $null){
            Write-Host -ForegroundColor Magenta "Cannnot find the machine type, please enter the machine type below"
            $EnteredMachineType   = (Read-Host -Prompt "(T)ower or (L)aptop")
            If($EnteredMachineType -eq 'T'){
                    $MachineType = '1'
                }
            If($EnteredMachineType -eq 'L'){
                    $MachineType = '2'
                }
        }
        If($ComputerModel -eq $null){
        Write-Host -ForegroundColor Magenta "Cannnot find machine type, please enter the machine type below"
        $ComputerModel = (Read-Host -Prompt "Enter-Computer Model")
        }
        If($MachineType -eq '2'){
        $Type = 'Laptop'
        $ComputerOU = 'OU=Laptops,'
        }
        If($MachineType -eq '1'){
        $Type = 'Tower'
        $ComputerOU = 'OU=Computers,'
        }
        $TargetOU = $ComputerOU + $OfficeOU
        #Displayname
        if($Displayname -ne $null) { 
            $ComputerObject = Get-ADComputer -Identity $ComputerName
            Write-Host "Workstation number : $ComputerName`nDecription         : $Displayname - $ComputerModel`nModel              : $ComputerModel`nMachineType        : $Type`nOU                 : $TargetOU" -ForegroundColor Green
            Set-ADComputer -Identity $ComputerName -Description "$Displayname - $ComputerModel" 
            $ComputerDN = $ComputerObject.distinguishedname
            Move-ADObject -Identity $ComputerDN -TargetPath "$TargetOU"
            
    }else{
        If($username -eq $null
        ){
            # and moving the object to $Type/$Office OU
            $ComputerObject = Get-ADComputer -Identity $ComputerName
            $TargetOU       = $ComputerObject.distinguishedname
            Write-Host "Workstation number : $ComputerName`nDecription         : Available - $ComputerModel`nModel              : $ComputerModel`nMachineType        : $Type`nOU                 : $TargetOU" -ForegroundColor Green
            Set-ADComputer -Identity $ComputerName -Description "Available - $ComputerModel"
            
        }
    }
}