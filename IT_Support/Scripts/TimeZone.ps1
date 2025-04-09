# Auto-elevate if not running as admin
If (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
    [Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "Restarting script as Administrator..." -ForegroundColor Cyan
    Start-Process powershell "-ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit
}


# Set time zone to Eastern Standard Time
try {
    tzutil /s "Eastern Standard Time" # Set your TimeZone.
    Write-Host "`Time zone set to Eastern Standard Time."
} catch {
    Write-Warning "Failed to set time zone: $($_.Exception.Message)"
}

pause
