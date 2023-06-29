# Resolving a SRCTOGIT source member commit issue if someone has already committed a change on remote repository
There might be times where someone changes and commits a source member on Github or using a PC editor such as VS Code and that change gets committed to your remote repository. However the change has not been pulled back into the IBM i Source Physical File yet via the SRCFRMGIT command.   

A remote change not reflected in your IBM i source files may cause a merge conflict the next time you try to commit your source member with ```SRCTOGIT``` with ```*COMMITSYNC``` for the ```COMMITOPT``` parameter.   

What should you do if you get a merge conflict error ?   

## The short answer
Edit your source member from the source file with SEU, RDI or VS Code and make at least one change or correction to the source member to get it in the state you want. Then re-commit the source to git via ```SRCTOGIT``` with ```*COMMITSYNC```. This will commit the updates locally in the IBM i source file, in the local IFS git repository and then will pull and push the local IFS source copy and should result in a successful commit.  

## The longer version  

## Example of a merge conflict.
Let's just say that ran the SRCTOGIT command from PDM, RDI or VS Code with the *COMMITSYNC option and got something like the following error:   
```
------------------------------.                                         
Begin Stdout Git.                                                       
------------------------------.                                         
remote: Enumerating objects: 7, done..                                  
remote: Counting objects:  14% (1/7)        remote: Counting objects:  
  28% (2/7)        remote: Counting objects:  42% (3/7)        remote:
  Counting objects:  57% (4/7)        remote: Counting objects:  71%   
  (5/7)        remote: Counting objects:  85% (6/7)        remote:    
  Counting objects: 100% (7/7)        remote: Counting objects: 100%   
  (7/7), done..                                                         
remote: Compressing objects:  25% (1/4)        remote: Compressing     
  objects:  50% (2/4)        remote: Compressing objects:  75% (3/4)   
    remote: Compressing objects: 100% (4/4)        remote: Compressing
   objects:  75% (3/4)Unpacking objects: 100% (4/4)Unpacking objects: 
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

When this happens we need to resolve the merge conflict and then re-commit the source member to get things back on track.    

## What should you do to fix the merge problem ?
The first thing to do is to review the IFS version of the source member that was just pulled from GitHub during the last SRCTOGIT with *COMMITSYNC.

The IFS version most likely has the marked up changes that were in conflict after the merge conflict happened.   

Then review the corresponding version of the source in the source physical file.    

Open the source member in the source physical file for editing via SEU, RDI or VS Code and make the desired changes that you want to preserve in the git repository for this source member.    

Then save the source member and use the PDM GE option, or RDI/VS Code action to run the SRCTOGIT command again with *COMMITSYNC.   

This should resolve your source merge conflict issue.    

If this doesn't resolve your conflict, let us know.

