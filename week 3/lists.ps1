(Get-NetIPAddress -addressfamily IPv4 | Where-Object {$_.InterfaceAlias -ilike "ethernet" }).IPAddress

(Get-NetIPAddress -AddressFamily IPv4 | Where-Object {$_.InterfaceAlias -ilike "ethernet"}).PrefixLength

Get-WmiObject -list | Where-Object {$_.name -ilike "win_net*"} | Sort-Object

#3 & 4
Get-WmiObject -list | Where-Object {$_.Name -ilike "Win32_Net*"} | Sort

#5 & 6
Get-Ciminstance Win32_NetworkAdapterConfiguration -Filter "DHCPEnabled=$true" | Select DHCPServer | Format-Table -HideTableHeaders

#7
(Get-DnsClientServerAddress -AddressFamily IPv4 | Where-Object {$_.InterfaceAlias -ilike "Ethernet"}).ServerAddresses[0]

#8
cd $PSScriptRoot 
$files=(Get-ChildItem) 

for ($j=0; $j -le $files.length; $j++ ){

if ($files[$j].name -ilike "*ps1") {

    write-host $files[$j].name 

}

}

$folderpath="PSScriptRoot\outfolder"
if (Test-Path $folderpath){
    Write-Host "Folder Already Exists"
    }
    else{
        New-Item -ItemType Directory -Path $folderpath | Out-Null
    }

cd $PSScriptRoot
$files = Get-ChildItem

$folderPath = "PSScriptRoot/outfolder/"
$filePath = $folderPath + "out.csv"


$files | Where-Object { $_.Extension -eq ".ps1" } | `
Export-Csv -Path $filePath


$files = Get-ChildItem -Recurse -File
$files | Rename-Item -NewName { $_.Name.Replace('.csv', '.log') }
Get-ChildItem -Recurse -File

