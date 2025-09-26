﻿function ApacheLogs1() {
$logsNotformatted = Get-Content c:\xampp\apache\logs\access.log
$tableRecords = @()

for($i=0; $i -lt $logsNotformatted.Count; $i++){

# split a string into words
$words = $logsNotformatted[$i].split(" ");

$tableRecords += [pscustomobject]@{ "IP" = $words[0];
                                   "Time" = $words[3].Trim('[');
                                   "Method" = $words[5].Trim('"');
                                   "Page" = $words[6];
                                   "Protocol" = $words[7];
                                   "Response" = $words[8];
                                   "Referrer" = $words[10];
                                   "Client" = $words[11..($words.length-1)]; } 

} # end of for loop
return $tableRecords | Where-Object { $_.IP -ilike "10.*" }
}
$tableRecords = ApacheLogs1
$tableRecords | Format-Table -Autosize -Wrap
