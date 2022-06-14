# pushover-notification
pushover-notification is an api endpoint to facilitate sending pushover notifications to a pushover client

## Requirements
- Container Platform
- [Pushover Client](https://pushover.net/)

## Setup
### Docker Example
````
docker run -d --name pushover -e ENV_PUSHOVER_USER=<pushover_user_key> -e ENV_PUSHOVER_TOKEN=<pushover_application_token> -e ENV_ROUTE=pushover -p 80:80 rickjacobo/pushover-notification
````

## Sending Messages
### Via Web Browser
````
http://127.0.0.1/pushover/<add message here>
````

### Via PowerShell
````
$Message = "add message here"; Invoke-RestMethod -Uri 127.0.0.1/pushover/$Message
````
