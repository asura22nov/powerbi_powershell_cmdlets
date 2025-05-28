# powerbi_powershell_cmdlets
Microsoft PowerShell Script to backup Power BI Dataflows and Reports from a PowerBI workspace

References:
https://learn.microsoft.com/en-us/powershell/power-bi/overview?view=powerbi-ps

MicrosoftPowerBIMgmt.Admin
MicrosoftPowerBIMgmt.Capacities
MicrosoftPowerBIMgmt.Data
MicrosoftPowerBIMgmt.Profile
MicrosoftPowerBIMgmt.Reports
MicrosoftPowerBIMgmt.Workspaces

STEPS

Installation

  1. install all the Powershell PowerBI modules using 

Install-Module -Name MicrosoftPowerBIMgmt.Data -Scope CurrentUser  

  2.if there is a "Untrusted repository" error execute the below powershell query

Set-PSRepository -Name 'PSGallery' -InstallationPolicy Trusted -Scope CurrentUser

  3.Enter the details of the Folder path and Power BI Workspace details into the .ps1 file
  4.Try calling the .ps1 from the .bat file

NOTE: 

  1.SQL file converted from .JSON output is in the format of the Microsoft POWER QUERY. Hence remove the unnecessary power query code in the SQL query before running.
  2.Use Windows Task Scheduler to run the .bat files at desired time as a automation for dataflow and report back-up from Power BI workspace
