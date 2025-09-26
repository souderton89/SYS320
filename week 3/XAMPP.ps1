<#cd cd C:\xampp\apache\logs
Get-Content C:\xampp\apache\logs\access.log
Get-Content C:\xampp\apache\logs\access.log -tail 5
Get-Content C:\xampp\apache\logs\access.log | Select-String ' 404 ',' 400 '
Get-Content C:\xampp\apache\logs\access.log | Select-String ' 200 ' -NotMatch
#>


#$A = Get-ChildItem C:\xampp\apache\logs\*.log | Select-String -AllMatches 'error' 
#$A[-5..-1]




function GeterrorIPs{
  param([string]$error)
    $notfounds = Get-Content c:\xampp\apache\logs\access.log | Select-String ' 404 '

    $regex = [regex] "[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}"

    $ipsunorganized = $regex.Matches($notfounds)

    $ips = @()
    for($i=0; $i -lt $ipsunorganized.Count; $i++){
    $ips +=  [pscustomobject]@{ "IP" = $ipsunorganized[$i].Value; }
    }
    $ips | Where-Object { $_.IP -ilike "10.*" }

Return $ips
}



function GetcountIPs{
  param([string]$counts)
    $ipsoftens = $ips | Where-Object { $_.IP -ilike "10.*" }
    $counts = $ipsoftens | group IP
    $counts | Select-Object Count, Name
    }
Return $ips





