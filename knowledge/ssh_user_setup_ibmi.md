# Create an SSH User for use with iForgit, Git, Github and Other Remote Git Repositories
This document covers the steps to create an SSH user for use with iForGit and remote Git repositories.

SSH users and public/private keys are the only safe way to use remote git repositories with IBM i.

# Set up SSH User

### Create a user profile
```
CRTUSRPRF USRPRF(SSHUSER1) HOMEDIR('/home/SSHUSER1') 
```

### Create the user home directory
```
MKDIR DIR('/home/SSHUSER1') DTAAUT(*INDIR) OBJAUT(*INDIR) 
```

### Make the user owner of their home directory
```
CHGOWN OBJ('/home/SSHUSER1')    
       NEWOWN(SSHUSER1)         
       RVKOLDAUT(*YES)          
       SUBTREE(*ALL)
```

### Exclude public users from access to the home dir
```
CHGAUT OBJ('/home/SSHUSER1') USER(*PUBLIC) DTAAUT(*NONE)
CHGAUT OBJ('/home/SSHUSER1') USER(*PUBLIC) OBJAUT(*NONE)    
```





