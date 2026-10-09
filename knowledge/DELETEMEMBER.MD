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
# Push to remote repository to complete the delete
git push 
```
Then you can delete your source member from your library via PDM option 4 or from RDI or VS Code source member listing.

# Sample using the GITCMD CL command for removing source member from Git repository
This shows the above sample accomplished using the GITCMD CL command from iForGit.
```
IFORGIT/GITCMD IFSREPODIR(*LIBREPODTAARA)                             
       LIBRARY(GITTEST123)                                    
       CMDOPTS('rm QRPGLESRC/DELETE1.RPGLE' 
       'commit -m "Remove file"' push)                                
       DSPSTDOUT(*YES)                                        
```
Then you can delete your source member from your library via PDM option 4 or from RDI or VS Code source member listing.

# Creating a PDM option for removing source member from Git repository.
This is an example PDM option for removing a source member. You can create a similar user action in RDI or VS Code as well if needed.
```
IFORGIT/GITCMD IFSREPODIR(*LIBREPODTAARA)                             
       LIBRARY(&L)                                    
       CMDOPTS('rm &F/&N.&T' 
       'commit -m "Remove file"' 'push')                                
       DSPSTDOUT(*YES)                                        
```
Then you can delete your source member from your library via PDM option 4 or from RDI or VS Code source member listing.

