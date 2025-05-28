#testing folder location before backup
$Folder = "<folder path for report backup>\$((Get-Date).ToString('dd-MMM-yyyy'))"
"Test to see if folder [$Folder]  exists"
if (Test-Path -Path $Folder) {
    "Path exists!"
} else {
    "Path doesn't exist.Creating the backup.."

#powershell powerbi module in windows powershell
Import-Module MicrosoftPowerBIMgmt
$username="<username>"
$password="<password>"|ConvertTo-SecureString -asPlainText -Force
$credential = New-Object System.Management.Automation.PSCredential($username, $password)
Connect-PowerBIServiceAccount -credential $credential
$workspace = Get-PowerBIWorkspace -Name "<powerbi workspacename>"
$reports = Get-PowerBIReport -WorkspaceId $workspace.Id 
$folderpath = New-Item -ItemType Directory -Path "<folder path for report backup>\$((Get-Date).ToString('dd-MMM-yyyy'))"
 
foreach ($report in $reports.Id) {
	$reportName = Get-PowerBIReport -WorkspaceId $workspace.Id -Id $report |  Select -Expand "Name"
    $filePath = "$($folderpath)\$($reportName) $((Get-Date).ToString('dd-MMM-yyyy')).pbix"
	Export-PowerBIReport -WorkspaceId $workspace.Id -Id $report -OutFile $filePath 
	}
"Backup Done!."
}