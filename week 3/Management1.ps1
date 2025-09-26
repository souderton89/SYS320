# Get-WmiObject Win32_Process | Where-Object { $_.Name -ilike "C*" } | Select-Object Name, ProcessId


 #Get-WmiObject Win32_Process | Where-Object { $_.ExecutablePath -notlike "*system32*" } | Select-Object Name, ExecutablePath


# Get-Service | Where-Object { $_.Status -ilike 'Stopped' } | Sort-Object Name 


if (-not (Get-Process chrome -ErrorAction SilentlyContinue)) { Start-Process "chrome.exe" "https://www.champlain.edu" } else { Stop-Process -Name chrome -Force }

