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
The SETLIBREPO command creates a data area for the associated git repository and also enables the selected library for git.    

This command should be run once for each library that will be managed with iForGit and git.       
```
IFORGIT/SETLIBREPO LIBRARY(USERID1)                      
                    IFSREPODIR('/home/USER/gitrepos/USERID1')   
                    ENABLEGIT(*YES)                         
                    OPTION(*SET)                            
```

**The USERID directory will auto-create when you do your first git export export.**   

## Steps to test iForGit against your own source members
These steps will be used to export some source to a git repository and exercise the iForGit CL commands for versioning source members.



create some source members

set pdm opts

libsrcexp 

ge
gi
gl
gc




