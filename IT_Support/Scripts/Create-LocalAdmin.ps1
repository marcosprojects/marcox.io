# Auto-elevate if not running as admin
If (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
    [Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "Restarting script as Administrator..." -ForegroundColor Cyan
    Start-Process powershell "-ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit
}

# Account details
$username = "local_admin"
$passwordPlain = '$Admin123' # Change to your password
$password = ConvertTo-SecureString $passwordPlain -AsPlainText -Force

# Create user if not exists
if (Get-LocalUser -Name $username -ErrorAction SilentlyContinue) {
    Write-Host "User '$username' already exists." -ForegroundColor Yellow
} else {
    New-LocalUser -Name $username -Password $password -FullName "Local Administrator" -Description "Local admin account" -PasswordNeverExpires -AccountNeverExpires
    Write-Host "User '$username' created." -ForegroundColor Green
    Add-LocalGroupMember -Group "Administrators" -Member $username
    Write-Host "User '$username' added to Administrators group." -ForegroundColor Green
}


pause
