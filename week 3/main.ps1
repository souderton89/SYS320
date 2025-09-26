
.(Join-Path $PSScriptRoot 'functions-and eventlogs.ps1')

$user_input = Read-Host "How far (in days) would you like to go back in the login and logoff events?"
$shutdowndaysback = Read-Host "How far (in days) would you like to go back in the shutdown events?"
$startupdaysback = Read-Host "How far (in days) would you like to go back in the startup events?"

# Get Login and Logoffs from the last 15 days
$loginoutsTable = GetLoginAndLogoffs($user_input)
$loginoutsTable

# Get Shut Downs from the last 25 days
$shutdownsTable = Get-Shutdowns($shutdowndaysback)
$shutdownsTable

# Get Start Ups from the last 25 days
$startupsTable = Get-Startups($startupdaysback)
$startupsTable


