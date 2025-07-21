# PDM User Defined Options for iForGit
The following are sample PDM User Defined Options that can be used with the iForGit commands to manage a git repository of source members.  

You can use the sample PDM option names provided or create your own as desired.  

# Exporting and Import Source Member Changes from a Git Repository 
The ```SRCTOGIT``` command is used to commit member changes to a git repository.  This is the primary command most developers will use to commit changes for a source member to the selected library's git repository from PDM, RDI or VS Code. 

The ```SRCFRMGIT``` command can get back the most recent comcmint from a repository.  

## Option GE - Export Source Member to Git 
Use this option to send and commit current source member version to the git repository.

Option *COMMIT will just commit to the IFS repository.  

Option *COMMITSYNC will commit to the IFS repository and push changes to your remote git server is configured.  
                                                                                
```
IFORGIT/SRCTOGIT SRCFILE(&L/&F) SRCMBR(&N) SRCHEADER(*YES) SRCDATSEQ(*NO) REPLACE(*YES)  
EDITOPT(*NONE) VALIDREPO(*YES) IFSMKDIR(*YES) INITREPO(*YES) COMMITOPT(*COMMIT) COMMENT(*DATEUSER)  
```

## Option GI - Import Source Member from Git Repository
Use this option to import most recent commit back to the library source member and overlay the existing source member. It's a great way to recover an entire source member if something was messed up during editing.   

Note: Use the ```SRCGITCMD``` command with the *CHECKOUT option to  check out a specific source member version commit based on its source hash instead of just grabbing the most reent version.  

```
IFORGIT/SRCFRMGIT IFSREPODIR(*LIBREPODTAARA) FROMIFSFIL(*LIBFILEPATH) SRCFILE(&L/&F) SRCMBR(&N)   
SRCTYPE('&T') SRCDATSEQ(*NO) VALIDREPO(*YES) COMMITOPT(*COMMIT)         
```

# Granular Git Member Processing with CL command SRCGITCMD
The ```SRCGITCMD``` command can be used to view or check out specific old versions of a source member using the the SRCGITCMD CL command itself in a process or interactively as a PDM option or RDI user action. Perform tasks such as Viewing Git History, Performing Diff or Blame operations and Checking Out/Restoring an Old Versions to a library for viewing or editing.

## Option - GL - Perform a Git Log on Source Member
Perform a git log command to see how many times a member has been committed and determine the git commit hash for checking out a selected member version from your git repository with the *BLAME option.   
    
Once you determine the hash version you want for a source member, just copy to the clipboard and paste it into the appropriate prompt for Git Checkout, etc.

Command: ```IFORGIT/SRCGITCMD SRCFILE(&L/&F) SRCMBR(&N) IFSREPODIR(*LIBREPODTAARA) SRCOPTION(*LOG) DSPSTDOUT(*YES)```

## Option GC - Perform Git Checkout and View of Source Member
Perform a ```git checkout``` command to check out a selected older version of a source member to a selected source physical file for viewing or working with it via PDM or RDI. By default the source member gets checked out to file: ```QTEMP/TMPSOURCE``` member: ```TMPSOURCE``` for being viewed via SEU and is displayed via SEU after checkout.   

If you want to select a specific git hash to check out, run the GL option first to determine which hash version you want. Or determine the hash from your git repository and then prompt for the SRCGITCOMD using F4 to enter the specific hash or partial hash to retrieve from the repo. Blanks in SRCHASH will get the most recent commit version and display it.   

Note: This command can also be used to checkout the selected version and restore to the original source location or another specific work library iF the ```DESTFILE/DESTMBR``` parameters are specified. 

Command: ```IFORGIT/SRCGITCMD SRCFILE(&L/&F) SRCMBR(&N) IFSREPODIR(*LIBREPODTAARA) SRCOPTION(*CHECKOUT) SRCHASH(' ') DSPSTDOUT(*NO) DSPCHKOUT(*BROWSE)```

## Option GB - Perform Git Blame on Source Maember
Perform a git blame command to show a consolidated view of the selected source member commits to determine what older version you may want to view or restore. Date info and the user name who committed the changes for each version is listed along with the source hash id. 
                                                                                
Command: ```IFORGIT/SRCGITCMD SRCFILE(&L/&F) SRCMBR(&N) IFSREPODIR(*LIBREPODTAARA) SRCOPTION(*BLAME) SRCHASH(*MOSTRECENT) DSPSTDOUT(*YES)```

## Option GD - Perform Git Diff on Selected Version
Perform a git diff command for a selected hash to do a diff based on the most recent version compared with the selected hash version. You must specify a member commit hash value or *MOSTRECENT in the SRCHASH parameter to show the most recent version file version.  
                                                                                
Command: ```IFORGIT/SRCGITCMD SRCFILE(&L/&F) SRCMBR(&N) IFSREPODIR(*LIBREPODTAARA) SRCOPTION(*DIFF) SRCHASH(*MOSTRECENT) DSPSTDOUT(*YES)```

## Option GS - Perform Git Show on a Member
Perform a git show command for a selected hash to show that version of the source member. *MOSTRECENT for the SRCHASH will show the most recent commit.

Command: ```IFORGIT/SRCGITCMD SRCFILE(&L/&F) SRCMBR(&N) IFSREPODIR(*LIBREPODTAARA) SRCHASH(*MOSTRECENT) SRCOPTION(*SHOW) DSPSTDOUT(*YES)```

## Option GV - Work With Git Versions for Source Member   
Interactively list all versions of a selected source member using a 5250 member list application. Display the commit comments, dates and long and short 8 character version hash. The version hash is essentially the version number in a unique character format.    

From the version list screen, the user can View the version, Browse the version or Restore the version to library: ```IFORGITTMP/USERID``` 
Then they can Work with temporary restored source members in ```IFORGITTMP/USERID```.

Command: ```IFORGIT/SRCGITVER SRCFILE(&L/&F) SRCMBR(&N) IFSREPODIR(*LIBREPODTAARA)```

# Simple Source Management Commands  

## Option CA - Simple source management source member archive snapshot    
Perform a source member archive/backup snapshot to archive source file.   

Command: ```IFORGIT/MBRARC SRCFILE(&L/&F) SRCMBR(&N) ARCSRCFILE(*DEFAULT)```   

## Option CO - Simple source management check out source member from production to development
Perform a source member snapshot and checkout from production source library to development library source member for development.   

Command: ```IFORGIT/MBRCHKO SRCFILE(&L/&F) SRCMBR(&N) TOSRCFILE(&L/&F) TOSRCMBR(&N) REPLACE(*NO) SKIPEXIST(*NO) RMVPRDCOPY(*NO)```      

## Option CI - Simple source management check in source from development to production   
Perform a source member snapshot and checkin from development source library to production library source member after changes have been completed.   

Command: ```IFORGIT/MBRCHKI SRCFILE(&L/&F) SRCMBR(&N) TOSRCFILE(&L/&F) TOSRCMBR(&N) REPLACE(*NO) RMVDEVCOPY(*NO)```   


