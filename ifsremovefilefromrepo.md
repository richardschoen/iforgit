# Remove a source member from an IFS based git repository from the green screen
This document illustrates a sample for removing an existing source member from a git repository using the selected git command sequence.

This step DOES NOT remove the member from the associated IBM i source file if the source member happens to live in an IBM i source file. 

The source member will still need to be deleted from the IBM if the source member is no longer needed.

## Sample command sequence to delete a single source member form a repository

This example deletes an individual source member named: creates an IFS repository named: **/testsite001/QCLSRC/sample001.clp**

/* Add IBM Open Source Packages /QOpenSys/pkgs/bin to path for green screen job */
/* Note: This command can be skipped if your user already has the path set.     */
```
IFORGIT/GITPATH          
```

/* Remove an individual source member named: **/testsite001/QCLSRC/sample001.clp** and execute a git repository commit while also setting a commit message of "My Delete Commit"  */
/* using the GITQSH command to run the QShell commands. Display the log on screen. */
```
IFORGIT/GITQSH CMDLINE('cd /testsite001/QCLSRC;git rm sample001.clp;git add .;git commit -m "My Delete Commit"') DSPSTDOUT(*YES)                                               
```
