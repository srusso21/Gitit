
Invoke-Command IRVAZADCon01 -ScriptBlock {Import-Module ADSync; Start-ADSyncSyncCycle -PolicyType Delta}


