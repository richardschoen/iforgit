# Demo iForGit with a PUB400 Account
You can demo iForGit on PUB400 user account using a local IFS based git repository in your home directory on PUB400.

## Steps to set up a test scenario on PUB400
For this example we will use a demo PUB400 user of: ```USERID```.          
And we will use the user's sample library name of: ```USERID1```

```Subtitute your own PUB400 user profile and library name into all following commands```.   

### Determine your home directory on the PUB400 system.    

Run the following command with your user profle:   
```DSPUSRPRF USRPRF(USERID) TYPE(*BASIC)```   

Page through the results and note the **Home directory** setting value.   
Ex:  ```/home/USERID```

### Create the main top level IFS directory structure for your git repos

```
MKDIR DIR('/home/USERID') DTAAUT(*RWX) OBJAUT(*ALL)
MKDIR DIR('/home/USERID/gitrepos') DTAAUT(*RWX) OBJAUT(*ALL)
```
As a general rules if you create all your repos under the same master IFS folder such as ```/home/USERID/gitrepos``` you can back up all of your git repositories from the IFS with a single backup command such as ```SAV```.
-Create one or more source physical files

### Set your global git user information (one-time per user)
Each user needs a git user value set so git can use that info when logging new repository commits. This setting only needs to be done once per user profile,    

The git user info does NOT have have to be the same as your IBM i profile because iot's used specifically by git so any values will do to identify your user.
```
SETGBLUSR USERNAME(USERID1)                  
          USEREMAIL('userid1@test.com')      
          PRELOADIDX(*FALSE)                 
          DSPSTDOUT(*YES)
```
    
### Set your git library repo IFS directory
The SETLIBREPO command creates a data area for the associated git repository and also enables the library for git.    

This command should be run once for each library that will be managed with iForGit and git.       
```
IFORGIT/SETLIBREPO LIBRARY(USERID1)                      
                    IFSREPODIR('/home/USER/gitrepos/USERID1')   
                    ENABLEGIT(*YES)                         
                    OPTION(*SET)                            
```

**The USERID1 directory will auto-create when you do your first git export export.**   






set pdm opts



