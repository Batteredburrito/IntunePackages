#Vantage Service Directory
$fullPath = 'C:\Program Files (x86)\Lenovo\VantageService\*\Uninstall.exe'
#Vantage Uninstall exe
$appName = 'uninstall.exe'
#Root Vantage Directory
$rootDir = 'C:\Program Files (x86)\Lenovo\VantageService\'
#Vantage Service 
$serviceName = 'LenovoVantageService'

#Variable Vantage Service Existing
$appExists = Test-Path $fullPath -ErrorAction SilentlyContinue
#Variable for Running Service
$serviceExists = Get-Service -Name $serviceName -ErrorAction SilentlyContinue
#Variable for Root Directory Existing
$rootExists = Test-Path $rootDir -ErrorAction SilentlyContinue

#Test if Vantage App Exists, if so, call the uninstall command
if($appExists){
    Start-Process -NoNewWindow -FilePath $fullPath -ArgumentList "/SILENT" -Wait
}
else {
    Write-Output "Vantage Service doesnt exists"
}

#Test if service no longer exists. If so, system is now clean
if($serviceExists){
    Stop-Service -Name 'LenovoVantageService' -Force -Confirm:$false
    sc.exe delete 'LenovoVantageService'
}
else {
    Write-Output "$serviceName not running"
}

#Confirm app no longer exists, then do some final cleanup to the folder system.
if(Test-Path "C:\Program Files (x86)\Lenovo\VantageService\"){
    Write-Output "Still Exits, uninstall failed"
}
else
{
    Write-Output "Systems is clean"
    Write-Output "Doing Some Final Cleanup"

    #Test Filepath
    if(Test-Path "C:\Program Files\Lenovo" -ErrorAction SilentlyContinue){
    Write-Output "Folder exists, removing"
    Remove-Item "C:\Program Files\Lenovo" -Force -Recurse
    } else {
    Write-Output "Folder Doesnt Exist, Clean"
    }

    #Test Filepath
    if(Test-Path "C:\Program Files (x86)\Lenovo" -ErrorAction SilentlyContinue){
    Write-Output "Folder exists, removing"
    Remove-Item "C:\Program Files (x86)\Lenovo" -Force -Recurse
    } else {
    Write-Output "Folder Doesnt Exist, Clean"
    }
}