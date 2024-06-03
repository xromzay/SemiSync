function RemoveSoftware
{
	winget uninstall --silent --name git.git
	winget uninstall --silent --name github.cli
}

function RemoveRepo
{
	gh auth refresh -s delete_repo
	gh repo delete --yes
}

function RemoveJobs
{
	$TaskName = "SemiSyncPull"
	$TaskExists = Get-ScheduledTask | Where-Object {$_.TaskName -like $taskName }
	if($taskExists) 
	{
		Unregister-ScheduledJob $TaskName
	}
	else 
	{
		
	}
}

function RemoveTools
{
	Remove-Item .\git_pull.ps1
	Remove-Item .\git_push.ps1
	Remove-Item .\uninstall.ps1
	Remove-Item .\$HiddenDir -recurse -force -confirm:$false
	Remove-Item .\.git -recurse -force -confirm:$false
}

function AccessApproval
{
	echo @'
Are you sure you want to proceed?
Yes - Y
No - any key
'@
	$ApprovalVar = read-host "input"
	if ($ApprovalVar -eq "Y")
	{
		
	}
	else
	{
		exit
	}
}

Set-ExecutionPolicy Unrestricted
$HiddenDir = ".deleteifyouwant"
echo @'
Select uninstall type:
F - full (remove everything, git, github.cli, repo, SemiSync, etc)
P - partly (remove repo, all SemiSync files and system changes)
T - tools (remove just SemiSync and scheduled job)
R - repo (remove just repo)
All user files will stay untouched!
anything other - quit
'@ 
$UninstallType = read-host "Select"

if ($UninstallType -eq "F") # -or ($UninstallType = 'f')
{
	AccessApproval
	RemoveSoftware
	RemoveRepo
	RemoveJobs
	RemoveTools
	echo "Done"
	exit
}
elseif ($UninstallType -eq "P") # -or ($UninstallType = 'p'))
{
	AccessApproval
	RemoveRepo
	RemoveTools
	RemoveJobs
	echo "Done"
	exit
}
elseif ($UninstallType -eq "T") # -or ($UninstallType = 'r'))
{
	AccessApproval
	RemoveTools
	RemoveJobs
	echo "Done"
	exit
}
elseif ($UninstallType -eq "R") # -or ($UninstallType = 'r'))
{
	AccessApproval
	RemoveRepo
	echo "Done"
	exit
}
else 
{
	exit
}