Function Get-Model {
    param (
    $ComputerName = (Read-Host -Prompt "Enter Workstation Number")
    )
    If((Test-Connection -ComputerName $ComputerName -Count 1 -BufferSize 16 -Quiet -ErrorAction SilentlyContinue) -eq $true) {
    Invoke-Command -ComputerName $ComputerName -ScriptBlock {(Get-CimInstance -ClassName win32_computersystem).SystemFamily}
    }
    else{
    Write-Host "$ComputerName is not connected to the network right now"
    }
}
