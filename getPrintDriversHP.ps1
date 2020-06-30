pause
$cred = Get-Credential
New-PSDrive -Name "S" -Root "\\software\dist\Install Printers\drivers" -Persist -PSProvider "FileSystem" -Credential $cred
pause
New-Item 'C:\OCDrivers\drivers' -ItemType directory
pause
Copy-Item 'S:\HP Universal Driver_Windows_x64\*' 'C:\OCDrivers\drivers'
pause
PNPUtil.exe /add-driver 'C:\OCDrivers\drivers\hpbuio200l.inf' /install
pause
Add-PrinterDriver -Name "Nope"
pause
Remove-PSDrive -Name S
pause
Remove-Item 'C:\OCDrivers\drivers' -recurse
pause