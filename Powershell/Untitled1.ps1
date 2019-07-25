# Install Azure Module
Install-Package -Name AzureRM

# Set the network connection profile to Private
Set-NetConnectionProfile -NetworkCategory Private

# Enable Powershell Remoting
Enable-PSRemoting -Force

# Connect to Azure
Connect-AzureRmAccount

# Variables for common values
$ResourceGroup = "ClassResourceGroup"
$Location = "westus2"
$VMDCName = "DC01"
$VMMSName = "MS01"
$Word = (Read-Host -Prompt 'Enter any word that you will remember. This is for the DNS to your new VMS. It cannot be the same as someone elses word.').ToLower()

$DCComputerName = "PowershellClassDC$Word.$Location.cloudapp.azure.com"
$MSComputerName = "PowershellClassMS$Word.$Location.cloudapp.azure.com"

foreach ($DNSName in $DCComputerName,$MSComputerName) {
    if ((Resolve-DnsName -Name $DNSName -ErrorAction 'SilentlyContinue') -eq $true) {
        Write-Error -Message "Please choose a different word and run this script again."
    }
}


# Adding computer to Trusted Hosts
winrm set winrm/config/client "@{TrustedHosts=`"$DCComputerName,$MSComputerName`"}"

# Creae User Object
$Credential = Get-Credential -UserName 'ClassAdmin' -Message 'Please enter a password for setting up a local user on your VMs'

# Create a resource group
New-AzureRmResourceGroup -Name $ResourceGroup -Location $Location -Force

# Create a subnet configuration
$SubnetConfig = New-AzureRmVirtualNetworkSubnetConfig -Name 'ClassSubnet' -AddressPrefix 192.168.1.0/24

# Create a virtual network
$VirtualNetWork = New-AzureRmVirtualNetwork -ResourceGroupName $ResourceGroup -Location $Location -Name 'ClassNetwork' -AddressPrefix '192.168.0.0/16' -Subnet $SubnetConfig -Force

# Create a public IP address and specify a DNS name
$VMDCPublicIPAddress = New-AzureRmPublicIpAddress -ResourceGroupName $ResourceGroup -Location $Location -Name "PowershellClassDC" -AllocationMethod 'Static' -IdleTimeoutInMinutes 4 -DomainNameLabel "powershellclassdc$Word" -Force -ErrorAction 'Stop'
$VMMSPublicIPAddress = New-AzureRmPublicIpAddress -ResourceGroupName $ResourceGroup -Location $Location -Name "PowershellClassMS" -AllocationMethod 'Static' -IdleTimeoutInMinutes 4 -DomainNameLabel "powershellclassms$Word" -Force -ErrorAction 'Stop'

# Create an inbound network security group rule for port 3389
$RDPRule = New-AzureRmNetworkSecurityRuleConfig -Name ClassRDPRule -Protocol Tcp -Direction Inbound -Priority 1000 -SourceAddressPrefix * -SourcePortRange * -DestinationAddressPrefix * -DestinationPortRange 3389,5985 -Access Allow

# Create a network security group
$NetSecurityGroup = New-AzureRmNetworkSecurityGroup -ResourceGroupName $ResourceGroup -Location $Location -Name ClassNetworkSecurityGroup -SecurityRules $RDPRule -Force

# Create a virtual network card and associate with public IP address and NSG
#$VMDCIPConfig = New-AzureRmNetworkInterfaceIpConfig -Name 'DCIPConfig' -SubnetId $VirtualNetWork.Subnets[0].Id -PublicIpAddressId $VMDCPublicIPAddress.Id #-PrivateIpAddressVersion IPv4 -PrivateIpAddress 192.168.1.2
$VMDCNIC = New-AzureRmNetworkInterface -Name ClassDCNic -ResourceGroupName $ResourceGroup -Location $Location -NetworkSecurityGroupId $NetSecurityGroup.Id -Force -SubnetId $VirtualNetWork.Subnets[0].Id -PublicIpAddressId $VMDCPublicIPAddress.Id

#$VMMSIPConfig = New-AzureRmNetworkInterfaceIpConfig -Name 'MSIPConfig' -SubnetId $VirtualNetWork.Subnets[0].Id -PublicIpAddressId $VMDCPublicIPAddress.Id #-PrivateIpAddressVersion IPv4 -PrivateIpAddress 192.168.1.3
$VMMSNIC = New-AzureRmNetworkInterface -Name ClassMSNic -ResourceGroupName $ResourceGroup -Location $Location -NetworkSecurityGroupId $NetSecurityGroup.Id -Force -SubnetId $VirtualNetWork.Subnets[0].Id -PublicIpAddressId $VMMSPublicIPAddress.Id#-DnsServer 192.168.1.2

# Create a virtual machine configuration
$VMDCConfig = New-AzureRmVMConfig -VMName "Class$VMDCName" -VMSize Standard_B2s | `
Set-AzureRmVMOperatingSystem -Windows -ComputerName $VMDCName -Credential $Credential -WinRMHttp | `
Set-AzureRmVMSourceImage -PublisherName MicrosoftWindowsServer -Offer WindowsServer -Skus 2016-Datacenter-smalldisk -Version latest | `
Add-AzureRmVMNetworkInterface -Id $VMDCNIC.ID

$VMMSConfig = New-AzureRmVMConfig -VMName "Class$VMMSName" -VMSize Standard_B2s | `
Set-AzureRmVMOperatingSystem -Windows -ComputerName $VMMSName -Credential $Credential -WinRMHttp | `
Set-AzureRmVMSourceImage -PublisherName MicrosoftWindowsServer -Offer WindowsServer -Skus 2016-Datacenter-smalldisk -Version latest | `
Add-AzureRmVMNetworkInterface -Id $VMMSNIC.ID

# Create a virtual machine
New-AzureRmVM -ResourceGroupName $ResourceGroup -Location $Location -VM $VMDCConfig -AsJob

New-AzureRmVM -ResourceGroupName $ResourceGroup -Location $Location -VM $VMMSConfig -AsJob

While ((get-job -Name "Long Running Operation for 'New-AzureRmVM'").State -notcontains 'Completed') {
    Start-Sleep -Seconds 5
}


$Nic = Get-AzureRmNetworkInterface -Name 'ClassDCNic' -ResourceGroupName $ResourceGroup
$Nic.DnsSettings.DnsServers.Add('8.8.8.8')
$VMDCIPConfig = New-AzureRmNetworkInterfaceIpConfig -Name ipconfig1 -PrivateIpAddressVersion IPv4 -PrivateIpAddress 192.168.1.10 -Subnet $VirtualNetWork.Subnets[0] -PublicIpAddress $VMDCPublicIPAddress
$Nic.IpConfigurations = $VMDCIPConfig
Set-AzureRmNetworkInterface -NetworkInterface $Nic


$Nic = Get-AzureRmNetworkInterface -Name 'ClassMSNic' -ResourceGroupName $ResourceGroup
$Nic.DnsSettings.DnsServers.Add('192.168.1.10')
$VMDCIPConfig = New-AzureRmNetworkInterfaceIpConfig -Name ipconfig1 -PrivateIpAddressVersion IPv4 -PrivateIpAddress 192.168.1.11 -Subnet $VirtualNetWork.Subnets[0] -PublicIpAddress $VMMSPublicIPAddress
$Nic.IpConfigurations = $VMDCIPConfig
Set-AzureRmNetworkInterface -NetworkInterface $Nic

Start-Sleep -Seconds 200

Invoke-Command -ComputerName $DCComputerName -Credential $Credential -ScriptBlock {

    Install-WindowsFeature -Name AD-Domain-Services -IncludeAllSubFeature -IncludeManagementTools
    Install-ADDSForest -DomainName 'class.contoso.com' -DomainNetbiosName 'class' -DomainMode Win2012R2 -ForestMode Win2012R2 -InstallDns -Force -SafeModeAdministratorPassword $using:Credential.Password
}

$DomainCredential = New-Object PSCredential -ArgumentList "class.contoso.com\$($credential.UserName)",$Credential.Password

Invoke-Command -ComputerName $MSComputerName -Credential $Credential -ScriptBlock {

    Add-Computer -DomainName class.contoso.com -LocalCredential $using:Credential -Credential $using:Credential -Restart -Force
}