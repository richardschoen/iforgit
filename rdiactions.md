# iForGit RDi User Actions for Managing Source with Git and iForGit   
These instructions can be used for creating custom RDi user actions that can be used with the iForGit CL commands to manage a git repository of source members from within RDi by using the custom User Actions.   

You can use these sample RDI actions provided to commit source changes, retreive the most recent commit of a source member, check history via blame or log or checkout a copy of an old source version for review. 

These actions should also work with VS Code as well. Will do a VS Code specific article soon.   

**Note: If you're using GitHub or another external web based source code provider, often custom user actions such as git log and git blame or checkout aren't needed from within RDi because changes can be viewed in a web browser and copy/pasted from the web based user interface. But the RDi actions can allow you to do all your source versioning and retrieval directly from within RDi.

## One Time Set up IFORGITTMP library to receive temporary source members
iForGit uses a temporary library to hold results from git commands like: git log, git blame and git checkout. iForGit will auto-create a source file in the IFORGITTMP library to hold temporary git results and temporary checked out source members for each IBM i user profile.    

The temprary git results can be easily accessed from within the RDi Remote Explorer source member list by creating a user filter to the user specific source file in library IFORGITTMP.  You can manually set up the IFORGITTMP library if you like before creating user actions. Otherwise it will get auto-created by SRCTOGIT or LIBSRCEXP processing.    

### Create the IFORGITTMP library if not found (The library may have already been auto-created by the LIBSRCEXP and SRCTOGIT commands)
```CRTLIB LIB(IFORGITTMP) TEXT('iForGit Temp Work Library (Do Not Delete)')```       

**Note: If the library already exists, nothing special is needed.    

### Create a named source physical file in IFORGITTMP for each user ID  
Create a named source physical file in library IFORGITTMP for each user ID that will be using iForGit with RDi (If it hasn't been auto-created by LIBSRCEXP or SRCTOGIT commands).    
 ```CRTSRCPF FILE(IFORGITTMP/RICHARD) RCDLEN(240) TEXT('iForGit Temp Source File (Do Not Delete)')```   

**Note: If the source file for the user id already exists in library IFORGITTMP, nothing special is needed.    

### Create RDi source member filter for IFORGITTMP library and user source file
As described above you will want to create a source member user filter to point to your user ID specific source file in library IFORGITTMP.   

Click on Work with members to create a new filter, set library to IFORGITTMP and File to your user ID. Then click Next and Finish.    
![image](https://github.com/user-attachments/assets/8dc73e00-b587-4139-9b93-324cd39895b9)

The IFORGITTMP filter is where you will go to view temporary information for iForGit source    
![image](https://github.com/user-attachments/assets/b532f191-4e85-47d4-8970-3cb129ed364b)   


The following source member names are created in the user temporary source file in IFORGITTMP by the appropriate user actions:     
```Git blame results``` for a source member after running Git Blame user action get written to  - ```GITBLAME.TXT```  
```Git log results``` for a source member after running Git Log user action get written to - ```GITLOG.TXT```   
```Git checkout results``` for a source member after running a Git checkout action get written to - ```GITCHKOUT.TXT```    
```Source member checkout``` - A temporary checked out source member is usually named after the ```original source member name```.    

## Creating or Editing RDi user actions

Right-click on a member from the member list, select User Actions, the Work with User Actions   
![image](https://github.com/user-attachments/assets/96ea76c5-1fe6-4b82-b766-92f9ae8c3490)

Example member user action. Create or edit a user action from here and save/apply changes. 
![image](https://github.com/user-attachments/assets/b3e0d98b-17f4-4b9b-a4f4-930f3937be7a)

## iForGit User Actions
These are sample user actions that we provide for you to be able to work entirely in RDi to commit source changes, check on source versions and retreive copies of older source members if needed from a git repository.    

### Commit source member to Git Repo-SRCTOGIT 
Commit the selected source member to a git repository using the SRCTOGIT CL command.  RDi will prompt the user for the SRCTOGIF CL command unless you uncheck the option to prompt first.    

If you are storing source in GitHub or some other remote repository, specify *COMMITSYNC for the COMMITOPT parameter.  If you are just storing changes in an IFS directory, you can leave the COMMITOPT value set to *COMMIT.   

Action Name: ```Commit Source Member to Git Repo-SRCTOGIT```    

Comment: ```Export and commit source member to git repository```   

Command Type: ```Normal Command```   

Command: ```IFORGIT/SRCTOGIT SRCFILE(&L/&F) SRCMBR(&N) IFSREPODIR(*LIBREPODTAARA) SRCHEADER(*YES) SRCDATSEQ(*NO) REPLACE(*YES) EDITOPT(*NONE) VALIDREPO(*YES) IFSMKDIR(*YES) INITREPO(*YES) COMMITOPT(*COMMIT) COMMENT(*DATEUSER)```    

Prompt first - ```Check/enable this option to prompt before running action CL command```   

Show action - ```Check/enable this option to make sure action is not hidden.```    

Defined Types = ```ALL``` unless you want to limit to only selected source member types.   

Selected Types = ```ALL``` unless you want to limit to only selected source member types.    

### Get Most Recent Source Member from Git-SRCFRMGIT
Get the most recently committed version of this source member from the associated git repository using the SRCFRMGIT CL command.  RDi will prompt the user for the CL command unless you uncheck the option to prompt first.    

**Note: The existing source member in the regular source library will get overwritten with the source member from your Git repository. So be sure you are OK replacing the source member in the IBM i library with yiur last git committed version.    

Action Name: ```Get Most Recent Source Member from Git-SRCFRMGIT```    

Comment: ```Get and import most recent version of source from git repository```   

Command Type: ```Normal Command```    

Command: ```IFORGIT/SRCFRMGIT IFSREPODIR(*LIBREPODTAARA) SRCFILE(&L/&F) SRCMBR(&N) SRCTYPE(&T) SRCHEADER(*YES) SRCDATSEQ(*NO) REPLACE(*YES) EDITOPT(*NONE) VALIDREPO(*YES) COMMITOPT(*COMMIT) COMMENT(*DATEUSER)```    

Prompt first - ```Check/enable this option to prompt before running action CL command```

Show action - ```Check/enable this option to make sure action is not hidden.```

Defined Types = ```ALL``` unless you want to limit to only selected source member types.   

Selected Types = ```ALL``` unless you want to limit to only selected source member types.    

### Git Log Member
Retrieve the git log information for a source member. The git log action lists version information for the selected source member to source member ```GITLOG.TXT``` in the user's named source file in library ```IFORGITTMP```.

Once retreived, you can open the GITLOG.TXT member, find the git version hash for a selected source commit entry and ```copy the git hash``` so it can be ```pasted``` into the source version hash parameter when you do a git checkout as listed below.   

Action Name: ```Git Log Member```    

Comment: ```Retrieve git log info for source member to GITLOG.TXT in IFORGITTMP```   

Command Type: ```Normal Command```    

Command: ```IFORGIT/SRCGITCMD SRCFILE(&L/&F) SRCMBR(&N) IFSREPODIR(*LIBREPODTAARA) SRCOPTION(*LOG) SRCHASH(*MOSTRECENT) DSPSTDOUT(*NO) DESTFILE(*IFORGITMP) IFORGITTMP(*LOG) WRITETOTMP(*YES) TMPDESTOPT(*IFORGITMP) TMPDESTUSR(&U)```    

Prompt first - ```Check/enable this option to prompt before running action CL command```

Show action - ```Check/enable this option to make sure action is not hidden.```

Defined Types = ```ALL``` unless you want to limit to only selected source member types.   

Selected Types = ```ALL``` unless you want to limit to only selected source member types.    

## Git Blame Member
Retrieve the git blame information for a source member. Git blame will list a source member contents along with all lines and change version information for each line to source member ```GITBLAME.TXT``` in the users's named source file in '''IFORGITTMP```.    

Once retreived, you can open the GITBLAME.TXT member, find the short (8 character) git version hash prefix for a selected source commit entry and ```copy the git hash``` so it can be ```pasted``` into the source version hash parameter when you do a git checkout as listed below.   

**Note: In GITBLAME.TXT you will only have a partial 8 character hash version. In GITLOG.TXT you will have the long version of a source version hash. Both will work to be able to check out a source member version. The 8 character hash is just more convenient to copy/paste as needed. You can also just copy the first 8 characters from a long source hash and that will work as well when checking out and getting a source member version.    

Action Name: ```Git Blame Member```    

Comment: ```Retrieve git blame info for source member to GITBLAME.TXT in IFORGITTMP```   

Command Type: ```Normal Command```    

Command: ```IFORGIT/SRCGITCMD SRCFILE(&L/&F) SRCMBR(&N) IFSREPODIR(*LIBREPODTAARA) SRCOPTION(*BLAME) SRCHASH(*MOSTRECENT) DSPSTDOUT(*NO) DESTFILE(*IFORGITMP) IFORGITTMP(*BLAME) WRITETOTMP(*YES) TMPDESTOPT(*IFORGITMP) TMPDESTUSR(&U)```    

Prompt first - ```Check/enable this option to prompt before running action CL command```

Show action - ```Check/enable this option to make sure action is not hidden.```

Defined Types = ```ALL``` unless you want to limit to only selected source member types.   

Selected Types = ```ALL``` unless you want to limit to only selected source member types.    

## Git Checkout Selected Member
Checkout/get a copy of the selected source member verion from the git repository. You need to determine the version hash (long one or 8 character one) value by first doing a ```git blame``` or ```git Log``` operation, viewing the results as described above and copying the selected source version hash into the clipboard.      

When prompted to check out the selected source member, first paste the version hash into the ```source version hash``` parameter and then click OK to start the checkout. The selected source member will be checked out to the user's source file in ```IFORGITTMP```. The checked out source member name will match the original source member name unless you change the ```DESTMBR``` parameter to something else.  Sometimes you might find it useful to rename a source member when it's checked out out to ```IFORGITTMP```   

After the temporary source version member has been checked out, you can open the source member from the source file in ```IFORGITTMP``` and review the code or copy and paste source from the open member to the current source you're working on in your development IBM i environnment.     

Action Name: ```Git Checkout Selected Member```    

Comment: ```Check out selected version of source member to IFORGITTMP library```   

Command Type: ```Normal Command```    

Command: ```IFORGIT/SRCGITCMD SRCFILE(&L/&F) SRCMBR(&N) IFSREPODIR(*LIBREPODTAARA) SRCOPTION(*CHECKOUT) SRCHASH(' ') DSPSTDOUT(*NO) DESTFILE(QTEMP/*IFORGITMP) DESTMBR(&N) DESTOPT(*REPLACE) IFORGITTMP(GITCHKOUT) WRITETOTMP(*YES) TMPDESTOPT(*IFORGITMP) TMPDESTUSR(&U)```    

Prompt first - ```Check/enable this option to prompt before running action CL command```

Show action - ```Check/enable this option to make sure action is not hidden.```

Defined Types = ```ALL``` unless you want to limit to only selected source member types.   

Selected Types = ```ALL``` unless you want to limit to only selected source member types.    
