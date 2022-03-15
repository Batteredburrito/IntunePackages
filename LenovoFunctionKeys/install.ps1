#App Name
$processApp = "FnHotkeyUtility"
#Service Name
$serviceName = "LenovoFnAndFunctionKeys"
#Directory Path
$directory = "C:\ProgramData\Lenovo\FnHotkeyUtility"

#Variable for Running App
$process = Get-Process -Name $processApp -ErrorAction SilentlyContinue
#Variable for Running Service
$service = Get-Service -Name $serviceName -ErrorAction SilentlyContinue
#Variable for Directory Path
$dirPath = Test-Path $directory -ErrorAction SilentlyContinue

#If Process is running, stop process, else, state its not running
if($process){
    Stop-Process $process -Force
    Write-Output "$processApp has been stopped."
}
else {
    Write-Output "$processApp not running"
}

#If Service is Running Kill Service, else, state its not running
if ($service){
    Stop-Service -Name 'LenovoFnAndFunctionKeys' -Force -Confirm:$false
    sc.exe delete 'LenovoFnAndFunctionKeys'
}
else {
    Write-Output "$serviceName not running"
}

#If LenovoFnKeys Directory exists, delete it
if ($dirPath){
    Write-Output "$directory exists, removing"
    Remove-Item -Path $directory -Force -Recurse
}
else {
    Write-Output "$directory doesnt exists"
}

Write-Output "Cleanup Complete, system should now be clean"