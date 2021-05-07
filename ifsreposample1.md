# Managing a single shared IFS based git repository from the green screen
This document illistrates a sample for creating a new git repository and also for performing regular source commits to the repository from the IFS directory. For this example it's assumed that the IFS directory is a single shared IFS repository directory where one or more developers may be editing from the same IFS respository directory.

Care must be taken not to edit the same file at the same time when sharing a repository, but this keeps managing a git repository very easy to manage for first time git users. 

Later your team can get more advanced and start allowing each developer to have a working copy of the selected IFS repository or create code branches. Start simple !!

## Sample command sequence to initially create your git repository

This example creates an IFS repository named: /testsite001. A repository only needs to be created one time.

/* Add IBM Open Source Packages /QOpenSys/pkgs/bin to path for green screen job */
/* Note: This command can be skipped if your user already has the path set.     */
```
IFORGIT/GITPATH          
```

/* Create IFS directory and initialize new git repository in the IFS */
/* using the GITQSH command to run the QShell commands. Display the log on screen. */
```
IFORGIT/GITQSH CMDLINE('mkdir /testsite001;cd /testsite001;git init') DSPSTDOUT(*YES)                                   
```               

## Sample command sequence to perform a code commit of changed files to the git repository from /testsite001 IFS git repository directory

This example can be run one or more times per day to commit individual source member changes for your IFS repository directory.  It is a good idea to commit changes often to make sure you do not overwrite or lose any source changes. 

/* Add IBM Open Source Packages /QOpenSys/pkgs/bin to path for green screen job */
/* Note: This command can be skipped if your user already has the path set. */
```
IFORGIT/GITPATH          
```

/* Add all recently changed IFS files and execute a git repository commit while also setting a commit message of "My Commit"  */
/* using the GITQSH command to run the QShell commands. Display the log on screen. */
```
IFORGIT/GITQSH CMDLINE('cd /testsite001;git add .;git commit -m "My Commit"') DSPSTDOUT(*YES)                                               
```
