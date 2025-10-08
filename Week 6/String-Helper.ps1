<# String-Helper
*************************************************************
   This script contains functions that help with String/Match/Search
   operations. 
************************************************************* 
#>
function checkPassword($password){
#$passwd = 
    if($password.length -lt 6){
    Write-Host "Fail length test" | Out-String
    return $false

}

    elseif($password -notmatch "[0-9]"){
    Write-Host "Numbers" | Out-String
    return $false
}
    elseif ($password -notmatch "[`!`@`#`$`%`^`&`*`]"){
    Write-Host "Fail special character"
    return $false
    }
else{
    Write-Host "Complete"
    return $true
}
}
<# ******************************************************
   Functions: Get Matching Lines
   Input:   1) Text with multiple lines  
            2) Keyword
   Output:  1) Array of lines that contain the keyword
********************************************************* #>
function getMatchingLines($contents, $lookline){

$allines = @()
$splitted =  $contents.split([Environment]::NewLine)

for($j=0; $j -lt $splitted.Count; $j++){  
 
   if($splitted[$j].Length -gt 0){  
        if($splitted[$j] -ilike $lookline){ $allines += $splitted[$j] }
   }

}

return $allines
}