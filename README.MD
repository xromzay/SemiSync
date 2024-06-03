Shitty utill for syncing your folder via github repo

How to use:
1) Download archive from release
2) Unpack all files to desired directory
3) Run "Start Install.cmd" to begin the installation process
4) Run "git_push.ps1" to upload changes to github
5) Run "git_pull.ps1" to update your folder from github 
6) Run "uninstall.ps1" to uninstall 

What does script do?:
- enables execution policy for .ps1 files
- installs git and github.cli
- initializes folder as git
- creates repo on github named after your computers
- generates 2 scripts in synced folder for pull/push
- pulls from github on startup (can be changed during installation or with "uninstall.ps1")
