# RDI User Actions for Managing Source with Git and iForGit   
The following are sample RDI actions that can be used with the iForGit commands to manage a git repository of source members from RDI.

You can use these sample RDI actions provided or create your own as desired.  

## Commit source member to Git Repo-SRCTOGIT 
Commit the selected source member to a git repository using the SRCTOGIT CL command.  RDI will prompt the user for the CL command unless you uncheck the option to prompt first. 

Action Name: ```Commit Source Member to Git Repo-SRCTOGIT```    

Comment: ```Export source to git repository```   

Command: ```IFORGIT/SRCTOGIT SRCFILE(&L/&F) SRCMBR(&N) IFSREPODIR(*LIBREPODTAARA) SRCHEADER(*YES) SRCDATSEQ(*NO) REPLACE(*YES) EDITOPT(*NONE) VALIDREPO(*YES) IFSMKDIR(*YES) INITREPO(*YES) COMMITOPT(*COMMIT) COMMENT(*DATEUSER)```    

Prompt first - ```Check/enable this option to prompt before running action CL command```

Show action - ```Check/enable this option to make sure action is not hidden.```

Defined Types = ```ALL``` unless you want to limit to only selected source member types.   


## Get Most Recent Source Member from Git-SRCFRMGIT
Get the most recently committed version of this source member from the associated git repository using the SRCFRMGIT CL command.  RDI will prompt the user for the CL command unless you uncheck the option to prompt first. 

Action Name: ```Get Most Recent Source Member from Git-SRCFRMGIT```    

Comment: ```Import source from git repository```   

Command: ```IFORGIT/SRCFRMGIT IFSREPODIR(*LIBREPODTAARA) SRCFILE(&L/&F) SRCMBR(&N) SRCTYPE(&T) SRCHEADER(*YES) SRCDATSEQ(*NO) REPLACE(*YES) EDITOPT(*NONE) VALIDREPO(*YES) COMMITOPT(*COMMIT) COMMENT(*DATEUSER)```    

Prompt first - ```Check/enable this option to prompt before running action CL command```

Show action - ```Check/enable this option to make sure action is not hidden.```

Defined Types = ```ALL``` unless you want to limit to only selected source member types.   

## Git Log Member
Retrieve the git log information that lists version information for the selected source member to the user's named source file in library '''IFORGITTMP.  Source member is: GITLOG.TXT
IFORGIT/SRCGITCMD SRCFILE(&L/&F) SRCMBR(&N) IFSREPODIR(*LIBREPODTAARA) SRCOPTION(*LOG) SRCHASH(*MOSTRECENT) DSPSTDOUT(*NO) DESTFILE(*IFORGITMP) IFORGITTMP(*LOG) WRITETOTMP(*YES) TMPDESTOPT(*IFORGITMP) TMPDESTUSR(&U)

## Git Blame Member
IFORGIT/SRCGITCMD SRCFILE(&L/&F) SRCMBR(&N) IFSREPODIR(*LIBREPODTAARA) SRCOPTION(*BLAME) SRCHASH(*MOSTRECENT) DSPSTDOUT(*NO) DESTFILE(*IFORGITMP) IFORGITTMP(*BLAME) WRITETOTMP(*YES) TMPDESTOPT(*IFORGITMP) TMPDESTUSR(&U)

## Git Checkout Selected Member
IFORGIT/SRCGITCMD SRCFILE(&L/&F) SRCMBR(&N) IFSREPODIR(*LIBREPODTAARA) SRCOPTION(*CHECKOUT) SRCHASH(' ') DSPSTDOUT(*NO) DESTFILE(QTEMP/*IFORGITMP) DESTMBR(&N) DESTOPT(*REPLACE) IFORGITTMP(GITCHKOUT) WRITETOTMP(*YES) TMPDESTOPT(*IFORGITMP) TMPDESTUSR(&U)

# Set up IFORGITTMP library to receive temporary source members
You can manually set up the IFORGITTMP library if you like. Otherwise it will get auto-created by SRCTOGIT or LIBSRCEXP processing.   

 ### Create the IFORGITTMP library if not found (The library may have already been auto-created by the SRCTOGIT commands)
 CRTLIB LIB(IFORGITTMP) TEXT('iForGit Temp Work Library (Do Not Delete)')    

 ### Create named source physical file in IFORGITTMP for each user ID that will use iForGit (If it hasn't been auto-created by SRCTOGIT)
 ```CRTSRCPF FILE(IFORGITTMP/RICHARD) RCDLEN(240) TEXT('iForGit Temp Source File (Do Not Delete)')```   
                                                                          

## Create source member filter for selected library:




