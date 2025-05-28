#testing folder location before backup
$Folder = "<folder path for dataflow backup>\$((Get-Date).ToString('dd-MMM-yyyy'))"
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
$dataflows = Get-PowerBIDataflow -WorkspaceId $workspace.Id
$folderpath = New-Item -ItemType Directory -Path "<folder path for dataflow backup>\$((Get-Date).ToString('dd-MMM-yyyy'))"
 
foreach ($dataflow in $dataflows) {
    # Get the dataflow definition
    $dataflowDefinition = Get-PowerBIDataflow -WorkspaceId $workspace.Id -DataflowId $dataflow.Id
    #$dataflowDefinition.Name+":"+$dataflowDefinition.Id
    # Save the dataflow definition to a file
    $filePath = "$($folderpath)\$($dataflowDefinition.Name).json"
	$filePath1 = "$($folderpath)\$($dataflowDefinition.Name).sql"
    Export-PowerBIDataflow -WorkspaceId $workspace.Id -Id $dataflowDefinition.Id -OutFile $filePath 
	# converting .json into a .sql
	Get-Content $filePath -Raw | ConvertFrom-Json| % {$_.'pbi:mashup'.document.psobject.BaseObject }| % {$_ -replace "#\(lf\)","`r`n"}|Out-File $filePath1
}
"Backup Done!."
}