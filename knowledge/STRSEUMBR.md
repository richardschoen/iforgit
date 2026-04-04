# Using the STRSEUMBR Command to capture before/after changes from STRSEU
Customer has a need to determine who is making changes to source members with SEU.

This is an independent auditing need external to iForGit.

The iForGit software (V1.28 and beyond) ships with a CL command called ```MBRARC```. The command can snapshot a source member to 
a source file ```IFORGIT/GITSRCARC```.

When coupled with the ```STRSEUARC``` command to replace the default ```STRSEU``` command, source member 
change made via PDM and SEU can be captured independently of any Git commits to source member snapshots. 

The iForGit source member snapshot file is: ```IFORGIT/GTSRCARC```. 

Essentially the idea is replace the existing ```STRSEU``` command with a copy of ```STRSEUARC``` that takes quick snapshot copies. 

❗ If needed a variation of this could be done to use the SRCTOGIT command, but for now we will use ```MBRARC``` for snapshotting source members.

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
