# iForGit Simple Source Management CL Commands
This document is a shortcut getting started document for using the simple source management commands in iForGit. The simple source managemenr commands can be used to do local source checkouts between libraries for development purposes with or without using Git commands. Sometimes it's easier for a development team to start with something like simple source checkout/checkin and creating snapshots prior to implementing Git for version control. 

#### Source member archive snapshot - MBRARC
The simple source archive snapshot command **MBRARC** can be used to quickly grab a snapshot copy of any source member and place it into the source archive file before making changes or doing other work on the source. This is a nice way to capture a copy of an existing source member before making changes. Snapshot archive copies are auto-named and created in the GITSRCARC source physical file located in the IFORGITDTA or other library.

#### Source checkout - MBRCHKO
The simple source checkout command **MBRCHKO** can be used to check out and copy a source member from a production source location to a developer library. The original production source member can optionally be removed from the production source while being worked on in the developer library as well if desired to keep other developers from making changes to a source member while it's being worked on. A snapshot of the original source member is made prior to checkout. And if the destination source member is replaced during checkout an archive copy gets snapshotted by default before checkout. Snapshot archive copies are auto-named and created in the GITSRCARC source physical file located in the IFORGITDTA or other library.

#### Source checkin - MBRCHKI
The simple source checkin command **MBRCHKI** can be used to check in and copy a source member from a development source location to the production library. The development source member can optionally be removed from the development source after being worked on in the developer library after it's been checked in to production if no further work will be done on the source. A snapshot of the developmet source member is made prior to checkin. And if the production source member is replaced during checkin it also gets snapshotted before checkin. Snapshot archive copies are auto-named and created in the GITSRCARC source physical file located in the IFORGITDTA or other library.

## iForgit Simple Source Management CL Commands

### MBRARC - Take source member archive snapshot to source archive file
This CL command can be used to quickly grab a snapshot copy of any source member and place it into the source archive files IFORGIT/GITSRCARC using an automatically named source member.

This is a good way to quickly snapshot a source member without having to copy and rename it to something meaningful.  

#### MBRARC usage examples  
The following example snapshots a source member named MYSOURCE1 to the IFORGIT/GITSRCARC table from QGPL/QRPGLESRC. The source member name in the archive is automatically created. 

``` 
IFORGIT/MBRARC SRCFILE(QGPL/QRPGLESRC)    
        SRCMBR(MYSOURCE1)          
        ARCSRCFILE(*DEFAULT)       
```

#### MBRARC command parms  

**SRCFILE** - The source file to capture source member from. 

**SRCMBR** - The source member to to capture to the archive IFORGIT/GITSRCARC source file. 

**ARCSRCFILE** - The archive source file to capture source member to. *DEFAULT captures the source members to the IFORGIT/GITSRCARC archive source file with a unique member name. Ex: ```M000000001```

### MBRCHKO - Check out source member from production source location to developer library
This CL command can be used to make a copy of a production source member to a developer library for development.

A copy of the original source member is created in a developer library in the selected source physical file. 

Optionally the production source member can be removed from the original library location during development if you don't want anyone else using the source member while it's being edited.

#### MBRCHKO usage examples  
The following example checks out a source member named MYSOURCE1 from QGPL/QRPGLESRC to a developer library:  the IFORGIT/GITSRCARC table from QGPL/QRPGLESRC. The source member name in the archive is automatically created. 

 ```
 IFORGIT/MBRCHKO SRCFILE(MYSOURCE1/QRPGLESRC)         
                 SRCMBR(HELLO)                         
                 TOSRCFILE(GITTEST123/QRPGLESRC)       
                 TOSRCMBR(HELLO)                       
                 REPLACE(*NO)                          
                 SKIPEXIST(*NO)                        
                 RMVPRDCOPY(*NO)                       
                 ARCSRCFILE(*DEFAULT)                  
                 ARCHIVE(*YES)                         
```

#### MBRCHKO command parms  

**SRCFILE** - The source file to check out source member from. 

**SRCMBR** - The source member to to check out. 

**TOSRCFILE** - The source file to copy source member to during checkout. This source file will usually be located in a develop library. 

**TOSRCMBR** - The source member name when checked out. Usually this name should be the same as the SRCMBR value. 

**REPLACE** - Replace the destination development source member if it exists. 
Should the command replace the destination development source member if it exists ?    
*NO - Do not allow an existing destination source member to be overwritten. This will stop the check out if the destination member exists.   

*YES - Replace the destination source member if it's already checked out to the developer location. This will overwrite the destination source member with the current copy from production. You can potentially lose changes in your development library.

**SKIPEXIST** - Skip existing dev source mbrs. 
Should the command skip copying the destination development source member if it exists ?    

*NO - Don't skip copying the source member. It must always be copied and/or replaced.

*YES - Skip copying the production source member if it exists. This option allows you to complete the checkout process without actually copying the source member if it already exists in the developer library. This is good to use if you somehow already have a copy of the source in your dev library and perhaps want to get a snapshot of the prod version of the source and maybe you want to remove the prod version so it can't be accessed from the prod library until it's checked back in.

**RMVPRDCPY** - Remove source member from prod.  
Should the command remove the source member from the production source file and library after successfuly checked out to the developer library. 

*NO - Don't remove the prod source member after checkout to dev location. This means multiple people can check out the same source member to work on it. However the soruce archive will make sure backup copies are captured in case of developer conflict during checkin.  

*YES - Remove the source member from the prod source file after successful checkout. This means each developer can check out the master version of a source member and place it into the development library until they check it back in to the source library. 

**ARCHIVE** - Copy to archive source file 
Should an archive version of the prod and dev source members get created before checkout ? 

*NO - Don't create an archive source copy before checkout.    
❗If you select this option, no archive copy of your source member gets created, so you have no source member backup.

*YES - Create an archive source copy before checkout. If you select this option, an archive of an existing production and dev source member gets created for archive/backup purposes. 

**ARCSRCFILE** - The archive source file to capture source member to. *DEFAULT captures the source members to the IFORGIT/GITSRCARC archive source file with a unique member name. Ex: ```M000000001```

### MBRCHKI - Check in source member from developer source location to production library
This CL command can be used to make a copy of a production source member to a developer library for development.

A copy of the original source member is created in a developer library in the selected source physical file. 

Optionally the production source member can be removed from the original library location during development if you don't want anyone else using the source member while it's being edited.

#### MBRCHKI usage examples  
The following example checks out a source member named MYSOURCE1 from QGPL/QRPGLESRC to a developer library:  the IFORGIT/GITSRCARC table from QGPL/QRPGLESRC. The source member name in the archive is automatically created. 

 ```
IFORGIT/MBRCHKI SRCFILE(MYSOURCE1/QRPGLESRC)  
                SRCMBR(HELLO)                  
                TOSRCFILE(QGPL/QRPGLESRC)
                TOSRCMBR(HELLO)                
                REPLACE(*NO)                   
                RMVDEVCOPY(*NO)                
                ARCSRCFILE(*DEFAULT)           
                ARCHIVE(*YES)                  
```

#### MBRCHKI command parms  

**SRCFILE** - The development source file to check in source member from. 

**SRCMBR** - The source member to to check in. 

**TOSRCFILE** - The source file to copy source member to during checkout. This source file will usually be located in a develop library. 

**TOSRCMBR** - The source member name when checked out. Usually this name should be the same as the SRCMBR value. 

**REPLACE** - Replace the destination development source member if it exists. 
Should the command replace the destination development source member if it exists ?    
*NO - Do not allow an existing destination source member to be overwritten. This will stop the check out if the destination member exists.   

*YES - Replace the destination source member if it's already checked out to the developer location. This will overwrite the destination source member with the current copy from production. You can potentially lose changes in your development library.

**SKIPEXIST** - Skip existing dev source mbrs. 
Should the command skip copying the destination development source member if it exists ?    

*NO - Don't skip copying the source member. It must always be copied and/or replaced.

*YES - Skip copying the production source member if it exists. This option allows you to complete the checkout process without actually copying the source member if it already exists in the developer library. This is good to use if you somehow already have a copy of the source in your dev library and perhaps want to get a snapshot of the prod version of the source and maybe you want to remove the prod version so it can't be accessed from the prod library until it's checked back in.

**RMVPRDCPY** - Remove source member from prod.  
Should the command remove the source member from the production source file and library after successfuly checked out to the developer library. 

*NO - Don't remove the prod source member after checkout to dev location. This means multiple people can check out the same source member to work on it. However the soruce archive will make sure backup copies are captured in case of developer conflict during checkin.  

*YES - Remove the source member from the prod source file after successful checkout. This means each developer can check out the master version of a source member and place it into the development library until they check it back in to the source library. 

**ARCHIVE** - Copy to archive source file 
Should an archive version of the prod and dev source members get created before checkout ? 

*NO - Don't create an archive source copy before checkout.    
❗If you select this option, no archive copy of your source member gets created, so you have no source member backup.

*YES - Create an archive source copy before checkout. If you select this option, an archive of an existing production and dev source member gets created for archive/backup purposes. 

**ARCSRCFILE** - The archive source file to capture source member to. *DEFAULT captures the source members to the IFORGIT/GITSRCARC archive source file with a unique member name. Ex: ```M000000001```



