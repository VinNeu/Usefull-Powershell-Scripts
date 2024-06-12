$userProfile = [System.Environment]::GetFolderPath("UserProfile")
$programRelativePath = "AppData\Local\rustdesk\rustdesk.exe"
$rustdeskServicePath = "C:\Program Files\RustDesk\RustDesk.exe"

$localProgramPath = Join-Path -Path $userProfile -ChildPath $programRelativePath

if (Test-Path -Path $programPath) {
    New-NetFirewallRule -DisplayName "Open Port for RustDesk" -Direction Inbound -Program $localProgramPath -LocalPort $port -Protocol TCP -Action Allow
    New-NetFirewallRule -DisplayName "Open Port for RustDesk" -Direction Inbound -Program $localProgramPath -LocalPort $port -Protocol UDP -Action Allow
    New-NetFirewallRule -DisplayName "Open Port for RustDesk Service" -Direction Inbound -Program $rustdeskServicePath -Action Allow
    New-NetFirewallRule -DisplayName "Open Port for RustDesk Service" -Direction Outbound -Program $rustdeskServicePath -Action Allow
}