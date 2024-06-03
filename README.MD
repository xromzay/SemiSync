Shitty utill for syncing your folder via github repo

How to use:
1) Download files from release
2) Run "Start Install.cmd"
3) To upload changes to github run git_push.ps1
4) To update your folder from github run git_pull.ps1
5) To uninstall run "uninstall.ps1"

What does script do?:
- enables execution policy for .ps1 files
- installs git and github.cli
- initializes folder as git
- creates repo on github named after your computers
- generates 2 scripts in synced folder for pull/push
- pulls from github on startup (can be changed during installation or with "uninstall.ps1")
