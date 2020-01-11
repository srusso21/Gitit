<#
.SYNOPSIS
    Powershell Function for sending a notification to a Microsoft Teams channel.
.DESCRIPTION
    This Powershell function can be used for sending a notification to a Microsoft Teams channel. The function takes the input from the $text variable and converts it to a compatible JSON payload to be delivered to the specified Microsoft Teams webhook.
.EXAMPLE
    PS C:\> Send-toTeams -webhook $channel -text "Hello World!"
    Sends the text "Hello World!" to the channel associated with the webhook stored in the $channel variable.
.PARAMETER webhook
    Specifies the URL of the Webhook provided by the Microsoft Teams Webhook Connector.
.PARAMETER text
    Specifies the text which you wish to be send to the Microsoft Teams channel.
#>

function Send-toTeams {

    param (
    [Parameter(Mandatory=$true)]
    $Webhook,
    [Parameter(Mandatory=$true)]
    $Text
    )

    
    $payload = @{
        "text" = $text
    }
    $json = ConvertTo-Json $payload
    Invoke-RestMethod -Method post -ContentType 'Application/Json' -Body $json -Uri $webhook
   
}
$Webhook = "https://outlook.office.com/webhook/c4fd0bf4-cc9c-4202-8621-087c33e3b8cf@4031e32a-aee0-4169-83bf-0f50c7e52cec/IncomingWebhook/f6e82c296f0a4fac8db8d7bd60843a7c/725c2bd8-7f3c-42ba-8e06-6f2aaaaefa23"
$Text = Read-Host -Prompt "Enter Text"
Send-toTeams -Webhook $Webhook -Text $Text