Connect-Office365 -Service SecurityAndCompliance -MFA
# Create Compliance Search - Export Email
$user = 
$SearchName = "Export - " + "JSherwood"
$upn = "JSherwood@waremalcomb.com"
New-ComplianceSearch -ExchangeLocation $upn -Name $SearchName -Description "Termination"

# Start Compliance Search and wait to complete
Start-ComplianceSearch $SearchName