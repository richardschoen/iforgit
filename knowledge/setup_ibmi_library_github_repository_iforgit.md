# Set up a new IBM i Library Repository in GitHub, Cloning and Initializing from your IBM i Library with iForGit
This document describes the process of creating a new library repository in GitHub and then cloning it to your IBM i system to be used with iForGit.

As part of the process the initial clone creates the repository on the IBM IFS file system and connects it to GitHub via SSH. Then we connect the new repository to an IBM i library so changes can be made, committed and then pushed to the remote GitHub repository on a regular basis.

## Steps 
Follow the steps listed below to set up yor new repository on GitHub and hook up your library and clone your source files for the first time. Repeat the relevant steps for each new library repository to hook it up to Git and GitHub.

### IBM i - Create an IBM i SSH user key for each IBM i user
Use the following link to set up an SSH public/private user key file for each user who will be committing changes to your git repositories. 
❗It might make sense to set up the first user initially to make sure you can create the user and use it with GitHub.    
https://github.com/richardschoen/iforgit/blob/master/knowledge/setup_ibmi_ssh_user.md   

The public key for each user will be added to theiir GitHub user profile so the GitHub repositories can be accessed from IBM i without needing to directly log in to GitHub.

❗```After you've created your first user's SSH key files, come back to this part of the document and continue.```

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

Note: You can always come back to the ```SSH and GPG keys``` area to see if you key file has actually been used as well if troubleshooting issues. This example shows our key has been successfuly used previously for cloning:

<img width="956" height="149" alt="image" src="https://github.com/user-attachments/assets/186d10cb-3d72-4ad5-b061-6ad4bae0ad94" />



### GitHub - Create new GitHub repository for selected library

This example creates a new repository named ```LIB001``` to go with IBM i library ```LIB001```.   

❗ Your GitHub repository names don't have to match your library names exactly, but it's a recommended naming convention.    
Example alternate naming: You could name your repos something like:  ```LIB001-DEV```, ```LIB001-QA```, ```LIB001-PROD``` for each system. 

❗You will generally be creating ```Private``` Git repositories, but you can also create ```Public``` Git repositories. However Public repositories can be seen by anyone and are generally only used for open source code. Select ```Private``` for the ```Choose Visibility``` option to make sure your repositories stay private.

<img width="265" height="295" alt="image" src="https://github.com/user-attachments/assets/f834f8b0-eda4-483c-95a9-7e1bd420eb94" />



<img width="769" height="594" alt="image" src="https://github.com/user-attachments/assets/dc4a5dbf-3334-4618-a5fa-51ddd0385132" />

Click the ```Create Repository``` button to create the new repository. 
<img width="168" height="54" alt="image" src="https://github.com/user-attachments/assets/f477e97f-b658-4ec2-88f9-4ca52de59e12" />

You GitHub repository will look something like this: 

<img width="1249" height="546" alt="image" src="https://github.com/user-attachments/assets/5dc92e71-2185-43d6-ba2c-b852af4fc854" />


### IBM i - Set git config user information in .gitconfig file to set up each Git user (one time per IBM i user) 
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

If iForGit isn't loaded on your IBM i yet, you can set you global git user info using the following git commands from a QShell session or SSH terminal:
Set the username: 
```
/QOpenSys/pkgs/bin/git config --global user.name "Your Name"
```
Set the email address:
```
/QOpenSys/pkgs/bin/git config --global user.email "your_email@example.com"
```

You can also use the ```IFORGIT/GITQSHEXEC``` command to set the git user info from a 5250 session. This command is a general command that can be used to run QShell/PASE commands from a 5250 session, program or batch job and capture their results.   
Set the username:
```
IFORGIT/GITQSHEXEC CMDLINE('/QOpenSys/pkgs/bin/git config --global user.name "Your Name"') DSPSTDOUT(*YES)
```
Set the email address:
```
IFORGIT/GITQSHEXEC CMDLINE('/QOpenSys/pkgs/bin/git config --global user.email "your_email@example.com') DSPSTDOUT(*YES)   
```

❗Make sure you complete this step to set the Git user info before attempting to clone a repository or commit changes back to a Git repository. This identifies each user to Git.

### Make sure the /gitrepos IFS folder exists (one time check)
The ```/gitrepos``` IFS directory is used as a top level location for all library source exports. Each library will have a subdirectory within /gitrepos. For our example we will end up with ```/gitrepos/LIB001``` after the first library export.

Let's make sure /gitrepos exists.
```
MKDIR DIR('/gitrepos') DTAAUT(*RWX) OBJAUT(*ALL) 
```
❗The directory will either be created or you will be told it already exists.
❗You can also further secure this IFS directory as you see fit as long as any Git users can read/write to the IFS directory where your Git repositories are located.

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

The rest of the steps should be the same whether you are running from an SSH terminal or QShell from a 5250 session. 

Change to the /gitrepos directory before we clone the repository.
```
cd /gitrepos
```

Run the Git clone command to get the repository contents from GitHub and connect us up to GitHub. In this example, you would put your GitHub repository path where I placed ```<yourgitacctname>```. The ssh command tells the git clone process to use your SSH key file located in your /home/<userid/.ssh directory when connecting. Each user will have their own ssh private key in their /home/<userid>/.ssh directory. 
```
GIT_SSH_COMMAND="ssh -i ~/.ssh/id_ed25519" /QOpenSys/pkgs/bin/git clone ssh://git@github.com:/<yourgit acctname>/LIB001.git
```
My actual test example that I used against my GitHub richardschoen account:
```
GIT_SSH_COMMAND="ssh -i ~/.ssh/id_ed25519" /QOpenSys/pkgs/bin/git clone ssh://git@github.com:/richardschoen/LIB001.git              
```

If you see the following message, type ```yes``` to continue:
```
The authenticity of host 'github.com (140.82.112.4)' can't be established.
ED25519 key fingerprint is SHA256:+DiY3wvvV6TuJJhbpZisF/zLDA0zPMSvHdkr4UvCOqU.
This key is not known by any other names
Are you sure you want to continue connecting (yes/no/[fingerprint])?
```
Once the clone to the IFS completes successfully you should see something like this:
```
Warning: Permanently added 'github.com' (ED25519) to the list of known hosts.
remote: Enumerating objects: 9, done.
remote: Counting objects: 100% (9/9), done.
remote: Compressing objects: 100% (3/3), done.
remote: Total 9 (delta 0), reused 6 (delta 0), pack-reused 0 (from 0)
Receiving objects: 100% (9/9), done.
```
✅ Your repository has cloned successfully.

Do the following to see if you can write back to the repository successfully with commits:

Change to repository directory   
```
cd /gitrepos/LIB001
```
Append some text to the readme.md file to make a change   
```
echo "test" >> readme.md
```
Add and commit the readme.md file changes
```
/QOpensys/pkgs/bin/git add .
```
```
/QOpensys/pkgs/bin/git commit -m "First Commit"
```
You should see:
```
[main 1ba13a6] First Commit
 1 file changed, 1 insertion(+)
```
Push changes to GitHub repository
```
/QOpensys/pkgs/bin/git push                    
```
You should see:
```
Enumerating objects: 5, done.
Counting objects: 100% (5/5), done.
Writing objects: 100% (3/3), 282 bytes | 31.00 KiB/s, done.
Total 3 (delta 0), reused 0 (delta 0), pack-reused 0 (from 0)
To ssh://github.com:/richardschoen/LIB001
   101255e..1ba13a6  main -> main
```
Do a git pull to test pulling changes from GitHub
```
/QOpensys/pkgs/bin/git pull
```
You should see:
```
Already up to date.
```
Check Git repository status:
```
/QOpensys/pkgs/bin/git status
```
You should see:   
```
On branch main
Your branch is up to date with 'origin/main'.

nothing to commit, working tree clean
```

❗You should now have a GitHub repository hooked up and connected up to your IBM i in the IFS. You are ready to add some source members to the repo.

### IBM i - Set local IBM i repo info for library ```LIB001``` (one time per library)
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


### Do a git push to push the committed source changes to the GitHub repository
If you used the *COMMIT option on LIBSRCEXP for efficiency, run the following git command to push all committed changes from the local IFS Git repository to your GitHub site in one single command.     
Note: Only use DSPSTDOUT(*YES) when running interactively and you want to see the command results.   
```
IFORGIT/GITCMD LIBRARY(LIB001) CMDOPTS(push) DSPSTDOUT(*YES)  
```
Example results if all changes are current in GitHub:
```
************Beginning of data**************
Everything up-to-date                       
************End of Data********************
```
   
❗ GITCMD always created an outfile named: QTEMP/STDOUTGIT in case you want to process and capture the results of a GITCMD operation.


### Check Git repository status for library
The Git status command can be run against your repository using the GITCMD CL command along with the status option.
```
GITCMD LIBRARY(LIB001) CMDOPTS(status) DSPSTDOUT(*YES)
```
Example results:
```
************Beginning of data**************
On branch main                                   
Your branch is up to date with 'origin/main'.    
                                                 
nothing to commit, working tree clean            
************End of Data********************
```

✅ You are now ready to use your library with it's new GitHub repo for capturing source members with iForGit.

## Questions or problems hooking up to a GitHub repository
If you have any questions on this process, please reach out by creating a GitHub issue in this repository or send an email to: richard@mobigogo.net or richard@richardschoen.net

