$ErrorActionPreference = "Stop"
$failedMounting = $FALSE
$cred = Get-Credential
try {
    New-PSDrive -Name "S" -Root "\\software\dist\Install Printers\drivers" -Persist -PSProvider "FileSystem" -Credential $cred
}
catch {
	$failedMounting = $TRUE
}
if ($failedMounting){
	try{
		New-PSDrive -Name "S" -Root "\\judah\junk$" -PSProvider "FileSystem" -Credential $cred
	}
	catch{
		Write-Warning "There was an error with your Username and Password. The program will end. Please try again."
    		pause
    		throw "Ending Program"		
	}
	Write-Warning "Make sure to close file explorer and run this program again"
	pause
    	throw "Ending Program"
}
New-Item 'C:\OCDrivers\drivers' -ItemType directory
Copy-Item 'S:\Generic_Plus_UFRII_v2.20_Set-up_x64\Driver\*' 'C:\OCDrivers\drivers'
PNPUtil.exe /add-driver 'C:\OCDrivers\drivers\CNLB0MA64.INF' /install
Add-PrinterDriver -Name "Canon Generic Plus UFR II"
Remove-PSDrive -Name S
Remove-Item 'C:\OCDrivers' -recurse
Write-Warning "Success! The Print Drivers have been added!"