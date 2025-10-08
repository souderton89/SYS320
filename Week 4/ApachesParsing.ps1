function ApacheLogs1() {
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


<#
function daysTranslator($FullTable){

    # Go over every record in the table
    for($i=0; $i -lt  $FullTable.length; $i++){

        # Empty array to hold days for every record
        $Days = @()

        # If you see "M"  -> Monday
        if($FullTable[$i].days -ilike "*M *"){ $Days += "Monday" }

        # If you see "T" followed by T, W, or F -> Tuesday
        if($FullTable[$i].Days -ilike "*T[TWF]*"){ $Days += "Tuesday" }
        # If you only see "T" -> Tuesday
        ElseIf($FullTable[$i].Days -ilike "*T*"){ $Days += "Tuesday" }

        # If you see "W"  -> Wednesday
        if($FullTable[$i].Days -ilike "*W*"){ $Days += "Wednesday" }

        # If you see "TH" -> Thursday
        if($FullTable[$i].Days -ilike "*TH*"){ $Days += "Thursday" }

        # F -> Friday
        if($FullTable[$i].Days -ilike "*F*"){ $Days += "Friday" }

        # Make the switch
        $FullTable[$i].Days = $Days 
    }

    return $FullTable
}

#>





