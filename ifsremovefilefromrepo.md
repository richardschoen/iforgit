# Remove a source member from an IFS based git repository from the green screen
This document illustrates a sample for removing an existing source member from a git repository using the selected git CL command sequence.

This step **DOES NOT remove the member from the associated IBM i source file** if the source member happens to live in an IBM i source file as well. The source member will still need to be deleted from the IBM if the source member is no longer needed.

## Sample CL command sequence to delete a single source member form a repository

This example deletes an individual source member named: creates an IFS repository named: **/testsite001/QCLSRC/sample001.clp**

Add IBM Open Source Packages /QOpenSys/pkgs/bin to path for green screen job

Note: This command can be skipped if your user already has the path set.     
```
IFORGIT/GITPATH          
```

Remove an individual IFS source member named: **/testsite001/QCLSRC/sample001.clp** and execute a git repository commit while also setting a commit message of "My Delete Commit" using the GITQSH command to run the QShell commands. Display the log on screen.
```
IFORGIT/GITQSH CMDLINE('cd /testsite001/QCLSRC;git rm sample001.clp;git add .;git commit -m "My Delete Commit"') DSPSTDOUT(*YES)                                               
```

The above command changes to the git repository directory where the IFS source member lives, then issues the ```git rm``` command to mark the file for deletion from the repository. Then the ```git add .``` and ```git commit``` commands are executed to commit the changes to the repository. 

For more info on the ```git rm``` command, check out the following links:\
https://git-scm.com/docs/git-rm
https://www.atlassian.com/git/tutorials/undoing-changes/git-rm
 
## Purging a file permanantly from a repository
Distributed version control isn't designed to allow folks to delete every instance of a file. But, if you run into a case where you need to expunge a file in git, here is an example of how to did it.\
https://chrisshort.net/permanently-remove-any-record-of-a-file-from-git/

