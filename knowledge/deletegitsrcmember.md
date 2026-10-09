# Remove source member from Git Repository using iForGit Command
Sometimes the need arises to remove a source member from a Git repository that will also be deleted from a source physical file. 

The steps would be:
- Remove the source member from your Git repository.
- Delete the source member from the source file using PDM option 4 or using RDI or VS Code.

For understanding how Git would do this, the general manual Git sequence for deleting a source member from a repository is something like this:
```
# Remove the member from the local IFS repository
git rm /gitrepos/gittest123/qrpglesrc/member1.rpgle
# Commit the delete to the repository
git commit -m "Remove member1.rpgle"
# Push to remote repository to complete the delete if you are using a remote Git repo.
git push 
```
After removing the entry from your Git repository you can delete your source member from your library via PDM option 4 or from RDI or VS Code source member listing.

# Sample using the GITCMD CL command for removing source member from Local Git repository
This shows the above Git sample delete sequence accomplished using the GITCMD CL command from iForGit.   

This example does a remove/delete from the local Git repository in the IFS only and displays the results.
```
IFORGIT/GITCMD IFSREPODIR(*LIBREPODTAARA)                      
               LIBRARY(GITTEST123)                             
               CMDOPTS('rm QRPGLESRC/DELETE1.RPGLE' 
               'commit -m "Remove file"')
               DSPSTDOUT(*YES)                                 
```
This example does a remove/delete from the local Git repository and syncs that removal to the remote repository via the push command. It also displays the results. 
```
IFORGIT/GITCMD IFSREPODIR(*LIBREPODTAARA)                      
               LIBRARY(GITTEST123)                             
               CMDOPTS('rm QRPGLESRC/DELETE1.RPGLE' 
               'commit -m "Remove file"' 
               'push')                                
               DSPSTDOUT(*YES)                                 
```

After removing the entry from your Git repository you can delete your source member from your library via PDM option 4 or from RDI or VS Code source member listing.

# Creating a PDM option for removing source member from local IFS Git repository only.
This is an example ```PDM``` option for removing a source member. You can create a similar user action in ```RDI``` or ```VS Code``` as well if needed.   

This example does a remove/delete from the local Git repository in the IFS only and displays the results. If there happens to be a remote repository connected, the results will sync to the remote the next time a ```git push``` is done.
```
IFORGIT/GITCMD IFSREPODIR(*LIBREPODTAARA)                             
       LIBRARY(&L)                                    
       CMDOPTS('rm &F/&N.&T' 
       'commit -m "Remove file"')                                
       DSPSTDOUT(*YES)                                        
```
After removing the entry from your Git repository you can delete your source member from your library via PDM option 4 or from RDI or VS Code source member listing.

# Creating a PDM option for removing source member from local IFS Git repository and syncing the removal to a remote repo
This is an example ```PDM``` option for removing a source member. You can create a similar user action in ```RDI``` or ```VS Code``` as well if needed.

This example does a remove/delete from the local Git repository in the IFS only and syncs the results to the remote Git repository if you are using a remote Git repo.
```
IFORGIT/GITCMD IFSREPODIR(*LIBREPODTAARA)                             
       LIBRARY(&L)                                    
       CMDOPTS('rm &F/&N.&T' 
       'commit -m "Remove file"' 'push')                                
       DSPSTDOUT(*YES)                                        
```
After removing the entry from your Git repository you can delete your source member from your library via PDM option 4 or from RDI or VS Code source member listing.
