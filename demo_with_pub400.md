# Demo iForGit Source File Management with a PUB400 Account
You can demo the iForGit software for managing IBM i source members in git by using a PUB400 user account and a local PUB400 IFS based git repository in your home directory on PUB400.    

This allows you to test the iForGit functionality without the set up of a GitHub or other external repository first.  

You can set up a PUB400 account here:   
https://pub400.com

For demoing you will:   
- Export all your library source members to a git reposuitory.
- Export individual source member changes to a repository.
- Import the last commit for a selected source member from your git repository and replace existing source member.
- View the git log for a source member.
- Use a git hash value from the git log to view a specific version of a source member.
- Use the git blame command to view a consolidated list of all changes by user name.

## Steps to set up your test scenario on PUB400
For this example we will use a PUB400 user of: ```USERID```.          
And we will use the user's PUB400 sample library name of: ```USERID1```

```
Subtitute your own PUB400 user profile and library name into all following commands   
where USERID is used for user id and USERID1 is used for library name.
```   

### Log in to PUB400 and change your job CCSID to 37 if from the United States    
This needs to be done for each 5250 login for anyone connecting from the U.S. with CCSID 37.   

**On your own IBM i this should not be needed.**   

Log in to a 5250 session and run the following command to set your job CCSID:   
```CHGJOB CCSID(37)```

### Determine your home directory on the PUB400 system.    
From a 5250 command line, run the following command with your user profle:   
```DSPUSRPRF USRPRF(USERID) TYPE(*BASIC)```   

Page through the results and note the **Home directory** setting value.   
Ex:  ```/home/USERID```

### Create the main top level IFS directory structure for your git repositories (one time setup)

```
MKDIR DIR('/home/USERID') DTAAUT(*RWX) OBJAUT(*ALL)
MKDIR DIR('/home/USERID/gitrepos') DTAAUT(*RWX) OBJAUT(*ALL)
```
As a general rule if you create all your repos under the same master IFS folder such as ```/home/USERID/gitrepos``` you can back up all of your local git repositories from the IFS with a single backup command such as ```SAV```.   

From a git structure perspecitive, each source library will have its own git repository associated with the library.   

### Set your global git user information (one time for each user)
Each user needs needs to log in and set a git user value set so git can use that info when logging new repository commits. This setting only needs to be done once per user profile after thay have logged in.  

The git user info does NOT have have to be the same as your IBM i profile because it's used specifically by git so any values will do to identify your user.   

In our example we will specify your first name and last name as your git profile.
```
SETGBLUSR USERNAME('YourFirstName YourLastName')                  
          USEREMAIL('userid@test.com')      
          PRELOADIDX(*FALSE)                 
          DSPSTDOUT(*YES)
```

After typing the command, press ```Enter``` to run the command you should see the contents of your .gitconfig file displayed.   
```
[user]                                      
 name = YourFirstName YourLastName
 email = userid@test.com          
[core]                                      
 preloadIndex = false                       
```
Press ```F3``` to exit if all looks OK. You can also run the SETGBLUSR command for your user again if needed.   
    
### Set your git library repo IFS directory
The SETLIBREPO command sets a data area path for a library's associated git repository and also enables the selected library for git.    

This command should be run once for each library that will be managed with iForGit and git.       
```
IFORGIT/SETLIBREPO LIBRARY(USERID1)                      
                    IFSREPODIR('/home/USER/gitrepos/USERID1')   
                    ENABLEGIT(*YES)                         
                    OPTION(*SET)                            
```

**The USERID1 directory will auto-create when you do your first git export export.**   

### Set your PDM options file to iForGit options file
Normally you would create your own PDM options in your own options file. Or you would create options in RDI or VS Code, but for this test we are using PDM and you can use the PDM options in file: ```IFORGIT/QAUOOPTGIT```, member: ```QAUOOPTGIT```

First start PDM via the STRPDM command.
```STRPDM```

Then press ```Shift-F6 (F18)``` to ``Change Defaults``` in PDM.

Change settings as follows and press ```Enter``` to save.
```
 Option file  . . . . . . . .   ```QAUOOPTGIT```  
   Library  . . . . . . . . .     ```IFORGIT```   
 Member . . . . . . . . . . .   ```QAUOOPTGIT```
```

## Steps to test iForGit against your own source members
These steps will be used to export some source to a git repository and exercise the iForGit CL commands for versioning source members.

### Create some source physical files of your own
Your PUB400 library should come with a set up pre-configured source files.    

If source files don't exist, create a source file for ```QCLSRC``` and ```QRPGLESRC```.    
```
CRTSRCPF FILE(USERID1/QCLSRC) RCDLEN(120)
CRTSRCPF FILE(USERID1/QRPPGLESRC) RCDLEN(120)
```

### Create a source member TEST001C in library USERID1/QCLSRC
For our example we will create a CL source member named ```TEST001C``` in library: ```USERID1/QCLSRC``` with the following member text: ```iForGit Test Member```. Make sure the source type is:```CLP```.

Sample code for TEST001C:
```
PGM                                                      
                                                         
DCL        VAR(&VALUE1) TYPE(*CHAR) LEN(100) +           
             VALUE('Hello iForGit')                      
                                                         
SNDPGMMSG  MSGID(CPF9898) MSGF(QCPFMSG) MSGDTA(&VALUE1) +
             MSGTYPE(*INFO)                              
                                                         
RETURN                                                   
                                                         
ENDPGM                                                   
```

### Create some more source members if desired
You can create a couple more source members using PDM, RDI or VS Code if desired.

### Do initial export of source to your git repository
The ```LIBSRCEXP``` command can be used to export all current source members to a git repository and also to capture changes on a daily basis from a scheduled job if desired.

Run the LIBSRCEXP command as follow with your library:
```
LIBSRCEXP LIBRARY(USERID1)        
          FILE(*ALL)                
          STARTDATE(*ALL)           
          IFSREPODIR(*LIBREPODTAARA)
          SRCHEADER(*YES)           
          REPLACE(*YES)             
          VALIDREPO(*YES)           
          IFSMKDIR(*YES)            
          INITREPO(*YES)            
          COMMITOPT(*COMMIT)        
          COMMENT(*DATEUSER)        
          AUTHORITY(*INDIR)         
          JOBMSGQFUL(*WRAP)         
```

This will export all source members from the selected library to your git repository and will auto-create the ```USERID1``` directory within ```/home/USERID/gitrepos``` directory.   

### Make sure your library repo directory now exists with source
Run the following command to see you git repository directory:
```WRKLNK OBJ('/home/USERID/gitrepos/USERID1/*') OBJTYPE(*ALL) DSPOPT(*ALL)```

The directory list should look similar to the following:   
```
Object link            Type  
.                      DIR   
..                     DIR   
.git                   DIR   
QCLSRC                 DIR
QRPGLESR               DIR 
```

### Make a change to TEST001C and commit the change with ```GE``` PDM option
From your favorite editor or PDM/SEU, add or change some lines in the  ```QCLSRC/TEST001C``` source member and then save the member changes.

Now from a PDM member list for library: ```USERID1```, member:```QCLSRC/TEST001C```you will run the ```GE``` PDM option and press ```F4``` to prompt the ```SRCTOGIT``` command or simply press Enter to run the command.

If the commit worked as expected you'll see a message like the following at the bottom of the 5250 screen:   
```
Member USERID1/QCLSRC(TEST001C) exported/committed to /home/userid/gitrepos/userid1/QCLSRC/TEST001C.CLP in repo
/home/userid/gitrepos/userid1.
```

Run the ```GE``` option again against member: ```TEST001C``` and you should see the following message if no changes were made:   
```
Nothing to commit occurred for repo /home/userid/gitrepos/userid1. Check the job log if needed. 
```

iForGit and git are smart enough to detect if changes were made to a member so source commits will not happen unless actual changes were made to a source member.

### Restoring most recent source member commit from git repository ```GI``` PDM option
Normally you would edit a source member, but sometimes you might need to restore the last good member from a source repository.   

If you want to restore an entire source member from its last source commit and replace the source file member, use the ```GI``` PDM option to run the SRCFRMGIT command to restore the source member.

If the restore worked as expected you'll see a message like the following at the bottom of the 5250 screen:   
```
/home/richards/gitrepos/richards1/QCLSRC/TEST001C.CLP source member imported to RICHARDS1/QCLSRC(TEST001C).                   
```

If you view the source member it will display along with the source header metadata information which gets stored in git along with the source member as a source header:   
```
/*------------------------------------------------------------*/      
/* @@LIBRARY: RICHARDS1                                       */      
/* @@FILE: QCLSRC                                             */      
/* @@MEMBER: TEST001C                                         */      
/* @@TYPE: CLP                                                */      
/* @@TEXT: iForGit Test Member                                */      
/*------------------------------------------------------------*/      
             PGM                                                      
                                                                      
             DCL        VAR(&VALUE1) TYPE(*CHAR) LEN(100) +           
                          VALUE('Hello iForGit')                      
                                                                      
             SNDPGMMSG  MSGID(CPF9898) MSGF(QCPFMSG) MSGDTA(&VALUE1) +
                          MSGTYPE(*INFO)                              
                                                                      
             RETURN
                                                                     
             ENDPGM                                                   
```

### Viewing the git change log for a source member using  the ```GL``` PDM option
The git change log tracks each committed source member version in a git repository and marks it with a value called a git hash.   
Ex git commit hash version code: ```8901f7835c92d27349e8af529c1704ea063112ce```

If you want to see the git log, run the ```GL``` option against source member ```TEST001C``` source member from a 5250 session.    

When the log option completes it will display as follows:    
```
commit 8901f7835c92d27349e8af529c1704ea063112ce (HEAD -> master)  
Author: First Last <userid@test.com>                
Date:   Sun Dec 3 01:22:12 2023 +0000                             
                                                                  
    Committed-20231203-012211947-USERID - SRCTOGIT              
                                                                  
commit d33b32961b721e6efefc170a27ed79bd9988acb1                   
Author: First Last <userid@test.com>                
Date:   Sun Dec 3 01:06:54 2023 +0000                             
                                                                  
    Committed-20231203-010652533-USERUD - SRCTOGIT              
```
 
You can copy the commit hash for the selkected member you want to view.   

We will view the selected member in the next section via the ```GC``` PDM option (git checkout).

### Viewing the selected source member version using the ```GC``` PDM option
The git checkout option lets you check out a selected version of a source member and view it from a temporary source file in ```QTEMP/TMPSOURCE``` or restore the source member to a specified library source file and member.

Using a git hash code you saw for the ```TEST001C``` source member we listed in the git log example, run the ```GC``` option against source member ```TEST001C``` and press ```F4```

From the command prompt, paste the selected hash code in the Source hash field as shown:       
```
                    Run Git Cmd Against Repo Mbr (SRCGITCMD)                    
                                                                                
 Type choices, press Enter.                                                     
                                                                                
 Source file  . . . . . . . . . . SRCFILE      > QCLSRC                         
   Library  . . . . . . . . . . .              >   RICHARDS1                    
 Source member  . . . . . . . . . SRCMBR       > TEST001C                       
 Destination git repo IFS dir . . IFSREPODIR   > *LIBREPODTAARA                 
 Git option . . . . . . . . . . . SRCOPTION    > *CHECKOUT                      
 Source version hash  . . . . . . SRCHASH      > '8901f7835c92d27349e8af529c1704
ea063112ce'                                                                     
 Prompt GITQSH cmd to debug . . . DEBUGQSH       *NO                            
 Display Standard Output Result   DSPSTDOUT    > *NO                            
 Log standard output to job log   LOGSTDOUT      *NO                            
 Print Standard Output Result . . PRTSTDOUT      *NO
```

Press  Enter and the source member is retrieved and displayed using SEU.

```
 Columns . . . :    1  71           Browse                      QTEMP/TMPSOURCE
 SEU==>                                                               TMPSOURCE
 FMT **  ...+... 1 ...+... 2 ...+... 3 ...+... 4 ...+... 5 ...+... 6 ...+... 7 
        *************** Beginning of data *************************************
0001.00 /*------------------------------------------------------------*/       
0002.00 /* @@LIBRARY: RICHARDS1                                       */       
0003.00 /* @@FILE: QCLSRC                                             */       
0004.00 /* @@MEMBER: TEST001C                                         */       
0005.00 /* @@TYPE: CLP                                                */       
0006.00 /* @@TEXT: iForGit Test Member                                */       
0007.00 /*------------------------------------------------------------*/       
0008.00              PGM                                                       
0009.00                                                                        
0010.00              DCL        VAR(&VALUE1) TYPE(*CHAR) LEN(100) +            
0011.00                           VALUE('Hello iForGit')                       
0012.00              DCL        VAR(&VALUE2) TYPE(*CHAR) LEN(100) +            
0013.00                           VALUE('Hello iForGit')                       
0014.00                                                                        
0015.00              SNDPGMMSG  MSGID(CPF9898) MSGF(QCPFMSG) MSGDTA(&VALUE1) + 
0016.00                           MSGTYPE(*INFO)
0017.00                                                                        
0018.00              RETURN                                                    
0019.00                                                                        
0020.00              ENDPGM                                                    
        ****************** End of data ****************************************
```

### Viewing the overall change history for selected source member version using the ```GB``` PDM option
The git blame option lets you see the composite changes made for a source member.

Use the git blame option ```GB``` against source member ```TEST001C``` and press ```Enter``` to view the composite source member change history along with hash codes.

```
d33b3296 (Richard schoen 2023-12-03 01:06:54 +0000  1) /*------------------
d33b3296 (Richard schoen 2023-12-03 01:06:54 +0000  2) /* @@LIBRARY: RICHAR
d33b3296 (Richard schoen 2023-12-03 01:06:54 +0000  3) /* @@FILE: QCLSRC   
d33b3296 (Richard schoen 2023-12-03 01:06:54 +0000  4) /* @@MEMBER: TEST001
d33b3296 (Richard schoen 2023-12-03 01:06:54 +0000  5) /* @@TYPE: CLP      
d33b3296 (Richard schoen 2023-12-03 01:06:54 +0000  6) /* @@TEXT: iForGit T
d33b3296 (Richard schoen 2023-12-03 01:06:54 +0000  7) /*------------------
d33b3296 (Richard schoen 2023-12-03 01:06:54 +0000  8)              PGM    
d33b3296 (Richard schoen 2023-12-03 01:06:54 +0000  9)                     
d33b3296 (Richard schoen 2023-12-03 01:06:54 +0000 10)              DCL    
d33b3296 (Richard schoen 2023-12-03 01:06:54 +0000 11)                     
8901f783 (Richard schoen 2023-12-03 01:22:12 +0000 12)              DCL    
8901f783 (Richard schoen 2023-12-03 01:22:12 +0000 13)                     
d33b3296 (Richard schoen 2023-12-03 01:06:54 +0000 14)                     
d33b3296 (Richard schoen 2023-12-03 01:06:54 +0000  8)              PGM    
d33b3296 (Richard schoen 2023-12-03 01:06:54 +0000  9)                     
d33b3296 (Richard schoen 2023-12-03 01:06:54 +0000 10)              DCL    
d33b3296 (Richard schoen 2023-12-03 01:06:54 +0000 11)                     
8901f783 (Richard schoen 2023-12-03 01:22:12 +0000 12)              DCL    
8901f783 (Richard schoen 2023-12-03 01:22:12 +0000 13)                     
d33b3296 (Richard schoen 2023-12-03 01:06:54 +0000 14)                     
d33b3296 (Richard schoen 2023-12-03 01:06:54 +0000 15)              SNDPGMM
d33b3296 (Richard schoen 2023-12-03 01:06:54 +0000 16)                     
d33b3296 (Richard schoen 2023-12-03 01:06:54 +0000 17)                     
d33b3296 (Richard schoen 2023-12-03 01:06:54 +0000 18)              RETURN 
d33b3296 (Richard schoen 2023-12-03 01:06:54 +0000 19)                     
d33b3296 (Richard schoen 2023-12-03 01:06:54 +0000 20)              ENDPGM 
```

Once the source member has been displayed, you can use the edit file (EDTF) function keys to window left or right to see more info for each source member.   
```Shift-F7 (F19)``` - Window left, ```Shift-F8 (F20)``` - Window right, etc.

