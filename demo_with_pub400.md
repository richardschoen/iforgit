# Demo iForGit with a PUB400 Account
You can demo iForGit on PUB400 user account using a local IFS based git repository in your home directory on PUB400.

## Steps to set up a test scenario on PUB400
For this example we will use a demo user of: ```USER001```.          
And we will use a sample library name of: ```USER001T1```

Subtitute your own user profile into all commands.   


### Determine your home directory on the PUB400 system.    

Run the following command with your user profle:   
```DSPUSRPRF USRPRF(USER001) TYPE(*BASIC)```   

Page through the results and note the **Home directory** setting value.   
Ex:  ```/home/USER001```

### Create your sample library

EX: CRTLIB USER001T1

-Create one or more source physical files

