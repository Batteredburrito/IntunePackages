#App Name
$directoryApp = "C:\Windows\System32\IMController.InfInstaller.exe"
#Dependency Name
$depName = "C:\Windows\System32\IMController.CoInstaller.dll"
#Directory Path
$directory = "C:\Windows\System32"

#Variable for IMController Existin
$existApp = Test-Path $directoryApp -ErrorAction SilentlyContinue
#Variable for Confirming Uninstall based on dependency not existing
$unSuccess = Test-Path $depName -ErrorAction SilentlyContinue
$cleanSuccess = Test-Path $directoryApp -ErrorAction SilentlyContinue


#If Process is running, stop process, else, state its not running
if($existApp){
    #Call IMController Uninstall and wait
    Start-Process -NoNewWindow -FilePath $directoryApp -ArgumentList "-uninstall" -Wait
}
else {
    Write-Output "IMController doesnt exist"
}

#Test if DLL Still exists, if so, delete it and IM Controller. If not, skip
if ($unSuccess){
    Write-Output "IM DLL exists"
    Remove-Item -Path "C:\Windows\System32\IMController.InfInstaller.exe" -Force
}
else {
    Write-Host "IM DLL doesnt exist"
    #Remove IMController if it exists
    if($existApp){
    Remove-Item -Path "C:\Windows\System32\IMController.InfInstaller.exe" -Force
    }
    else {
    Write-Output "All Clean"
    }
}

#Test Uninstall Success
if($cleanSuccess){
    Write-Output "Cleanup Failed"
    }
    else{
    Write-Output "Cleanup Succeeded"
    }