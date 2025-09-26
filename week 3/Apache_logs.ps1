.(Join-Path $PSScriptRoot 'XAMPP.ps1')
$IPerror = Read-Host "What Error do you want?"
$counts = Read-Host "Would you like to see the number of IPs Yes/no?"

#function GeterrorIPs($IPerror)
$IPerrorTable = GeterrorIPs -$error ($IPerror)
$IPerrorTable

$countTable = GetcountIPs -$count ($counts)
$countTable