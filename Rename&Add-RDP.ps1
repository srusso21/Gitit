$comps = Get-ADComputer -Filter "name -like 'ad*'" -Properties whencreated |Sort-Object -Property whencreated | Select-Object -Last 5 

Test-Connection $C.NAME 





} 
    ForEach-Object {
        If(Test-Connection $_.name -Count 1 -BufferSize 8 -Quiet -ErrorAction SilentlyContinue){
        Invoke-Command -ComputerName $_.name -ScriptBlock {
            $passwordfile = "C:\Temp\Passwordfile.txt"
            $user = Get-LoggedOnUser | Select-Object -ExpandProperty UserName
            Read-Host "Enter Password" -AsSecureString |  ConvertFrom-SecureString | Out-File $passwordfile
            $secpasswd = (Get-Content $passwordfile | ConvertTo-SecureString)
            $credential = New-Object System.Management.Automation.PSCredential($user, $secpasswd)
            $computername = Read-Host -Prompt "For $_ What is the computer name?"
            Rename-Computer -ComputerName -Force        
        
        
        }  
    }
}
#Add-ADGroupMember -Identity "$ADGroup" -Members "$samaccountname"