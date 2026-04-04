# Using the STRSEUARC command to replace STRSEU and capture changes to Git after editing source with STRSEU
Customer would like to capture source member changes automatically to Git after every SEU source edit.   

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

### Prep for the new STRSEU command by renaming the original STRSEU commands to STRSEUORIG
```
RNMOBJ OBJ(QSYS/STRSEU) OBJTYPE(*CMD) NEWOBJ(STRSEUORIG)
```
``` 
RNMOBJ OBJ(QPDA/STRSEU) OBJTYPE(*CMD) NEWOBJ(STRSEUORIG)   
```

### Copy the QPDA version of the STRSEUORIG command to STRSEU so we can use it temporarily while we work on building the new STRSEUARC command
Since we renamed the original versions of STRSEU above we need to create this version of STRSEU in QPDA temporarily so we can edit any source members via SEU if needed before we put our new replacement STRSEU command in place.   
❗If you're using RDI or VS Code to edit the source you can probably skip this step  
```
CRTDUPOBJ OBJ(STRSEUORIG)       
          FROMLIB(QPDA)         
          OBJTYPE(*CMD)         
          TOLIB(*FROMLIB)       
          NEWOBJ(STRSEU)        
```

### Build the STRSEUARC command and CL program in IFORGIT library:
❗Requires the STRSEUORIG command to already exist as created above via renaming STRSEU to STRSEUORIG.   

#### Create the STRSEUARC CL command 
```
CRTCMD CMD(IFORGIT/STRSEUARC)  
         PGM(IFORGIT/STRSEUARCC) 
         SRCFILE(IFORGIT/SOURCE)
         SRCMBR(STRSEUARC)       
         PRDLIB(IFORGIT)         
         REPLACE(*YES)            
```
#### Create the STRSEUARCC CL Program
```
CRTBNDCL PGM(IFORGIT/STRSEUARCC)     
         SRCFILE(IFORGIT/SOURCE)    
         SRCMBR(STRSEUARCC)          
         REPLACE(*YES)               
```

### Replace the temporary STRSEU command in QPDA with a copy of STRSEUARC command renamed as STRSEU

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
Now when members are edited with option 2 in PDM or with STRSEU directly the new version of STRSEU will be used. A Git commit of the source member changes will be made automatically after the edit operation completes. Interally the ```SRCTOGIT``` command is called automatically with the ```*COMMIT``` option to do a local commit of changes to the IFS Git repository. 

❗You will still need to do a ```git pull``` and ```git push``` operation to sync changes to your remote Git repository if using a remote Git server such as GitHub, GitLab, etc.  

## To undo the entire setup and go back to using the original STRSEU command, we will copy STRSEUORIG commands back to STRSEU
❗We can leave the backup copies of STRSEU named STRSEUORIG in place as backups in QSYS and QODA.

### Delete STRSEU commands QPDA/STRSEU and QSYS/STRSEU
(assuming you have the STRSEUORIG backup versions QPDA/STRSEUORIG and QSYS/STRSEUORIG)      
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
Now the original STRSEU commands should be back in place. 
