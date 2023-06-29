# Resolving a SRCTOGIT issue if someone makes a change on remote repository
There might be times where someone changes and commits a source member on Github or using a PC editor such as VS Code and that change gets committed to your remote repository but has not been pulled back into the IBMi Source Physical File yet.    

What should you do ?

# You get a merge conflict.
Let's just say that ran the SRCTOGIT command from PDM, RDI or VS Code with the *COMMITSYNC option and got the following error:
```
   objects:  75% (3/4)█Unpacking objects: 100% (4/4)█Unpacking objects: 
   100% (4/4), 802 bytes | 16.00 KiB/s, done..                          
 From ssh://github.com:/richardschoen/GITTEST123.                       
 751cc24..a922280  master     -> origin/master.                         
 Auto-merging QRPGLESRC/HELLO.RPGLE.                                    
 CONFLICT (content): Merge conflict in QRPGLESRC/HELLO.RPGLE.           
 Automatic merge failed; fix conflicts and then commit the result..
```

What should you do to fix the problem ?





