# Set up a new IBM i Library Repository in GitHub, Cloning and Initializing from your IBM i Library
This document describes the process of creating a new library repository in GitHub and then cloning it to your IBM i system to be used with iForGit.

As part of the process the initial clone creates the repository on the IBM IFS file system and connects it to GitHub via SSH. Then we connect the new repository to an IBM i library so changes can be made, committed and then pushed to the remote GitHub repository on a regular basis.

## Steps 
-Create ssh public/private user key for each IBM i user who will be committing source to a repo. 
You can also set up for just a single user if you plan to share an SSH key. Sharing an SSH key will still allow commits to be separated by git user because each IBM i user will also have a git profile.

-Add public key to GitHub user profile.   


-Create new GitHub repository for a library. Ex: QGPL     
Make sure to create a readme.md file so the repo has at least one file.    

-Clone the repository to /gitrepos/libraryname     

-Initialize with LIBSRCEXP *ALL.   

-Perform daily updates to repositories on a scheduled basis with LIBSRCEXP *LAST7.   


### IBM i - Create an IBM i SSH user key for each IBM i user
Use the following link to set up an SSH public/private user key file for each user who will be committing changes to your git repositories. 
❗It might make sense to set up the first user initially to make sure you can create the user and use it with GitHub.
https://github.com/richardschoen/iforgit/blob/master/knowledge/ssh_user_setup_ibmi.md   

The public key for each user will be added to theiir GitHub user profile so the GitHub repositories can be accessed from IBM i without needing to directly log in to GitHub.

```After you've created your first use SSH key files, come back to this part of the document and continue.```

### GitHub - Add public user key to your GitHub profile   
Log in to your git user account, navigate to the user profile in the upper right corner. Then select ```Settings```.        

<img width="296" height="434" alt="image" src="https://github.com/user-attachments/assets/33ff4e41-a9ab-4212-b31a-273e694e1672" />


             
Select ```SSH and GPG Keys```         
<img width="294" height="394" alt="image" src="https://github.com/user-attachments/assets/5baf481d-af7f-4d62-a6ea-39d991828ce5" />

Click the ```New SSH Key``` button to add a new SSH public key   
<img width="134" height="55" alt="image" src="https://github.com/user-attachments/assets/d3155e25-1c5d-4425-8c89-0744f7d037d6" />

Key in a ```Title```, select ```Authentication Key``` for ```Key Type``` and paste the value from your public key file into the ```Key``` field.    
If you created a key for your IBM i user, the value to paste in to the ```Key``` field will be from the ```id_ed25519.pub``` file. You can open your public key file in a text editor such as Notepad or VS Code and copy/paste the value into the ```Key``` field. For the ```Title``` I like to use the original public key file name, but you can put anything you find meaningful to identify your key. In this example we entered ```id_ed25519.pub```
<img width="956" height="529" alt="image" src="https://github.com/user-attachments/assets/716a1eae-4abb-4aac-b83c-cbe602f4b384" />

Click the ```Add SSH Key``` button to save the public key to the GitHub user profile.

### GitHub - Create new GitHub repository for selected library

This example creates a new repository named ```LIB001``` to go with IBM i library ```LIB001```.   

❗ Your GitHub repository names don't have to match your library names exactly, but it's a recommended naming convention.    
Example alternate naming: You could name your repos something like:  ```LIB001-DEV```, ```LIB001-QA```, ```LIB001-PROD``` for each system. 

❗You will generally be creating ```Private``` Git repositories, but you can also create ```Public``` Git repositories. However Public repositories can be seen by anyone and are generally only used for open source code. Select ```Private`` for the ```Choose Visibility``` option to make sure your repositories stay private.

<img width="265" height="295" alt="image" src="https://github.com/user-attachments/assets/f834f8b0-eda4-483c-95a9-7e1bd420eb94" />



<img width="769" height="594" alt="image" src="https://github.com/user-attachments/assets/dc4a5dbf-3334-4618-a5fa-51ddd0385132" />

Click the ```Create Repository``` button to create the new repository. 
<img width="168" height="54" alt="image" src="https://github.com/user-attachments/assets/f477e97f-b658-4ec2-88f9-4ca52de59e12" />

### IBM i - Set git config user information in .gitconfig file for one time to set up each Git user
Each IBM i user needs to log in to a 5250 session and run the ```SETGBLUSR``` command ```one time``` to create Git user settings for the user. The command creates a ```.gitconfig``` file in the user's home directory.  Ex: ```/home/sshuser1/.gitconfig```. The .gitconfig file is used to track who makes changes and Git commits. For the USERNAME, enter a first and last name. Then enter the user's email address and ```press Enter``` to save. The .gitconfig settings are independent of GitHub, the IBM i and the user's SSH key. The .gitconfig is used specifically by Git to track Git commits to know which user is committing version changes.
```
IFORGIT/SETGBLUSR USERNAME('Richard Schoen')      
          USEREMAIL(richard@mobigogo.net) 
```

If you want to view or edit the contents of the user's .gitconfig file, you can run the following command:
```
DSPF STMF('/home/SSHUSER1/.gitconfig')

-or-

EDTF STMF('/home/SSHUSER1/.gitconfig')
```

### Make sure the /gitrepos IFS folder exists (one time check)
The ```/gitrepos``` IFS directory is used as a top level location for all library source exports. Each library will have a subdirectory within /gitrepos. For our example we will end up with ```/gitrepos/LIB001``` after the first library export.

Let's make sure /gitrepos exists.
```
MKDIR DIR('/gitrepos') DTAAUT(*RWX) OBJAUT(*ALL) 
```
❗The directory will either be created or you will be told it already exists.

### IBM i - Clone the GitHub repository to the IFS
This step should be able to be done from an SSH terminal or from the 5250 command line. 

If running from the 5250 command line, first run this command to set the QShell path to the open source binaries so QShell can find the ```git``` command.
```
IFORGIT/GITPATH
```
Then start the QShell terminal
```
STRQSH
```

The rest of the steps should be the same whether you are running from an SSH terminal or QShell. 






### IBM i - Set local IBM i repo info for library ```LIB001```
Run the ```SETLIBREPO``` command to connect library ```LIB001``` to the Git repository you cloned to directory ```/gitrepos/LIB001```.  This setting needs to be run ```one time``` for each library you will be committing version changes to for Git. This essentially connects your library to the correct Git repository.  
```
IFORGIT/SETLIBREPO LIBRARY(LIB001)                  
            IFSREPODIR('/gitrepos/LIB001')   
            ENABLEGIT(*YES)                  
            OPTION(*SET)                     
```

### IBM i - Perform initial export of source from library ```LIB001``` to seed the git repository for the first time
This step is used to export all (*ALL) source members from a library or just selected source physical files to the LIB001 Git repository. 
❗Generally ```*ALL``` is the correct option unless there are source files you want to omit from the Git repository.

The LIBSRCEXP command will automatically perform a change job to make sure the joblog does not full by wrapping the joblog when it's full. You can also do it manually if desired to make sure your job log is set to *WRAP.

This version of the LIBSRCEXP command settings is used to do an initial export of all source. The same settings can also be used to catch up a Git repository if source members haven't been regularly committed by developers or automatically on a daily basis. Usually this command is run to initialize/seed the repository with all source members and then LIBSRCEXP also be run on a daily basis with a STARTDATE of *LAST7, *LAST14 or *LAST30 to do a rolling capture of changed mambers based on their source member change dates. *LAST7 seems to be a good place to start for regular job scheduled change captures.

```
CHGJOB JOBMSGQFL(*WRAP)
```
Run the initial LIBSRCEXP command with *ALL option to create and initialize the repository in the IFS or to update the repository if regular commits have been missed or developers are not doing individual commits. It's a good idea to run this iteration of LIBSRCEXP once per month to make sure nothing was missed. This version of the command does a local commit to the IFS based Git repository. Specify *COMMITSYNC to push the changes for each member as it gets exported.
```
 IFORGIT/LIBSRCEXP LIBRARY(LIB001)           
                   FILE(*ALL)                
                   STARTDATE(*ALL)           
                   ENDDATE(*STARTDATE)       
                   IFSREPODIR(*LIBREPODTAARA)
                   SRCHEADER(*YES)           
                   SRCDATSEQ(*NO)            
                   REPLACE(*YES)             
                   VALIDREPO(*YES)           
                   IFSMKDIR(*YES)            
                   INITREPO(*YES)            
                   COMMITOPT(*COMMIT)    
                   COMMENT(*DATEUSER)        
                   AUTHORITY(*INDIR)         
                   JOBMSGQFUL(*WRAP)         
```


### Do a git push to push the source to the GitHub repository


### Git status ?



