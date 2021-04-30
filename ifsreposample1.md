# Managing an IFS based git repository from the green screen

## Sample command sequence to initially create your git repository

This example creates an IFS repository named: /testsite001

/* Add IBM Open Source Packages /QOpenSys/pkgs/bin to path for green screen job */
/* Note: This command can be skipped if your user already has the path set.     */
```
IFORGIT/GITPATH          
```

/* Create IFS directory and initialize new git repository in the IFS */
/* using the 
```
IFORGIT/GITQSH CMDLINE('mkdir /testsite001;cd /testsite001;git init') DSPSTDOUT(*YES)                                   
```               

## Sample command sequence to perform a code commit of changed files to the git repository from /testsite001 IFS git repository directory

/* Add IBM Open Source Packages /QOpenSys/pkgs/bin to path for green screen job */
/* Note: This command can be skipped if your user already has the path set.     */
```
IFORGIT/GITPATH          
```

/* Add all recently changed IFS files and execute a git repository commit while also setting a commit message of "My Commit"
```
IFORGIT/GITQSH CMDLINE('cd /gitrepostest/testsite001;git add .;git commit -m "My Commit"') DSPSTDOUT(*YES)                                               
```
