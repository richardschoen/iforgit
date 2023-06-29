# Resolving a SRCTOGIT source member commit issue if someone has already committed a change on remote repository
There might be times where someone changes and commits a source member on Github or using a PC editor such as VS Code and that change gets committed to your remote repository. However the change has not been pulled back into the IBM i Source Physical File yet via the SRCFRMGIT command.   

This may cause a merge conflict the next time you try to commit your source member with SRCTOGIT.  

What should you do if you get a merge conflict ?   

The short answer is to edit your source member to make corrections in the soucre physical file.  And then re-commit the source to git via SRCTOGIT. That should resolve the issue.    

## You get a merge conflict.
Let's just say that ran the SRCTOGIT command from PDM, RDI or VS Code with the *COMMITSYNC option and got something like the following error:   
```
------------------------------.                                         
Begin Stdout Git.                                                       
------------------------------.                                         
remote: Enumerating objects: 7, done..                                  
remote: Counting objects:  14% (1/7)        █remote: Counting objects:  
  28% (2/7)        █remote: Counting objects:  42% (3/7)        █remote:
  Counting objects:  57% (4/7)        █remote: Counting objects:  71%   
  (5/7)        █remote: Counting objects:  85% (6/7)        █remote:    
  Counting objects: 100% (7/7)        █remote: Counting objects: 100%   
  (7/7), done..                                                         
remote: Compressing objects:  25% (1/4)        █remote: Compressing     
  objects:  50% (2/4)        █remote: Compressing objects:  75% (3/4)   
    █remote: Compressing objects: 100% (4/4)        █remote: Compressing
   objects:  75% (3/4)█Unpacking objects: 100% (4/4)█Unpacking objects: 
   100% (4/4), 802 bytes | 16.00 KiB/s, done..                          
 From ssh://github.com:/richardschoen/GITTEST123.                       
 751cc24..a922280  master     -> origin/master.                         
 Auto-merging QRPGLESRC/HELLO.RPGLE.                                    
 CONFLICT (content): Merge conflict in QRPGLESRC/HELLO.RPGLE.           
 Automatic merge failed; fix conflicts and then commit the result..
------------------------------.                                      
End Stdout Git.                                                      
------------------------------.                                      
Errors 00001 occurred while running git operation. Check the joblog.
Errors occurred while exporting source member to the IFS for git. Check
  the job log.                                                         
```

### What should you do to fix the merge problem ?
The first thing to do is to review the IFS version of the source member that was just pulled from GitHub.    

The IFS version most likely has the marked up changes that were in conflict.    

Then review the corresponding version of the source in the source physical file.    

Open the source member in the source physical file for editing via SEU, RDI or VS Code and make the changes you want to preserve in the git repository.     

Then save the source member and use the PDM GE option, or RDI/VS Code action to run the SRCTOGIT command again with *COMMIT.   

This should resolve your source merge conflict issue.    

If this doesn't resolve your conflict, let us know.













