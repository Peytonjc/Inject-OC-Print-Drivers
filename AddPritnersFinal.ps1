#flags for the bad login attempt
[bool]$failedMounting = 0
[bool]$tryagain = 0


#
#
#this function containts the form that lets you select multiple printer options
#
function select-printer {

$student = curl.exe -X Post https://printid.oc.edu/test/api/PrinterAPi/?username=derrick.karake
$studentObject = ConvertFrom-Json -InputObject $student
$studentObject.useridhash
$portname = 'http://studentprinters.oc.edu:631/ipp/r/'+ $studentObject.useridhash + '/' + '128EE3ED'
$driverName = "Canon Generic Plus UFR II"

#function add-cannon{
#New-Item 'C:\OCDrivers\drivers' -ItemType directory
#Copy-Item 'S:\Generic_Plus_UFRII_v2.20_Set-up_x64\Driver\*' 'C:\OCDrivers\drivers'
#$test4 = $Error[0].ToString()
#PNPUtil.exe /add-driver 'C:\OCDrivers\drivers\CNLB0MA64.INF' /install
#Add-PrinterDriver -Name $driverName
#Remove-PSDrive -Name S
#Remove-Item 'C:\OCDrivers' -recurse

#Add-Printer -Name "Cannon Coppier@studentpritners.oc.edu2" -DriverName $driverName -PortName $portname -Verbose



Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$Addprinter = New-Object System.Windows.Forms.Form

$checkBox1 = New-Object System.Windows.Forms.CheckBox
$checkBox2 = New-Object System.Windows.Forms.CheckBox
$checkBox3 = New-Object System.Windows.Forms.CheckBox
$groupBox1 = New-Object System.Windows.Forms.GroupBox
$textBox2 = New-Object System.Windows.Forms.TextBox
$button1 = New-Object System.Windows.Forms.Button
$label2 = New-Object System.Windows.Forms.Label
$button2 = New-Object System.Windows.Forms.Button
#
# checkBox1
#
$checkBox1.AutoSize = $true
$checkBox1.Location = New-Object System.Drawing.Point(22, 41)
$checkBox1.Name = "checkBox1"
$checkBox1.Size = New-Object System.Drawing.Size(148, 24)
$checkBox1.TabIndex = 0
$checkBox1.Text = "Cannon printers"
$checkBox1.UseVisualStyleBackColor = $true

#function OnCheckedChanged_checkBox1 {
#	[void][System.Windows.Forms.MessageBox]::Show("The event handler checkBox1.Add_CheckedChanged is not implemented.")
#}

#$checkBox1.Add_CheckedChanged( { OnCheckedChanged_checkBox1 } )

#
# checkBox2
#
$checkBox2.AutoSize = $true
$checkBox2.Location = New-Object System.Drawing.Point(22, 129)
$checkBox2.Name = "checkBox2"
$checkBox2.Size = New-Object System.Drawing.Size(99, 24)
$checkBox2.TabIndex = 1
$checkBox2.Text = "Select all"
$checkBox2.UseVisualStyleBackColor = $true

#
# checkBox3
#
$checkBox3.AutoSize = $true
$checkBox3.Location = New-Object System.Drawing.Point(22, 85)
$checkBox3.Name = "checkBox3"
$checkBox3.Size = New-Object System.Drawing.Size(114, 24)
$checkBox3.TabIndex = 2
$checkBox3.Text = "HP pritners"
$checkBox3.UseVisualStyleBackColor = $true
#
# groupBox1
#
$groupBox1.Controls.Add($checkBox3)
$groupBox1.Controls.Add($checkBox1)
$groupBox1.Controls.Add($checkBox2)
$groupBox1.Location = New-Object System.Drawing.Point(47, 21)
$groupBox1.Name = "groupBox1"
$groupBox1.Size = New-Object System.Drawing.Size(487, 187)
$groupBox1.TabIndex = 3
$groupBox1.TabStop = $false
$groupBox1.Text = "Select printers"

#function OnEnter_groupBox1 {
	#[void][System.Windows.Forms.MessageBox]::Show("The event handler groupBox1.Add_Enter is not implemented.")
#}

#$groupBox1.Add_Enter( { OnEnter_groupBox1 } )


$checkBox2.add_checkstatechanged({

if($checkBox2.Checked -eq $true){
$checkBox1.Checked =$true
$checkBox3.Checked =$true

}
else{

$checkBox1.Checked =$false
$checkBox3.Checked =$false
}

})

function doit-now {
if($checkBox1.Checked -eq $TRUE){

write-host "i am now adding hp pritner"
 New-Item 'C:\OCDrivers\drivers' -ItemType directory -Verbose
Copy-Item 'S:\Generic_Plus_UFRII_v2.20_Set-up_x64\Driver\*' 'C:\OCDrivers\drivers'-Verbose
#$test4 = $Error[0].ToString()
PNPUtil.exe /add-driver 'C:\OCDrivers\drivers\CNLB0MA64.INF' /install -verbose
Add-PrinterDriver -Name $driverName -Verbose
Remove-PSDrive -Name S
Remove-Item 'C:\OCDrivers' -recurse

Add-Printer -Name "Cannon Coppier@studentpritners.oc.edu" -DriverName $driverName -PortName $portname -Verbose
write-host "done"
}
elseif($checkBox3.Checked -eq $TRUE){

New-Item 'C:\OCDrivers' -ItemType directory -Verbose
Copy-Item 'S:\drivers' 'C:\OCDrivers' -Recurse -Verbose
PNPUtil.exe /add-driver 'C:\OCDrivers\drivers\hpcu240u.inf' /install -verbose
Add-PrinterDriver -Name "HP Universal Printing PCL 6" -Verbose
Remove-PSDrive -Name S 
Remove-Item 'C:\OCDrivers\drivers' -recurse -force
Remove-Item 'C:\OCDrivers' -recurse -force

Add-Printer -Name "Hp pritner@oc.edu" -DriverName "HP Universal Printing PCL 6" -PortName $portname -Verbose
}
elseif($checkBox2.Checked -eq $TRUE){

Write-Host "adding both pritners" 
}
}

#
# textBox2
#
$textBox2.Location = New-Object System.Drawing.Point(47, 264)
$textBox2.Multiline = $true
$textBox2.Name = "textBox2"
$textBox2.ReadOnly = $true
$textBox2.Size = New-Object System.Drawing.Size(487, 107)
$textBox2.TabIndex = 4
$textBox2.Text = $test3
$textBox2.AppendText("testing two")
#
# button1
#
$button1.Location = New-Object System.Drawing.Point(469, 406)
$button1.Name = "button1"
$button1.Size = New-Object System.Drawing.Size(132, 30)
$button1.TabIndex = 5
$button1.Text = " Submit"
$button1.UseVisualStyleBackColor = $true
$button1.Add_click({doit-now})

#
# label2 
#
$label2.AutoSize = $true 
$label2.Location = New-Object System.Drawing.Point(43, 230)
$label2.Name = "label2"
$label2.Size = New-Object System.Drawing.Size(82, 20)
$label2.TabIndex = 5
$label2.Text = "Messages"
#
# button2
#
$button2.Location = New-Object System.Drawing.Point(12, 397)
$button2.Name = "button2"
$button2.Size = New-Object System.Drawing.Size(132, 30)
$button2.TabIndex = 6
$button2.Text = "Cancle"
$button2.UseVisualStyleBackColor = $true
$button2.Add_click({$Addprinter.Close()})
#
# Addprinter
#
$Addprinter.ClientSize = New-Object System.Drawing.Size(613, 448)
$Addprinter.Controls.Add($button1)
$Addprinter.Controls.Add($button2)
$Addprinter.Controls.Add($label2)
$Addprinter.Controls.Add($textBox2)
$Addprinter.Controls.Add($groupBox1)
$Addprinter.Name = "Addprinter"
$Addprinter.Text = " add pritners"

#function OnLoad_Addprinter {
#	[void][System.Windows.Forms.MessageBox]::Show("The event handler Addprinter.Add_Load is not implemented.")
#}

#$Addprinter.Add_Load( { OnLoad_Addprinter } )

<#
function OnFormClosing_Addprinter{ 
	# $this parameter is equal to the sender (object)
	# $_ is equal to the parameter e (eventarg)

	# The CloseReason property indicates a reason for the closure :
	#   if (($_).CloseReason -eq [System.Windows.Forms.CloseReason]::UserClosing)

	#Sets the value indicating that the event should be canceled.
	($_).Cancel= $False
}

$Addprinter.Add_FormClosing( { OnFormClosing_Addprinter} )

$Addprinter.Add_Shown({$Addprinter.Activate()})
$ModalResult=$Addprinter.ShowDialog()
# Release the Form
$Addprinter.Dispose()
#>



$result1 = $addprinter.ShowDialog((New-Object System.Windows.Forms.Form -Property @{TopMost = $true }))
if ($result1 -eq [Windows.Forms.DialogResult]::OK){
    write-host "at the top"
}

}


function try-me {


#function Get-ScriptDirectory
#{ #Return the directory name of this script
#  $Invocation = (Get-Variable MyInvocation -Scope 1).Value
#  Split-Path $Invocation.MyCommand.Path
#}

#$ScriptPath = Get-ScriptDirectory

# Loading external assemblies

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$Form1 = New-Object System.Windows.Forms.Form 


$button1 = New-Object System.Windows.Forms.Button
$button2 = New-Object System.Windows.Forms.Button
$textBox1 = New-Object System.Windows.Forms.TextBox
$label1 = New-Object System.Windows.Forms.Label
#
# button1
#
$button1.Location = New-Object System.Drawing.Point(27, 139)
$button1.Name = "button1"
$button1.Size = New-Object System.Drawing.Size(130, 31)
$button1.TabIndex = 0
$button1.Text = "Try again"
$button1.UseVisualStyleBackColor = $true

$button1.Add_click({test-1})

#
# button2
#
$button2.Location = New-Object System.Drawing.Point(359, 139)
$button2.Name = "button2"
$button2.Size = New-Object System.Drawing.Size(130, 31)
$button2.TabIndex = 1
$button2.Text = "Quit"
$button2.UseVisualStyleBackColor = $true

#quit button action
$button2.Add_click({$form1.Dispose()}) 
#
# textBox1
#
$textBox1.Location = New-Object System.Drawing.Point(27, 82)
$textBox1.Name = "textBox1"
$textBox1.Size = New-Object System.Drawing.Size(462, 26)
$textBox1.TabIndex = 2
$textBox1.ReadOnly = $TRUE
$textBox1.Text = $test3
#
# label1
#
$label1.AutoSize = $true
$label1.Location = New-Object System.Drawing.Point(23, 45)
$label1.Name = "label1"
$label1.Size = New-Object System.Drawing.Size(74, 20)
$label1.TabIndex = 3
$label1.Text = "Message"
#
# Form1
#
$Form1.ClientSize = New-Object System.Drawing.Size(512, 204)
$Form1.Controls.Add($label1)
$Form1.Controls.Add($textBox1)
$Form1.Controls.Add($button2)
$Form1.Controls.Add($button1)
$Form1.Name = "Form1"
$Form1.Text = "Authenitcaiton failed"

function OnLoad_Form1 {
	#[void][System.Windows.Forms.MessageBox]::Show("The event handler Form1.Add_Load is not implemented.")
}

$Form1.Add_Load( { OnLoad_Form1 } )


#function OnFormClosing_Form1{ 
	# $this parameter is equal to the sender (object)
	# $_ is equal to the parameter e (eventarg)

	# The CloseReason property indicates a reason for the closure :
	#   if (($_).CloseReason -eq [System.Windows.Forms.CloseReason]::UserClosing)

	#Sets the value indicating that the event should be canceled.
#	($_).Cancel= $False
#}


$result = $Form1.ShowDialog((New-Object System.Windows.Forms.Form -Property @{TopMost = $true }))
if ($result -eq [Windows.Forms.DialogResult]::OK){
    write-host "at the top"
}

write-host "i am in create form" 
write-host "now in try me" 

}


function global:try-login {

Write-Host "starting again"

[bool]$failedMounting = $FALSE
[bool]$tryagain = $FALSE
[bool]$success = $FALSE

 
[string]$test3 = $null

$creds = $null
$name = $null

$creds = Get-Credential -ErrorAction SilentlyContinue


if ($creds.UserName -eq $null )
{
    write-host "we are quitting"
    break 
}


try {
    New-PSDrive -Name "S" -Root "\\software\dist\Install Printers\drivers" -Scope 'Global' -Persist  -PSProvider "FileSystem" -Credential $creds -ErrorAction Stop
}
catch {
  $test3 = $Error[0].ToString()
	$failedMounting = 1
    #write-host $failedMounting
}

#Write-Host $failedMounting

if ($failedMounting -eq '1'){
	try{
        New-PSDrive -Name "S" -Root "\\joseph" -PSProvider "FileSystem" -Credential $cred -ErrorAction Stop 
	}
	catch{
            $tryagain = 1
    		#write-host $tryagain		
	}
 
}

if ($tryagain)
{
    write-host "try again initiated"
    $failedMounting = 0
    $tryagain = 0
    write-host $failedMounting
    Write-Host $tryagain
    try-me 
}

 else {
 $name = $creds.UserName 
 select-printer
  write-host "calling select printer" 
}

break
}

function test-1 {

$form1.Dispose()

write-host $failedMounting
Write-Host "now in test-1"
try-login
}


try-login


