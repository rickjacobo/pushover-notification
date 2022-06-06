
# Create a listener on port 80
$Listener = New-Object System.Net.HttpListener
$Listener.Prefixes.Add('http://+:80/') 
$Listener.Start()
'Listening ...'

# Run until you send a GET request to /end
while ($true) {
$Context = $Listener.GetContext() 

# Capture the details about the request
$Request = $Context.Request

# Setup a place to deliver a response
$Response = $Context.Response
  
# Break from loop if GET request sent to /end
if ($Request.Url -match '/end$') { 
    break 
}
else {

# Split request URL to get command and options
$RequestVars = ([String]$Request.Url).split("/");
$ApiRoute = $Env:ENV_ROUTE  
$Route = $RequestVars[3]


if ($Route -eq "$ApiRoute") {
$RouteInput = $RequestVars[4]
$Body = pwsh /powershell/powershell.ps1 -RouteInput $RouteInput
$Message = $Body
$Response.ContentType = 'application/json'
}

else {
# If no matching subdirectory/route is found generate a 404 message
$Message = "Error" #"This is not the page you're looking for.";
$Response.ContentType = 'text/html' ;
}


# Convert the data to UTF8 bytes
[byte[]]$Buffer = [System.Text.Encoding]::UTF8.GetBytes($Message)
# Set length of response
$Response.ContentLength64 = $Buffer.length

# Write response out and close
$Output = $Response.OutputStream
$Output.Write($Buffer, 0, $buffer.length)
$Output.Close()
}

}
 
#Terminate the listener
$Listener.Stop()
