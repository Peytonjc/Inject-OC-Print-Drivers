[bool]$failedMounting = 0
[bool]$tryagain = 0
$ErrorActionPreference = "Stop"

Write-Warning "Welcome to the OC Printer Application! Before continuing, please make sure File Explorer is closed. This program can take up to 10 minutes to run. Multiple windows may open and act unresponsive. A message will be displayed when the program completes."

#Clean up possible remaining files from a failed attempt
if (Test-Path "C:\OCDrivers") { 
Remove-Item 'C:\OCDrivers' -recurse
}

#Close possible remaining PS Drive
if (Test-Path "S:\") {
Remove-PSDrive S
}

Write-Warning "When prompted, type your username in this format: oc\user.name"

#Get Credentials from user
$cred = Get-Credential -Message "Please enter your OC Username and Password"
try {
    New-PSDrive -Name "S" -Root "\\software\dist\Install Printers\drivers" -Persist -PSProvider "FileSystem" -Credential $cred
}
catch {
	$failedMounting = $TRUE
}
if ($failedMounting){
	try{
		New-PSDrive -Name "S" -Root "\\joseph" -PSProvider "FileSystem" -Credential $cred
	}
	catch{
    		throw "There was an error with your Username and Password. The program will end. Please try again."		
	}
    	throw "Make sure to close file explorer and run this program again"
}

$name = $cred.Username
$name = $name.replace('oc\','')
$apiName = 'https://printid.oc.edu/test/api/PrinterAPi/?username=' + $name
$student = curl.exe -X Post --silent $apiName
$studentObject = ConvertFrom-Json -InputObject $student
$studentObject.useridhash
$portname1 = 'http://studentprinters.oc.edu:631/ipp/r/'+ $studentObject.useridhash + '/' + '128EE3ED'
$portname2 = 'http://studentprinters.oc.edu:631/ipp/r/'+ $studentObject.useridhash + '/' + '3410A8EB'



#Install the Canon Printer
New-Item 'C:\OCDrivers\drivers' -ItemType directory
Copy-Item 'S:\Generic_Plus_UFRII_v2.20_Set-up_x64\Driver\*' 'C:\OCDrivers\drivers'
PNPUtil.exe /add-driver 'C:\OCDrivers\drivers\CNLB0MA64.INF' /install
Add-PrinterDriver -Name "Canon Generic Plus UFR II"
Remove-PSDrive -Name S
Remove-Item 'C:\OCDrivers' -recurse
Add-Printer -Name "Canon OC Printer" -DriverName "Canon Generic Plus UFR II" -PortName $portname1 -Verbose


New-PSDrive -Name "S" -Root "\\software\dist\Install Printers" -Persist -PSProvider "FileSystem" -Credential $cred

#Install the HP Printer
New-Item 'C:\OCDrivers' -ItemType directory
Copy-Item 'S:\drivers' 'C:\OCDrivers' -Recurse
PNPUtil.exe /add-driver 'C:\OCDrivers\drivers\hpcu240u.inf' /install -verbose 
Add-PrinterDriver -Name "HP Universal Printing PCL 6"
Remove-PSDrive -Name S
Remove-Item 'C:\OCDrivers\drivers' -recurse -force
Remove-Item 'C:\OCDrivers' -recurse -force
Add-Printer -Name "HP OC Printer" -DriverName "HP Universal Printing PCL 6" -PortName $portname2 -Verbose

Write-Warning "Success! Both Printers Added!"
