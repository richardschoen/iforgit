# Remove source member from Git Repository using iForGit Command

The general manual Git sequence for deleting a source member from a repository is something like this:
```
# Remove the member from the local IFS repository
git rm /gitrepos/gittest123/qrpglesrc/member1.rpgle
# Commit the delete to the repository
git commit -m "Remove member1.rpgle"
# Push to remote repository to complete the delete
git push 
```
Then you can delete your source member from your library. 

# Sample CL command for removing source member from Git repository
```
IFORGIT/GITCMD IFSREPODIR(*LIBREPODTAARA)                             
       LIBRARY(GITTEST123)                                    
       CMDOPTS('rm QRPGLESRC/DELETE1.RPGLE' 
       'commit -m "Remove file"' push)                                
       DSPSTDOUT(*YES)                                        
```
Then you can delete your source member from your library via option 4. 

# Creating a PDM option for removing source member from Git repository
```
IFORGIT/GITCMD IFSREPODIR(*LIBREPODTAARA)                             
       LIBRARY(&L)                                    
       CMDOPTS('rm &F/&N.&T' 
       'commit -m "Remove file"' 'push')                                
       DSPSTDOUT(*YES)                                        
```
Then you can delete your source member from your library via option 4. 

