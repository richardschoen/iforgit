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
###
