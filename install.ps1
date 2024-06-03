function CreatePushScript
{
add-content -path .\git_push.ps1 -Value "cd $folderpath"
add-content -path .\git_push.ps1 @'
$time = Get-Date -DisplayHint Date
git add .
git commit -m "$time"
git push -u origin main
echo "done"
'@
}

function CreatePullScript
{
add-content -path .\git_pull.ps1 -Value "cd $folderPath"
add-content -path .\git_pull.ps1 @'
git pull origin main
'@
}

function HideFiles
{
$HiddenDir = ".deleteifyouwant"
New-Item -path .\$HiddenDir -ItemType Directory
attrib +h $HiddenDir
Move-Item -path .\install.ps1 -destination .\$HiddenDir\install.ps1
Move-Item -path .\"start install.cmd" -destination .\$HiddenDir\"start install.cmd"
Move-Item -path .\install.ps1 -destination .\$HiddenDir\install.ps1

}

echo "Setting up execution policy"
echo ""
Set-ExecutionPolicy Unrestricted
echo "Installing git and github.cli"
echo ""
winget install -e --id Git.Git
winget install -e --id GitHub.cli

echo "Loggining in GitHub..."
gh auth login
git init
gh repo create "SemiSync-$Env:ComputerName" --private --source=.

#echo "Loggining in git..."
#echo ""
#$namegit = Read-Host "Enter Your username: "
#git config user.name $namegit
#$emailgit = Read-Host "Enter Your Email: "
#git config user.email $emailgit
#echo ""
#echo "Proceede in web browser"
#echo ""

echo "Creating push and pull scripts..."
#$folderpath = Read-Host "Enter path to your syncing folder: "
$FolderPath = (pwd).path
$PushScriptPath = $folderpath+'\git_push.ps1'
$PullScriptPath = $folderpath+'\git_pull.ps1'

if ([System.IO.File]::Exists($PushScriptPath))
{
	Remove-Item $PushScriptPath
	CreatePushScript
}
else
{
	CreatePushScript
}

if ([System.IO.File]::Exists($PullScriptPath))
{
	Remove-Item $PullScriptPath
	CreatePullScript
}
else
{
	CreatePullScript
}

echo "Script execution..."
.\git_push.ps1

echo @'Do you want auto-pull on startup?
Y - Yes
N - Any key
'@
$AnswerStartUp = read-host "Your answer: "
$trigger = New-JobTrigger -AtStartup -RandomDelay 00:00:30
#path to script "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup\SemiSyncUpd.cmd"
if ($AnswerStartUp -eq "Y")
{
	Register-ScheduledJob -Trigger $trigger -FilePath $PullScriptPath -Name SemiSyncPull
}
else
{
	continue
}

echo "Hiding installation files..."
HideFiles

echo ""
echo "Complete."
read-host "Press ENTER to continue..."
