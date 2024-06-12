# https://api.github.com/repos/rustdesk/rustdesk/releases - repo list
# Get the package information for RustDesk
$rustDeskPackage = Get-Package -Name "RustDesk" -ErrorAction SilentlyContinue

if ( -not $rustDeskPackage) {
    Write-Output "RustDesk is not installed on this system."
}
else {
    $rustDeskPackageVersion = ($rustDeskPackage | Select-Object -ExpandProperty Version).ToString()
    $url = "https://api.github.com/repos/rustdesk/rustdesk/releases"
    $response = Invoke-RestMethod -Uri $url -Method Get 
    $assets = $response[0].assets
    $version = $response[0].name

    # If its different it means it's not updated
    if ($version -eq $rustDeskPackageVersion) {
        foreach($asset in $assets){
            if ($asset.browser_download_url -like "*x86_64.exe") {
                $url = $($asset.browser_download_url)
                if (-Not (Test-Path -Path "C:\Temp")) {
                    New-Item -Path "C:\Temp" -ItemType Directory
                }
                $path = Join-Path -Path "C:/Temp" -ChildPath $($asset.name)
                Invoke-WebRequest -Uri $url -OutFile $path
                Start-Process -FilePath $path -ArgumentList "--silent-install" -Wait
                Remove-Item -Path $path -Force
            }
        }
    }
}   