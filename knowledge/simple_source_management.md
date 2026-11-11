# iForGit Simple Source Management CL Commands
This document is a shortcut getting started document for using the simple source management commands in iForGit. The simple source management commands can be used to do local source checkouts between libraries for development purposes with or without using Git commands. 

If you're not quite ready to go live with Git, the commands can be a nice way to quickly capture snapshot copies of source members. And they can still be used to manage local source member checkouts between libraries once you do implement Git. 

Sometimes it's easier for a development team to start with something like simple source checkout/checkin and creating snapshots prior to implementing Git for version control. These commands can still be used once Git has been implemented as well to checkout/checkin source between development and production libraries.

The nice thing is you have options. 

Visit: https://www.iforgit.com to request a demo or reach out if you have questions on iForGit commands work.

## Potential source member checkout workflow when changing source members

### Capture a source member snapshot right now - MBRARC
Nice way to prepare for a change and ensure you have a current source member archive snapshot.
- Take archive snapshot of member in prod before checkout.
- Optionally commit to Git at the same time.

### Check out a source member with MBRCHKO
Check out a copy of a source member from the production source to a selected developer library.
- Take archive snapshot of member in prod source file before checkout.
- Take archive snapshot copy of member in developer library if already there and replacing.
- Make copy of source member to developer library. Optionally overwrite development copy if already found.
- Optionally remove from production source file. 
```(Not usually recommended but can be used when you want to guarantee nobody else has the source member)```
- Optionally commit to Git during checkout.

### Check in a source member with MBRCHKI
Check in a copy of a source member from the developer source to the selected production library when work is done.
- Take archive snapshot of member in dev before checkin.
- Take archive snapshot copy of member in prod library if already there and replacing.
- Make copy of source member to prod from dev library. 
(Will need to overwrite prod when putting back)
- Optionally remove from development source.
```(Probably recommended when done with a source member and you don't want to leave the development version in dev library)```
- Optionally commit to Git after returned to production library so the new version gets captured right away to Git.

## The Simple Source Management CL command overviews

#### Source member archive snapshot - MBRARC
The simple source archive snapshot command **MBRARC** can be used to quickly grab a snapshot copy of any source member and place it into the source archive file before making changes or doing other work on the source. This is a nice way to capture a copy of an existing source member before making changes. Snapshot archive copies are auto-named (Mxxxxxxxxx) and created in the GITSRCARC source physical file located in the IFORGIT or other library. An audit log entry is also placed into the GITSRCARCP file in the IFORGIT library. The archive source member text also holds the original source member information.   

#### Source checkout - MBRCHKO
The simple source checkout command **MBRCHKO** can be used to check out and copy a source member from a production source location to a developer library. The original production source member can optionally be removed from the production source while being worked on in the developer library as well if desired to keep other developers from making changes to a source member while it's being worked on. A snapshot archive copy of the original source member is made prior to checkout. And if the destination source member is replaced during checkout an archive copy also gets snapshotted by default before checkout. Snapshot archive copies are auto-named (Mxxxxxxxxx) and created in the GITSRCARC source physical file located in the IFORGIT or other library. A snapshot audit log entry is also placed into the GITSRCARCP file in the IFORGIT library. The archive source member text also holds the original source member information.   

#### Source checkin - MBRCHKI
The simple source checkin command **MBRCHKI** can be used to check in and copy a source member from a development source location to the production library. The development source member can optionally be removed from the development source after being worked on in the developer library after it's been checked in to production if no further work will be done on the source. A snapshot of the development source member is made prior to checkin. And if the production source member is replaced during checkin it also gets snapshotted before checkin. Snapshot archive copies are auto-named (Mxxxxxxxxx) and created in the GITSRCARC source physical file located in the IFORGIT or other library. An audit log entry is also placed into the GITSRCARCP file in the IFORGIT library. The archive source member text also holds the original source member information.    

## iForGit Simple Source Management CL Commands

### MBRARC - Take source member archive snapshot to source archive file
This CL command can be used to quickly grab a snapshot copy of any source member and place it into the source archive source file IFORGIT/GITSRCARC or other custom archive source file using an automatically named source member.

This is a good way to quickly snapshot a source member without having to copy and rename it to something meaningful.  

Snapshot archive copies are auto-named (Mxxxxxxxxx) and created in the GITSRCARC source physical file located in the IFORGIT or other library. An audit log entry is also placed into the GITSRCARCP file in the IFORGIT library. The archive source member text also holds the original source member information.    

#### MBRARC usage examples  
The following example snapshots a source member named MYSOURCE1 to the IFORGIT/GITSRCARC table from QGPL/QRPGLESRC. The source member name in the archive is automatically created. The generated archive member name is shown on the command line after processing the archive snapshot.

``` 
IFORGIT/MBRARC SRCFILE(QGPL/QRPGLESRC)    
        SRCMBR(MYSOURCE1)          
        ARCSRCFILE(*DEFAULT)
        CMTBEFORE(*NO)     
        COMMITOPT(*COMMIT) 
        COMMENT(*DATEUSER) 
        CHKRCDLEN(*NO)           
```

#### MBRARC command parms  

**SRCFILE** - The source file to capture source member from. 

**SRCMBR** - The source member to capture to the archive source file. 

**ARCSRCFILE** - The archive source file to capture source member to. ```*DEFAULT``` captures the source members to the IFORGIT/GITSRCARC archive source file with a unique member name. Ex: ```M000000001```.   
The source file value can be changed if desired to place GITSRCARC in a different library by changing the ```DFTARCFILE``` and ```DFTARCLIB``` data area values and creating the new archive source file in the appropriate library via the CRTSRCPF command. 
❗The archive source file should be created with ```198``` column record length or more if possible to accomodate your longest source file members without truncation.

**CMTBEFORE** - Commit source member to its associated repo before making the snapshot copy of source member to the source physical file specified in ```ARCSRCFILE```.

**COMMITOPT** - Git commit option. Default: *COMMIT
 
Options
*COMMIT - Export source member to local git repository directory and commit to local repository in IFS. Use this if you are leaving git changes in the IFS or plan to push them to a remote repository later. This is the default option.
 
*COMMITSYNC - Export source member to local git repository directory and commit to local repository in IFS. Then pull and merge any remote changes and push them back to the repository. Use this option normally for a full git edit and version life-cycle where the local copies stay in sync with the remote repository at all times.
 
*COMMITPUSH - Export source member to local git repository directory and commit to local repository in IFS. Then push changes to remote repository. This option only pushes changes, but does not pull and merge remote changes with the local repository.
 
*GITADD - Export source member to local git repository directory and add/stage to the commit list in local IFS repository. Use this if you want to stage a file for a future commit that will happen later. Good for staging multiple files for a single commit later by the GITCMD CL command with a commit option. Example commit: GITCMD CMDOPTS('-commit -m "My Commit of Many Staged Files')    
 
*NOCOMMIT - Use this option if just simply exporting source member with no intent to commit to git immediately.

**COMMENT** -  Commit comment. Default: *DATEUSER
 
Enter a commit comment or special value.
 
*DATEUSER - Write date info and user ID into commit comment automatically.
                                                                  
 **CHKRCDLEN** - Make sure record length matches. Default - *NO     
 ``` This parm is not implemented yet, so don't use it currently. It will throw a non-implemented error.```

### MBRCHKO - Check out source member from production source location to developer library
This CL command can be used to make a copy of a production source member to a developer library for development.

A copy of the original source member is created in a developer library in the selected source physical file.  

Optionally the production source member can be removed from the original library location during development if you don't want anyone else using the source member while it's being edited.

#### MBRCHKO usage examples  
The following example checks out a source member named MBR001R from source file MYSOURCE1/QRPGLESRC to a developer source file: DEVSOURCE1/QRPGLESRC. Since ARCHIVE is set to *YES the source member is archived and the member name in the archive is automatically created. Since replace is *NO, the destination source member will not be replaced if it exists. And the production copy is not removed from its original location because RMVPRDCOPY is *NO.

 ```
 IFORGIT/MBRCHKO SRCFILE(MYSOURCE1/QRPGLESRC)         
                 SRCMBR(MBR001R)                         
                 TOSRCFILE(DEVSOURCE1/QRPGLESRC)       
                 TOSRCMBR(*SAME)                       
                 REPLACE(*NO)                          
                 SKIPEXIST(*NO)                        
                 RMVPRDCOPY(*NO)                       
                 ARCSRCFILE(*DEFAULT)                  
                 ARCHIVE(*YES)
                 CMTBEFORE(*NO)     
                 COMMITOPT(*COMMIT) 
                 COMMENT(*DATEUSER) 
                 CHKRCDLEN(*NO)                                 
```

#### MBRCHKO command parms  

**SRCFILE** - The source file to check out production source member from. 

**SRCMBR** - The source member name to check out. 

**TOSRCFILE** - The developer/development source file to copy source member to during checkout. This source file will usually be located in a develop library or shared development library. 

**TOSRCMBR** - The source member name when checked out. Usually this name should be *SAME or the same as the SRCMBR value unless you want to change the source member during checkout.

**REPLACE** - Replace the destination development source member if it exists.   
Should the command replace the destination development source member if it exists ?    
```*NO``` - Do not allow an existing destination source member to be overwritten. This will stop the check out if the destination member exists.   

```*YES``` - Replace the destination source member if it's already checked out to the developer location. This will overwrite the destination source member with the current copy from production. You can potentially lose changes in your development library. However an archive snapshot will be taken before replacement if the ARCHIVE parameter is set to *YES.

**SKIPEXIST** - Skip existing dev source mbrs.   
Should the command skip copying the destination development source member if it exists ?    

```*NO``` - Don't skip copying the source member. It must always be copied and/or replaced.

```*YES``` - Skip copying the production source member if it exists. This option allows you to complete the checkout process without actually copying the source member if it already exists in the developer or development library. This is good to use if you somehow already have a copy of the source in your dev library and perhaps want to get a snapshot of the prod version of the source and maybe you want to remove the prod version so it can't be accessed from the prod library until it's checked back in.

**RMVPRDCPY** - Remove source member from prod.  
Should the command remove the source member from the production source file and library after successfuly checked out to the developer library.  

```*NO``` - Don't remove the prod source member after checkout to dev location. This means multiple people can check out the same source member to work on it. However the source archive will make sure backup copies are captured in case of developer conflict during checkin.  

```*YES``` - Remove the source member from the prod source file after successful checkout. This means a developer can check out the master version of a source member and place it into the development library so they have it exclusively for editing until they check it back in to the source library. And the production member gets removed after a successfuly checkout copy.

**ARCHIVE** - Copy to archive source file 
Should an archive version of the prod and dev source members get created before checkout ? 

```*NO``` - Don't create an archive source copy before checkout.    
❗If you select this option, no archive copy of your source member gets created, so you have no source member backup.

```*YES``` - Create an archive source copy before checkout. If you select this option, an archive of an existing production and dev source member gets created for archive/backup purposes. 

**ARCSRCFILE** - The archive source file to capture source member to. ```*DEFAULT``` captures the source members to the IFORGIT/GITSRCARC archive source file with a unique member name. Ex: ```M000000001```.   
The source file value can be changed if desired to place GITSRCARC in a different library by changing the ```DFTARCFILE``` and ```DFTARCLIB``` data area values and creating the new archive source file in the appropriate library via the CRTSRCPF command. 
❗The archive source file should be created with ```198``` column record length or more if possible to accomodate your longest source file members without truncation.

**CMTBEFORE** - Commit from production source member to its associated repo before making the snapshot copy of source member to the source physical file specified in ```ARCSRCFILE``` and before copying to the developer checkout source member specified in the ```TOSRCFILE``` and ```TOSRCMBR``` parameters.

**COMMITOPT** - Git commit option. Default: *COMMIT
 
Options
*COMMIT - Export source member to local git repository directory and commit to local repository in IFS. Use this if you are leaving git changes in the IFS or plan to push them to a remote repository later. This is the default option.
 
*COMMITSYNC - Export source member to local git repository directory and commit to local repository in IFS. Then pull and merge any remote changes and push them back to the repository. Use this option normally for a full git edit and version life-cycle where the local copies stay in sync with the remote repository at all times.
 
*COMMITPUSH - Export source member to local git repository directory and commit to local repository in IFS. Then push changes to remote repository. This option only pushes changes, but does not pull and merge remote changes with the local repository.
 
*GITADD - Export source member to local git repository directory and add/stage to the commit list in local IFS repository. Use this if you want to stage a file for a future commit that will happen later. Good for staging multiple files for a single commit later by the GITCMD CL command with a commit option. Example commit: GITCMD CMDOPTS('-commit -m "My Commit of Many Staged Files')    
 
*NOCOMMIT - Use this option if just simply exporting source member with no intent to commit to git immediately.

**COMMENT** -  Commit comment. Default: *DATEUSER
 
Enter a commit comment or special value.
 
*DATEUSER - Write date info and user ID into commit comment automatically.
                                                                  
 **CHKRCDLEN** - Make sure record length matches. Default - *NO     
 ``` This parm is not implemented yet, so don't use it currently. It will throw a non-implemented error.```

### MBRCHKI - Check in source member from developer source location to production library
This CL command can be used to make a copy of a production source member to a developer library for development.

A copy of the original source member is created in a developer library in the selected source physical file. 

Optionally the production source member can be removed from the original library location during development if you don't want anyone else using the source member while it's being edited.

#### MBRCHKI usage examples  
The following example checks out a source member named MBR001R from source file DEVSOURCE1/QRPGLESRC to a production source file: MYSOURCE1/QRPGLESRC. Since ARCHIVE is set to *YES the source member is archived and the member name in the archive is automatically created. Since replace is *NO, the destination source member will not be replaced if it exists. And the develpoment copy is not removed from its location because RMVDEVCOPY is *NO.

 ```
IFORGIT/MBRCHKI SRCFILE(DEVSOURCE1/QRPGLESRC)  
                SRCMBR(MBR001R)                  
                TOSRCFILE(MYSOURCE1/QRPGLESRC)
                TOSRCMBR(*SAME)                
                REPLACE(*NO)                   
                RMVDEVCOPY(*NO)                
                ARCSRCFILE(*DEFAULT)           
                ARCHIVE(*YES)
                CMTAFTER(*NO)     
                COMMITOPT(*COMMIT) 
                COMMENT(*DATEUSER) 
                CHKRCDLEN(*NO)                                               
```

#### MBRCHKI command parms  

**SRCFILE** - The development source file to check in source member from. 

**SRCMBR** - The source member to check in. 

**TOSRCFILE** - The production source file to copy source member to during checkin. This source file will usually be located in a production library. 

**TOSRCMBR** - The source member name when checked in. Usually this name should be *SAME or the same as the SRCMBR value unless you want to change the source member during checkin.

**REPLACE** - Replace the destination production source member if it exists. 
Should the command replace the destination production source member if it exists ?    
```*NO``` - Do not allow an existing destination source member to be overwritten. This will stop the check out if the destination member exists.   

```*YES``` - Replace the destination source member in the production location. This will overwrite the destination production source member with the current copy from development. You can potentially lose changes in your production library.

**RMVDEVCPY** - Remove source member from development location.  
Should the command remove the source member from the development source file and library after successfuly checked in to the production library. 

```*NO``` - Don't remove the dev source member after checkin to prod location. 

```*YES``` - Remove the source member from the dev source file after successful checkin. 

**ARCHIVE** - Copy to archive source file 
Should an archive version of the prod and dev source members get created before checkin ? 

```*NO``` - Don't create an archive source copy before checkin.    
❗If you select this option, no archive copy of your source member gets created, so you have no source member backup.

```*YES``` - Create an archive source copy before checkin. If you select this option, an archive of an existing production and dev source member gets created for archive/backup purposes. 

**ARCSRCFILE** - The archive source file to capture source member to. ```*DEFAULT``` captures the source members to the IFORGIT/GITSRCARC archive source file with a unique member name. Ex: ```M000000001```.   
The source file value can be changed if desired to place GITSRCARC in a different library by changing the ```DFTARCFILE``` and ```DFTARCLIB``` data area values and creating the new archive source file in the appropriate library via the CRTSRCPF command. 
❗The archive source file should be created with ```198``` column record length or more if possible to accomodate your longest source file members without truncation.

**CMTAFTER** - Commit to production source member to its associated repo after making the snapshot copy of source member to the source physical file specified in ```ARCSRCFILE``` and before copying to the production checkin source member specified in the ```TOSRCFILE``` and ```TOSRCMBR``` parameters.

**COMMITOPT** - Git commit option. Default: *COMMIT
 
Options
*COMMIT - Export source member to local git repository directory and commit to local repository in IFS. Use this if you are leaving git changes in the IFS or plan to push them to a remote repository later. This is the default option.
 
*COMMITSYNC - Export source member to local git repository directory and commit to local repository in IFS. Then pull and merge any remote changes and push them back to the repository. Use this option normally for a full git edit and version life-cycle where the local copies stay in sync with the remote repository at all times.
 
*COMMITPUSH - Export source member to local git repository directory and commit to local repository in IFS. Then push changes to remote repository. This option only pushes changes, but does not pull and merge remote changes with the local repository.
 
*GITADD - Export source member to local git repository directory and add/stage to the commit list in local IFS repository. Use this if you want to stage a file for a future commit that will happen later. Good for staging multiple files for a single commit later by the GITCMD CL command with a commit option. Example commit: GITCMD CMDOPTS('-commit -m "My Commit of Many Staged Files')    
 
*NOCOMMIT - Use this option if just simply exporting source member with no intent to commit to git immediately.

**COMMENT** -  Commit comment. Default: *DATEUSER
 
Enter a commit comment or special value.
 
*DATEUSER - Write date info and user ID into commit comment automatically.
                                                                  
 **CHKRCDLEN** - Make sure record length matches. Default - *NO     
 ``` This parm is not implemented yet, so don't use it currently. It will throw a non-implemented error.```

## iForGit Simple Source Management Command PDM Options  
These options can be set up manually and are also shipped with iForGit in the file: ```IFORGIT/QAUOOPTGIT```

### Option CA - Simple source management source member archive snapshot    
Perform a source member archive/backup snapshot to archive source file.   

Command: ```IFORGIT/MBRARC SRCFILE(&L/&F) SRCMBR(&N) ARCSRCFILE(*DEFAULT)```   

### Option CO - Simple source management check out source member from production to development
Perform a source member snapshot and checkout from production source library to development library source member for development.   

Command: ```IFORGIT/MBRCHKO SRCFILE(&L/&F) SRCMBR(&N) TOSRCFILE(&L/&F) TOSRCMBR(&N) REPLACE(*NO) SKIPEXIST(*NO) RMVPRDCOPY(*NO)```      
### Option CI - Simple source management check in source from development to production   
Perform a source member snapshot and checkin from development source library to production library source member after changes have been completed.   

Command: ```IFORGIT/MBRCHKI SRCFILE(&L/&F) SRCMBR(&N) TOSRCFILE(&L/&F) TOSRCMBR(&N) REPLACE(*NO) RMVDEVCOPY(*NO)```   


