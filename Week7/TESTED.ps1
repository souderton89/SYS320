. (Join-Path $PSScriptRoot Users.ps1)
. (Join-Path $PSScriptRoot Event-Logs.ps1)

clear

$Prompt = "`n"
$Prompt += "Please choose your operation:`n"
$Prompt += "1 - List Enabled Users`n"
$Prompt += "2 - List Disabled Users`n"
$Prompt += "3 - Create a User`n"
$Prompt += "4 - Remove a User`n"
$Prompt += "5 - Enable a User`n"
$Prompt += "6 - Disable a User`n"
$Prompt += "7 - Get Log-In Logs`n"
$Prompt += "8 - Get Failed Log-In Logs`n"
$Prompt += "9 - List at Risk Users `n"
$Prompt += "10 - Exit`n"

$operation = $true

while ($operation) {

    Write-Host $Prompt | Out-String
    $choice = Read-Host

    if ($choice -eq 10) {
        Write-Host "Goodbye" | Out-String
        exit
        $operation = $false
    }

    elseif ($choice -eq 1) {
        $enabledUsers = getEnabledUsers
        Write-Host ($enabledUsers | Format-Table | Out-String)
    }

    elseif ($choice -eq 2) {
        $notEnabledUsers = getNotEnabledUsers
        Write-Host ($notEnabledUsers | Format-Table | Out-String)
    }

    # Create a user 
    elseif ($choice -eq 3) {

        $name = Read-Host -Prompt "Please enter the username for the new user"
        $chkUser = checkuser $name

        if ($chkUser -ne $true) {
            $password  = Read-Host -AsSecureString -Prompt "Please enter the password for the new user"
            $chkpasswd = checkPassword $password

            if ($chkpasswd -ne $true) {
                createAUser $name $password
                write-Host "User: $name is created." | Out-String
            }
            else {
                Write-Host "Please create a stronger password"
            }

        }
        else {
            Write-Host "User [$name already exists."
        }

        
    }

    # Remove a user  (TODO applied: check username first)
    elseif ($choice -eq 4) {

        $name = Read-Host -Prompt "Please enter the username for the user to be removed"
        $chkUser = checkuser $name  # check with existing function

        if (-not $chkUser) {
            Write-Host "User '$name' was not found." | Out-String
        }
        else {
            removeAUser $name
            Write-Host "User: $name Removed." | Out-String
        }
    }

    # Enable a user  (TODO applied: check username first)
    elseif ($choice -eq 5) {

        $name = Read-Host -Prompt "Please enter the username for the user to be enabled"
        $chkUser = checkuser $name

        if (-not $chkUser) {
            Write-Host "User '$name' was not found." | Out-String
        }
        else {
            enableAUser $name
            Write-Host "User: $name Enabled." | Out-String
        }
    }

    # Disable a user  (TODO applied: check username first)
    elseif ($choice -eq 6) {

        $name = Read-Host -Prompt "Please enter the username for the user to be disabled"
        $chkUser = checkuser $name

        if (-not $chkUser) {
            Write-Host "User '$name' was not found." | Out-String
        }
        else {
            disableAUser $name
            Write-Host "User: $name Disabled." | Out-String
        }
    }

    # Get Log-In Logs  (TODO applied: ask for days)
    elseif ($choice -eq 7) {

        $name = Read-Host -Prompt "Please enter the username for the user logs"
        $daysStr = Read-Host -Prompt "Enter number of days"
        [int]$days = ($daysStr -as [int]); if (-not $days) { $days = 90 }

        $userLogins = getLogInAndOffs $days
        Write-Host ($userLogins | Where-Object { $_.User -ilike "*$name*" } | Format-Table | Out-String)
    }

    # Get Failed Log-In Logs  (TODO applied: ask for days)
    elseif ($choice -eq 8) {

        $name = Read-Host -Prompt "Please enter the username for the user's failed login logs"
        $daysStr = Read-Host -Prompt "Enter number of days"
        [int]$days = ($daysStr -as [int]); if (-not $days) { $days = 90 }

        $userLogins = getFailedLogins $days
        Write-Host ($userLogins | Where-Object { $_.User -ilike "*$name*" } | Format-Table | Out-String)
    }

    # List at Risk Users  (TODO applied: new option)
    elseif ($choice -eq 9) {

        $daysStr = Read-Host -Prompt "Enter number of days for the risk window"
        [int]$days = ($daysStr -as [int]); if (-not $days) { $days = 90 }

        $failed = getFailedLogins $days
        $atRisk = $failed |
            Group-Object User |
            Where-Object { $_.Count -gt 10 } |
            Select-Object @{n='User';e={$_.Name}}, @{n='FailedLogins';e={$_.Count}}

        if ($atRisk) {
            Write-Host ($atRisk | Format-Table | Out-String)
        }
        else {
            Write-Host "No users exceeded 10 failed logins in the last $days day(s)." | Out-String
        }
    }

    else {
        Write-Host "Invalid choice. Please select a number from the menu." | Out-String
    }
}


