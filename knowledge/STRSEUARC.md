# Using the STRSEUARC Command to capture changes to Git after editing source with STRSEU
Customer would like to automatically capture source member changes to Git after every SEU source edit.   

Along with the source change being captured to Git, the commnad will interactively prompt the user to enter an optional source member comment.   

In order to make this work correctly the STRSEUARC command will be copied to the QPDA library to replace the existing QPDA/STRSEU command.   

The steps look essentially like this:   
- Rename the ```QSYS/STRSEU``` command to ```QSYS/STRSEUORIG```.   
- Rename the ```QPDA/STRSEU``` command to ```QPDA/STRSEUORIG```.   
- Build the ```STRSEUARC``` command and ```STRSEUARCC``` CL program in the ```IFORGIT``` library.   
- Copy the ```IFORGIT/STRSEUARC``` command to ```QPDA/STRSEU```.     

Essentially the idea is replace the existing ```STRSEU``` command with a copy of ```STRSEUARC``` that commits source changes to Git.

## Set up custom STRSEU command based on STRSEUARC command

### Uploading the STRSEUARC Source Members
```STRSEUARC.CMD```    
https://github.com/richardschoen/iforgit/blob/master/samples/STRSEUARC.CMD   
and     
```STRSEUARCC.CLLE```    
https://github.com/richardschoen/iforgit/blob/master/samples/STRSEUARCC.CLLE   
source members should be first uploaded to the file: ```IFORGIT/SOURCE``` or your own source library

### Prep for new SEU command by renaming originals (which we will use in new cmd:
```
RNMOBJ OBJ(QSYS/STRSEU) OBJTYPE(*CMD) NEWOBJ(STRSEUORIG)
```
``` 
RNMOBJ OBJ(QPDA/STRSEU) OBJTYPE(*CMD) NEWOBJ(STRSEUORIG)   
```

### Copy the QPDA version of the STRSEUORIG command to STRSEU so we can use it temporarily while we work on building the new command
Since we renamed the original versions of STRSEU above we need to create this version in QPDA so we can edit source members if needed before we put out replacement command in place. 
❗If you're using RDI or VS Code to edit the source you can probably skip this step  
```
CRTDUPOBJ OBJ(STRSEUORIG)       
          FROMLIB(QPDA)         
          OBJTYPE(*CMD)         
          TOLIB(*FROMLIB)       
          NEWOBJ(STRSEU)        
```

### Build STRSEUAUD command and CL program in IFORGIT library:
❗Requires the STRSEUORIG command to already exist as renamed above.

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

```
DLTCMD CMD(QPDA/STRSEU) 
```
```
CRTDUPOBJ OBJ(STRSEUARC)    
          FROMLIB(IFORGIT)  
          OBJTYPE(*CMD)     
          TOLIB(QPDA)       
          NEWOBJ(STRSEU)    
```
Now when members are edited with option 2 in PDM or with STRSEU directly, a snapshot of the source member will be made before and after the edit operation to source snapshot file: ```IFORGIT/GITSRCARC```

To view or copy source archive snapshots, do the following:

```GO IFORGIT/IFORGITMBR``` (Simple Source Management Menu)   

Take ```option 10.``` - Work with Archived Source in GITSRCARC
It essentially does the following:
```
WRKMBRPDM FILE(IFORGIT/GITSRCARC)  
```

## To undo the entire setup and go back to original SEU, we will copy STRSEUORIG commands back to STRSEU
❗We can leave copies named STRSEUORIG in place as backups.

### Delete STRSEU commands 
(assuming you have the STRSEUORIG backup versions)
```
DLTCMD CMD(QPDA/STRSEU) 
```
```
DLTCMD CMD(QSYS/STRSEU) - May not exist based on our rename before
```
### Copy STRSEUORIG back to STRSEU in QSYS and QPDA
```
CRTDUPOBJ OBJ(STRSEUORIG)       
          FROMLIB(QPDA)         
          OBJTYPE(*CMD)         
          TOLIB(QPDA)       
          NEWOBJ(STRSEU)        
```
```
CRTDUPOBJ OBJ(STRSEUORIG)       
          FROMLIB(QSYS)         
          OBJTYPE(*CMD)         
          TOLIB(QSYS)       
          NEWOBJ(STRSEU)        
```
