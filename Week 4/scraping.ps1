<#function gatherClasses() {
    $page = Invoke-WebRequest -TimeoutSec 2 http://10.0.17.8/courses.html
    
    # Get all the tr elements of HTML document
    $trs = $page.ParsedHtml.body.getElementsByTagName('tr')
    
    # Empty array to hold results
    $FullTable = @()
    
    for($i=1; $i -lt $trs.length; $i++) { # Going over every tr element
        # Get every td element of current tr element
        $tds = $trs.item($i).getElementsByTagName("td")
        
        # Want to separate start time and end time from one time field
        $Times = $tds.item(5).innerText.split('-')
        
        $FullTable += [PSCustomObject]@{
            "Class Code" = $tds.item(0).innerText
            "Title" = $tds.item(1).innerText
            "Days" = $tds.item(4).innerText
            "Time Start" = $Times[0]
            "Time End" = $Times[1]
            "Instructor" = $tds.item(6).innerText
            "Location" = $tds.item(9).innerText
        }
    } # end of for loop

    
    return $FullTable
}
                         
gatherClasses #| Where-Object{$_.Instructor -ilike "LaKysha Patnode"}


function daysTranslator($FullTable){

    # Go over every record in the table
    for($i=0; $i -lt  $FullTable.length; $i++){

        # Empty array to hold days for every record
        $Days = @()

        # If you see "M"  -> Monday
        if($FullTable[$i].Days -ilike "*M*"){ $Days += "Monday" }

        # If you see "T" followed by T, W, or F -> Tuesday
        if($FullTable[$i].Days -ilike "*T[!H]*"){ $Days += "Tuesday" }
        # If you only see "T" -> Tuesday
        ElseIf($FullTable[$i].Days -ilike "*T"){ $Days += "Tuesday" }

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
daysTranslator (gatherClasses) 





# i) List all the classes of the instructor Furkan Paligu
$FullTable | Select-Object "Class Code", Instructor, Location, Days, "Time Start", "Time End" | `
#             Where-Object { $_.Instructor -ilike "Furkan Paligu" } 
 gatherClasses | Where-Object{$_.Instructor -ilike "Furkan Paligu"}
#Format-Table -AutoSize -Wrap


# ii) List all the classes of JOYC 310 on Mondays, only display Class Code and Times. Sort by Start Time
$FullTable = daysTranslator (gatherClasses)
$FullTable |
  Where-Object { $_.Location -ilike "JOYC 310" -and ($_.Days -contains "Monday") } | `
  Sort-Object "Time Start" | `
  Select-Object "Time Start", "Time End", "Class Code"
# gatherClasses ($FullTable)


# iii) Instructors that teach at least 1 course in SYS, NET, SEC, FOR, CSI, DAT
$ITSInstructors = $FullTable |
  Where-Object {
    $_."Class Code" -like "SYS*" -or
    $_."Class Code" -like "NET*" -or
    $_."Class Code" -like "SEC*" -or
    $_."Class Code" -like "FOR*" -or
    $_."Class Code" -like "CSI*" -or
    $_."Class Code" -like "DAT*"
  } |
  Select-Object "Instructor" |
  Sort-Object "Instructor" -Unique

$ITSInstructors

#>

# iv) Group instructors by the number of classes they are teaching, sorted by count
$FullTable |
  Where-Object { $_.Instructor -in $ITSInstructors.Instructor } |
  Group-Object "Instructor" |
  Select-Object Count, Name |
  Sort-Object Count -Descending





