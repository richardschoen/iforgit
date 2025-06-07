# iForGit VS Code Actions for Managing Source with Git and iForGit   
These instructions can be used for creating custom VS Code actions that can be used with the iForGit CL commands to manage a git repository of source members from within RDi by using the custom User Actions.   

You can use these sample VS Code actions provided to commit source changes, retreive the most recent commit of a source member, check history via blame or log or checkout a copy of an old source version for review. 

**Note:** If you're using GitHub or another external web based source code provider, often custom user actions such as git log and git blame or checkout aren't needed from within VS Code because changes can be viewed in a web browser and copy/pasted from the web based user interface. But the VS Code actions can allow you to do all your source versioning and retrieval directly from within VS Code.

## One Time Set up IFORGITTMP library to receive temporary source members
iForGit uses a temporary library to hold results from git commands like: git log, git blame and git checkout. iForGit will auto-create a source file in the IFORGITTMP library to hold temporary git results and temporary checked out source members for each IBM i user profile.    

The temporary git results can be easily accessed from within the RDi Remote Explorer source member list by creating a user filter to the user specific source file in library IFORGITTMP.  You can manually set up the IFORGITTMP library if you like before creating user actions. Otherwise it will get auto-created by SRCTOGIT or LIBSRCEXP processing.    

### Create the IFORGITTMP library if not found (The library may have already been auto-created by the LIBSRCEXP and SRCTOGIT commands)
```CRTLIB LIB(IFORGITTMP) TEXT('iForGit Temp Work Library (Do Not Delete)')```       

**Note:** If the library already exists, nothing special is needed.    

### Create a named source physical file in IFORGITTMP for each user ID  
Create a named source physical file in library IFORGITTMP for each user ID that will be using iForGit with RDi (If it hasn't been auto-created by LIBSRCEXP or SRCTOGIT commands).    
 ```CRTSRCPF FILE(IFORGITTMP/RICHARD) RCDLEN(240) TEXT('iForGit Temp Source File (Do Not Delete)')```   

**Note:** If the source file for the user id already exists in library IFORGITTMP, nothing special is needed.    

### Create VS Code filter for IFORGITTMP library and user source file
As described above you will want to create a source member user filter to point to your user ID specific source file in library IFORGITTMP or display all source files if you want.

The following output source member names are created in the user temporary source file in IFORGITTMP by the appropriate user actions:     
```Git blame results``` for a source member after running Git Blame user action data gets written to source member - ```GITBLAME.TXT```  
```Git log results``` for a source member after running Git Log user action gets written to source member - ```GITLOG.TXT```   
```Git checkout results``` for a source member after running a Git checkout action get written to source member - ```GITCHKOUT.TXT```    
```Source member checkout``` - A temporary checked out source member is usually named after the ```original source member name```.    

## Creating or Editing VS Code user actions

Open the ```Work with Actions``` Dialog.   

You can create the following user actions.   

## iForGit User Actions
These are sample user actions that we provide for you to be able to work entirely in VS Code to commit source changes, check on source versions and retreive copies of older source members if needed from a git repository.    

### Commit source member to Git Repo-SRCTOGIT 
Commit the selected source member to a git repository using the SRCTOGIT CL command.  RDi will prompt the user for the SRCTOGIF CL command unless you uncheck the option to prompt first.    

If you are storing source in GitHub or some other remote repository, specify *COMMITSYNC for the COMMITOPT parameter.  If you are just storing changes in an IFS directory, you can leave the COMMITOPT value set to *COMMIT.   

Action Name: ```iForGit - Commit Source Member to Git Repo-(SRCTOGIT)```    

Command to run: ```? IFORGIT/SRCTOGIT SRCFILE(&OPENLIB/&OPENSPF) SRCMBR(&OPENMBR) SRCHEADER(*YES) SRCDATSEQ(*NO) REPLACE(*YES) EDITOPT(*NONE) VALIDREPO(*YES) IFSMKDIR(*YES) INITREPO(*YES) COMMITOPT(*COMMITSYNC) COMMENT(*DATEUSER)```   

Extensions:```GLOBAL```. Or you can limit to selected source member types like: RPG, CLP, etc.   

Type:```Member```   

Environment:```ILE```   

Refresh:```No```   

### Get Most Recent Source Member from Git-SRCFRMGIT
Get the most recently committed version of this source member from the associated git repository using the SRCFRMGIT CL command.  RDi will prompt the user for the CL command unless you uncheck the option to prompt first.    

**Note:** The existing source member in the regular source library will get overwritten with the source member from your Git repository. So be sure you are OK replacing the source member in the IBM i library with yiur last git committed version.    

Action Name: ```Restore Most Recent Source Member from Git-(SRCFRMGIT)```    

Command Type: ```Normal Command```    

Command: ```? IFORGIT/SRCFRMGIT IFSREPODIR(*LIBREPODTAARA) SRCFILE(&OPENLIB/&OPENSPF) SRCMBR(&OPENMBR) SRCTYPE(&EXT) SRCHEADER(*YES) SRCDATSEQ(*NO) REPLACE(*YES) EDITOPT(*NONE) VALIDREPO(*YES) COMMITOPT(*COMMITSYNC) COMMENT(*DATEUSER)```    

Extensions:```GLOBAL```. Or you can limit to selected source member types like: RPG, CLP, etc.   

Type:```Member```   

Environment:```ILE```   

Refresh:```No```   

### Git Log Member
Retrieve the git log information for a source member. The git log action lists version information for the selected source member to source member ```GITLOG.TXT``` in the user's named source file in library ```IFORGITTMP```.

Once retreived, you can open the GITLOG.TXT member, find the git version hash for a selected source commit entry and ```copy the git hash``` so it can be ```pasted``` into the source version hash parameter when you do a git checkout as listed below.   

Action Name: ```Git Log Member```    

Command: ```? IFORGIT/SRCGITCMD SRCFILE(&OPENLIB/&OPENSPF) SRCMBR(&OPENMBR) IFSREPODIR(*LIBREPODTAARA) SRCOPTION(*LOG) SRCHASH(*MOSTRECENT) DSPSTDOUT(*NO) DESTFILE(*IFORGITMP) IFORGITTMP(*LOG) WRITETOTMP(*YES) TMPDESTOPT(*IFORGITMP) TMPDESTUSR(&USERNAME)```    

Extensions:```GLOBAL```. Or you can limit to selected source member types like: RPG, CLP, etc.   

Type:```Member```   

Environment:```ILE```   

Refresh:```No```   

## Git Blame Member
Retrieve the git blame information for a source member. Git blame will list a source member contents along with all lines and change version information for each line to source member ```GITBLAME.TXT``` in the users's named source file in '''IFORGITTMP```.    

Once retreived, you can open the GITBLAME.TXT member, find the short (8 character) git version hash prefix for a selected source commit entry and ```copy the git hash``` so it can be ```pasted``` into the source version hash parameter when you do a git checkout as listed below.   

**Note:** In GITBLAME.TXT you will only have a partial 8 character hash version. In GITLOG.TXT you will have the long version of a source version hash. Both will work to be able to check out a source member version. The 8 character hash is just more convenient to copy/paste as needed. You can also just copy the first 8 characters from a long source hash and that will work as well when checking out and getting a source member version.    

Action Name: ```Git Blame Member```    

Command: ```? IFORGIT/SRCGITCMD SRCFILE(&OPENLIB/&OPENSPF) SRCMBR(&OPENMBR) IFSREPODIR(*LIBREPODTAARA) SRCOPTION(*BLAME) SRCHASH(*MOSTRECENT) DSPSTDOUT(*NO) DESTFILE(*IFORGITMP) IFORGITTMP(*BLAME) WRITETOTMP(*YES) TMPDESTOPT(*IFORGITMP) TMPDESTUSR(&USERNAME)```    

Extensions:```GLOBAL```. Or you can limit to selected source member types like: RPG, CLP, etc.   

Type:```Member```   

Environment:```ILE```   

Refresh:```No```   

## Git Checkout Selected Member
Checkout/get a copy of the selected source member verion from the git repository. You need to determine the version hash (long one or 8 character one) value by first doing a ```git blame``` or ```git Log``` operation, viewing the results as described above and copying the selected source version hash into the clipboard.      

When prompted to check out the selected source member, first paste the version hash into the ```source version hash``` parameter and then click OK to start the checkout. The selected source member will be checked out to the user's source file in ```IFORGITTMP```. The checked out source member name will match the original source member name unless you change the ```DESTMBR``` parameter to something else.  Sometimes you might find it useful to rename a source member when it's checked out out to ```IFORGITTMP```   

After the temporary source version member has been checked out, you can open the source member from the source file in ```IFORGITTMP``` and review the code or copy and paste source from the open member to the current source you're working on in your development IBM i environnment.     

**Note:** If you want to preserve the checked out source member for later use, it should be copied from the user source file in ```IFORGITTMP``` to another library.   

Action Name: ```Git Checkout Selected Member```    

Command: ```? IFORGIT/SRCGITCMD  SRCHASH(' ') SRCFILE(&OPENLIB/&OPENSPF) SRCMBR(&OPENMBR) IFSREPODIR(*LIBREPODTAARA) SRCOPTION(*CHECKOUT) DSPSTDOUT(*NO) DESTFILE(QTEMP/*IFORGITMP) DESTMBR(&OPENMBR) DESTOPT(*REPLACE) IFORGITTMP(GITCHKOUT) WRITETOTMP(*YES) TMPDESTOPT(*IFORGITMP) TMPDESTUSR(&USERNAME)```    

Extensions:```GLOBAL```. Or you can limit to selected source member types like: RPG, CLP, etc.   

Type:```Member```   

Environment:```ILE```   

Refresh:```No```   
