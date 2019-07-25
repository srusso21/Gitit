Get-ADComputer -Filter * -Properties Description | where {$_.name -match 'cws-' -and $_.name -ne 'cws-002'} | ForEach-Object {

    If((Test-Connection $_.name -Count 1 -BufferSize 1 -Quiet) -eq $True ){

        Write-Host ""$_.name" is connected and is on"$_.description""

    }

    else{

        Write-Host ""$_.name" is NOT connected and is on"$_.description""

    }
}