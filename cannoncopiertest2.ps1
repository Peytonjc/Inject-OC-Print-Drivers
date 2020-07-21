$cred = Get-Credential -Message "Please enter your OC Username and Password"
$name = $cred.UserName
$printername = "cannon coppier9" 
$drivername = "Canon Generic Plus UFR II" 
$student = curl.exe -X GET  -H "X-EOP-AuthToken:D23030AD-5138-4F82-A91F64FFDD94F364" -H "Accept: aplication/json" https://studentprinters.oc.edu/api/rest.cfm/useridhash/?username=$name
$studentObject = ConvertFrom-Json -InputObject $student
$studentObject.useridhash
$portname = 'http://studentprinters.oc.edu:631/ipp/r/'+ $studentObject.useridhash + '/' + '128EE3ED'


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
Copy-Item 'S:\Generic_Plus_UFRII_v2.20_Set-up_x64\Driver\*' 'C:\OCDrivers\drivers'-Verbose
PNPUtil.exe /add-driver 'C:\OCDrivers\drivers\CNLB0MA64.INF' /install -verbose 
Add-PrinterDriver -Name "Canon Generic Plus UFR II" -Verbose
Remove-PSDrive -Name S
Remove-Item 'C:\OCDrivers' -recurse
Write-host "Success! The Print Drivers have been added!"

Add-Printer -Name $printername -DriverName $drivername -PortName $portname -Verbose

write-host "it's don
