<#---------------------------------Question 1,2------------------------------------------               
  
et-Eventlog system -source microsoft-windows-winlogon

$loginouts = Get-EventLog system -source Microsoft-Windows-Winlogon -After (Get-Date).AddDays(-14)
$loginouTstable = @()

 for($i=0; $i -lt $loginouts.count; $i++){
 $event = ""
 if ($loginouts[$i].InstanceId -eq 7001){$event="logon"}
 if ($loginouts[$i].InstanceId -eq 7002){$event="logoff"}

 $user = $loginouts[$i].ReplacementStrings[1]

 $loginoutsTable += [pscustomobject]@{"Time" = $loginouts[$i].TimeGenerated;
                                        "Id" = $loginouts[$i].InstanceId;
                                        "Event" = $event;
                                        "User" = $user;
                                         }
}
$loginoutsTable
---------------------------------Question 1,2------------------------------------------#>



<#---------------------------------Question 3,4------------------------------------------#>         

function GetLoginAndLogoffs($timeback){

    $loginouts = Get-EventLog system -source Microsoft-Windows-Winlogon -After (Get-Date).AddDays("-" + $timeback)
    $loginouTstable = @()

    for ($i = 0; $i -lt $loginouts.Count; $i++) {
        $event = ""
        if ($loginouts[$i].InstanceId -eq 7001) { $event = "Logon" }
        if ($loginouts[$i].InstanceId -eq 7002) { $event = "Logoff" }

        $sidString = $loginouts[$i].ReplacementStrings[1]

        try {
            $sid    = New-Object System.Security.Principal.SecurityIdentifier($sidString)
            $user   = $sid.Translate([System.Security.Principal.NTAccount]).Value
        } catch {
            $user = $sidString[-1]
        }

        #  Only add if it's not a raw SID
        if ($user -notlike "S-1-*") {
            $loginoutsTable += [pscustomobject]@{
                "Time"  = $loginouts[$i].TimeGenerated
                "Id"    = $loginouts[$i].InstanceId
                "Event" = $event
                "User"  = $user
            }
        }
    }
    return $loginouTstable
}

#GetLoginAndLogoffs($user_input)

<#---------------------------------Question 3,4------------------------------------------#>

<#---------------------------------Question 5  ------------------------------------------#>


function Get-Shutdowns($daysback){

    $shutdowns = Get-EventLog system -After (Get-Date).AddDays("-" + $daysback) | Where{ $_.EventID -eq "6006"}
    $shutdowntable = @()

    for ($i = 0; $i -lt $shutdowns.Count; $i++) {
        
        $shutdowntable += [pscustomobject]@{
                "Time"  = $shutdowns[$i].TimeGenerated
                "Id"    = $shutdowns[$i].EventID
                "Event" = "Shutdown"
                "User"  = "System"                
    
    }
    return $shutdowntable
}
}

<#---------------------------------Question 5  ------------------------------------------#>

<#---------------------------------Question 5  ------------------------------------------#>


function Get-startups($Start){

    $startup = Get-EventLog system -After (Get-Date).AddDays("-" + $Start) | Where{ $_.EventID -eq "6005"}
    $startuptable = @()

    for ($i = 0; $i -lt $startup.Count; $i++) {
        
        $startuptable += [pscustomobject]@{
                "Time"  = $startup[$i].TimeGenerated
                "Id"    = $startup[$i].EventID
                "Event" = "startup"
                "User"  = "System"                
    
    }
    return $startuptable

    }
    }