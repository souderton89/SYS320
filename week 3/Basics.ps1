#3 & 4
#Get-WmiObject -list | Where-Object {$_.Name -ilike "Win32_Net*"} | Sort

#5 & 6
#Get-Ciminstance Win32_NetworkAdapterConfiguration -Filter "DHCPEnabled=$true" | Select DHCPServer | Format-Table -HideTableHeaders

#7
#(Get-DnsClientServerAddress -AddressFamily IPv4 | Where-Object {$_.InterfaceAlias -ilike "Ethernet"}).ServerAddresses[0]

#8
cd $PSScriptRoot 
$files=(Get-ChildItem) 

for ($j=0; $j -le $files.length; $j++ ){

if ($files[$j].name -ilike "*ps1") {

    write-host $files[$j].names 
}

}
