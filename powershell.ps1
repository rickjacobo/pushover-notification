param (
    [parameter(mandatory=$true,position=1)]
    $RouteInput
)
$CustomCode = {
$Input = $RouteInput
# BEGIN CUSTOM CODE

$PushoverURL="$ENV:ENV_PUSHOVER_URL"
$PushoverUser = "$ENV:ENV_PUSHOVER_USER"
$PushoverToken = "$ENV:ENV_PUSHOVER_TOKEN"
$Title = "Pushover Notification"
$Title = [System.Web.HttpUtility]::UrlEncode($Title)
$Input = [System.Web.HttpUtility]::UrlEncode($Input)
$Message = "?token=" + $PushoverToken  + "&user=" + $PushoverUser  + "&title=" + $Title  + "&message=" + $Input + "&priority=2" + "&retry=60" + "&expire=3600"

Invoke-WebRequest -Uri $PushoverURL/$Message -Method POST

#END CUSTOM CODE
}


# Begin handler response
& $CustomCode | Out-Null
$JSON = @"
{"status": request submitted}
"@
$JSON
# End handler response