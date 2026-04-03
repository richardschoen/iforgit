# Using the STRSEUARC Command to capture before/after changes from STRSEU
Customer has a need to determine who is making changes to source members with SEU.

This is an independent auditing need external to iForGit.

The iForGit software (V1.28 and beyond) has a CL command called ```MBRARC```. The command can snapshot a source member to 
a source file ```IFORGIT/GITSRCARC```.

When coupled with the ```STRSEUARC``` command to replace the default ```STRSEU``` command, changes made via 
PDM and SEU can be captured independently of any Git commits. 

## Uploading STRSEUARC Source Members
The ```STRSEUARC.CMD``` and ```STRSEUARCC.CLLE``` source members should be first uploaded to the 
file: ```IFORGIT/SOURCE``` or your own source library

## Set up custom STRSEU command based on STRSEUARC command

### Prep for new SEU command by renaming originals (which we will use in new cmd:
```
RNMOBJ OBJ(QSYS/STRSEU) OBJTYPE(*CMD) NEWOBJ(STRSEUORIG)   
RNMOBJ OBJ(QPDA/STRSEU) OBJTYPE(*CMD) NEWOBJ(STRSEUORIG)   
```

### Copy the QPDA version of the STRSEUORIG command to STRSEU so we can use it temporarily while we work on building the new command
```
CRTDUPOBJ OBJ(STRSEUORIG)       
          FROMLIB(QPDA)         
          OBJTYPE(*CMD)         
          TOLIB(*FROMLIB)       
          NEWOBJ(STRSEU)        
```

### Build STRSEUAUD command and CL in IFORGIT library:
(Requires the STRSEUORIG command to already exist as copied above)
STRSEUARC
STRSEUARCC

#### Build the STRSEUARC CL command 
```
CRTCMD CMD(IFORGIT/STRSEUARC)  
         PGM(IFORGIT/STRSEUARCC) 
         SRCFILE(IFORGIT/SOURCE)
         SRCMBR(STRSEUARC)       
         PRDLIB(IFORGIT)         
         REPLACE(*YES)            
```
#### Build the STRSEUARCC CL Program
```
CRTBNDCL PGM(IFORGIT/STRSEUARCC)     
         SRCFILE(IFORGIT/SOURCE)    
         SRCMBR(STRSEUARCC)          
         REPLACE(*YES)               
```

### Replace the temporary STRSEU command in QPDA with a copy of STRSEUAUD command renamed as STRSEU

DLTCMD CMD(QPDA/STRSEU) 

CRTDUPOBJ OBJ(STRSEUARC)    
          FROMLIB(IFORGIT)  
          OBJTYPE(*CMD)     
          TOLIB(QPDA)       
          NEWOBJ(STRSEU)    

Now when members are edited with option 2 in PDM, a snapshot of the source member will be made before and after the edit operation.

To see source archive snapshots, do the following:

GO IFORGIT/IFORGITMBR (Simple Source Management Menu)

Take options 10. - Work with Archived Source in GITSRCARC
It essentially does the following:

WRKMBRPDM FILE(IFORGIT/GITSRCARC)  


To undo the entire setup and go back to original SEU copy commands back
(We can leave copies named STRSEUORIG in place as backups)

Delete STRSEU commands 
(assuming you have the STRSEUORIG backup versions)
DLTCMD CMD(QPDA/STRSEU) 
DLTCMD CMD(QSYS/STRSEU) - May not exist based on our rename before

Copy STRSEUORIG back to STRSEU in QSYS and QPDA
CRTDUPOBJ OBJ(STRSEUORIG)       
          FROMLIB(QPDA)         
          OBJTYPE(*CMD)         
          TOLIB(QPDA)       
          NEWOBJ(STRSEU)        

CRTDUPOBJ OBJ(STRSEUORIG)       
          FROMLIB(QSYS)         
          OBJTYPE(*CMD)         
          TOLIB(QSYS)       
          NEWOBJ(STRSEU)        
<img width="1006" height="2830" alt="image" src="https://github.com/user-attachments/assets/b45b8e79-88fb-41a8-acbd-8389f5d94889" />
