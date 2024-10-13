# iForGit RDi User Actions for Managing Source with Git and iForGit   
Listed below are instructions for creating custom RDi user actions that can be used with the iForGit commands to manage a git repository of source members from within RDi by using custom User Actions.   

You can use these sample RDI actions provided to commit source changes, check history or retrieve a copy of an old source version. 

These actions should also work with VS Code as well. Will do a VS Code specific article soon.   

## Set up IFORGITTMP library to receive temporary source members
iForGit uses a temporary library to hold results from git commands like: git log, git blame and git checkout. iForGit will auto-create a source file in the IFORGITTMP library to hold temporary git results and temporary checked out source members for each IBM i user profile. The results can then be easily accessed from within the RDi Remote Explorer source member list by creating a user filter to the user specific source file in library IFORGITTMP.  You can manually set up the IFORGITTMP library if you like before creating user actions. Otherwise it will get auto-created by SRCTOGIT or LIBSRCEXP processing.   

### Create the IFORGITTMP library if not found (The library may have already been auto-created by the SRCTOGIT commands)
```CRTLIB LIB(IFORGITTMP) TEXT('iForGit Temp Work Library (Do Not Delete)')```       

### Create a named source physical file in IFORGITTMP for each user ID  
Create a named source physical file in library IFORGITTMP for each user ID that will be using iForGit with RDi (If it hasn't been auto-created by SRCTOGIT).
 ```CRTSRCPF FILE(IFORGITTMP/RICHARD) RCDLEN(240) TEXT('iForGit Temp Source File (Do Not Delete)')```                                          
### Create RDi source member filter for selected library:
As described above you will want to create a source member user filter to point to your user ID specific source file in library IFORGITTMP.   

Click on Work with members to create a new filter, set library to IFORGITTMP and File to your user ID. Then click Next and Finish.    
![image](https://github.com/user-attachments/assets/8dc73e00-b587-4139-9b93-324cd39895b9)

The IFORGITTMP filter is where you will go to view temporary information for iForGit source    
![image](https://github.com/user-attachments/assets/b532f191-4e85-47d4-8970-3cb129ed364b)

The following source members will get created in IFORGITTMP by the appropriate user actions:     
Git blame results for a source member after running Git Blame user action - ```gitblame.txt```  
Git log results for a source member after running Git Log user action - ```gitlog.txt```   
Git checkout results for a source member after running a Git checkout action - ```gitchkout.txt```    
Source member - Temporary checked out source members.    

## Creating or Editing RDi user actions

Right-click on a member from the member list, select User Actions, the Work with User Actions   
![image](https://github.com/user-attachments/assets/96ea76c5-1fe6-4b82-b766-92f9ae8c3490)

Example member user action   
![image](https://github.com/user-attachments/assets/b3e0d98b-17f4-4b9b-a4f4-930f3937be7a)

## iForGit User Actions

### Commit source member to Git Repo-SRCTOGIT 
Commit the selected source member to a git repository using the SRCTOGIT CL command.  RDI will prompt the user for the CL command unless you uncheck the option to prompt first. 

Action Name: ```Commit Source Member to Git Repo-SRCTOGIT```    

Comment: ```Export source to git repository```   

Command Type: ```Normal Command```   

Command: ```IFORGIT/SRCTOGIT SRCFILE(&L/&F) SRCMBR(&N) IFSREPODIR(*LIBREPODTAARA) SRCHEADER(*YES) SRCDATSEQ(*NO) REPLACE(*YES) EDITOPT(*NONE) VALIDREPO(*YES) IFSMKDIR(*YES) INITREPO(*YES) COMMITOPT(*COMMIT) COMMENT(*DATEUSER)```    

Prompt first - ```Check/enable this option to prompt before running action CL command```   

Show action - ```Check/enable this option to make sure action is not hidden.```    

Defined Types = ```ALL``` unless you want to limit to only selected source member types.   

Selected Types = ```ALL``` unless you want to limit to only selected source member types.    


### Get Most Recent Source Member from Git-SRCFRMGIT
Get the most recently committed version of this source member from the associated git repository using the SRCFRMGIT CL command.  RDI will prompt the user for the CL command unless you uncheck the option to prompt first. 

Action Name: ```Get Most Recent Source Member from Git-SRCFRMGIT```    

Comment: ```Import source from git repository```   

Command Type: ```Normal Command```    

Command: ```IFORGIT/SRCFRMGIT IFSREPODIR(*LIBREPODTAARA) SRCFILE(&L/&F) SRCMBR(&N) SRCTYPE(&T) SRCHEADER(*YES) SRCDATSEQ(*NO) REPLACE(*YES) EDITOPT(*NONE) VALIDREPO(*YES) COMMITOPT(*COMMIT) COMMENT(*DATEUSER)```    

Prompt first - ```Check/enable this option to prompt before running action CL command```

Show action - ```Check/enable this option to make sure action is not hidden.```

Defined Types = ```ALL``` unless you want to limit to only selected source member types.   

Selected Types = ```ALL``` unless you want to limit to only selected source member types.    

### Git Log Member
Retrieve the git log information for a source member. that lists version information for the selected source member to the user's named source file in library '''IFORGITTMP.  Source member is: GITLOG.TXT

Action Name: ```Git Log Member```    

Comment: ```Retrieve Git Log Info for Source Member```   

Command Type: ```Normal Command```    

Command: ```IFORGIT/SRCGITCMD SRCFILE(&L/&F) SRCMBR(&N) IFSREPODIR(*LIBREPODTAARA) SRCOPTION(*LOG) SRCHASH(*MOSTRECENT) DSPSTDOUT(*NO) DESTFILE(*IFORGITMP) IFORGITTMP(*LOG) WRITETOTMP(*YES) TMPDESTOPT(*IFORGITMP) TMPDESTUSR(&U)```    

Prompt first - ```Check/enable this option to prompt before running action CL command```

Show action - ```Check/enable this option to make sure action is not hidden.```

Defined Types = ```ALL``` unless you want to limit to only selected source member types.   

Selected Types = ```ALL``` unless you want to limit to only selected source member types.    

## Git Blame Member
Retrieve the git blame information for a source member. Git blame will list a source member contents along with all lines and change version information for each line to a source member in '''IFORGITTMP.  Temporary source member is: GITBLAME.TXT

Action Name: ```Git Blame Member```    

Comment: ```Retrieve Git Blame Info for Source Member```   

Command Type: ```Normal Command```    

Command: ```IFORGIT/SRCGITCMD SRCFILE(&L/&F) SRCMBR(&N) IFSREPODIR(*LIBREPODTAARA) SRCOPTION(*BLAME) SRCHASH(*MOSTRECENT) DSPSTDOUT(*NO) DESTFILE(*IFORGITMP) IFORGITTMP(*BLAME) WRITETOTMP(*YES) TMPDESTOPT(*IFORGITMP) TMPDESTUSR(&U)```    

Prompt first - ```Check/enable this option to prompt before running action CL command```

Show action - ```Check/enable this option to make sure action is not hidden.```

Defined Types = ```ALL``` unless you want to limit to only selected source member types.   

Selected Types = ```ALL``` unless you want to limit to only selected source member types.    

## Git Checkout Selected Member
Checkout/get a copy of the selected source member verion from git repository. You need to determine the version hash value by first doing a Git Blame or Git Log operation and viewing the results.    

The selected source member will be checked out to the user source file in ```IFORGITTMP```. Temporary source member name will match the original source member name unless you change the DESTMBR parameter.     

Action Name: ```Git Checkout Selected Member```    

Comment: ```Checkout selected version for Source Member```   

Command Type: ```Normal Command```    

Command: ```IFORGIT/SRCGITCMD SRCFILE(&L/&F) SRCMBR(&N) IFSREPODIR(*LIBREPODTAARA) SRCOPTION(*CHECKOUT) SRCHASH(' ') DSPSTDOUT(*NO) DESTFILE(QTEMP/*IFORGITMP) DESTMBR(&N) DESTOPT(*REPLACE) IFORGITTMP(GITCHKOUT) WRITETOTMP(*YES) TMPDESTOPT(*IFORGITMP) TMPDESTUSR(&U)```    

Prompt first - ```Check/enable this option to prompt before running action CL command```

Show action - ```Check/enable this option to make sure action is not hidden.```

Defined Types = ```ALL``` unless you want to limit to only selected source member types.   

Selected Types = ```ALL``` unless you want to limit to only selected source member types.    
