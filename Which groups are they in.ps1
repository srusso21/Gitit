$identity = Read-Host -Prompt 'Show me some computer groups for:'
(Get-ADComputer -Identity $identity -Properties memberof).memberof