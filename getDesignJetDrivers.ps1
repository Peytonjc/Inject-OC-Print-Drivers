$ErrorActionPreference = "Stop"
$failedMounting = $FALSE
$cred = Get-Credential -Message "Please enter your OC Username and Password"
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
    		throw "There was an error with your Username and Password. The program will end. Please try again."		
	}
    	throw "Make sure to close file explorer and run this program again"
}
New-Item 'C:\OCDrivers\drivers' -ItemType directory
Copy-Item 'S:\hpi94dev.inf' 'C:\OCDrivers\drivers'
PNPUtil.exe /add-driver 'C:\OCDrivers\drivers\hpi94dev.inf' /install
Add-PrinterDriver -Name "HP DesignJet T1600dr PS3"
Remove-PSDrive -Name S
Remove-Item 'C:\OCDrivers\drivers' -recurse
Write-Warning "Success! The Print Drivers have been added!"