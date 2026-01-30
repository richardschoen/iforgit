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
### Create SSH user from 5250
Log in as the user: SSHTEST1 and start a QShell session. 
```
STRQSH
```

Run the following QShell commands to generate your new SSH public/private key files
```
ssh-keygen -t ed25519
```
You should see this: 
```
Generating public/private ed25519 key pair.                              
Enter file in which to save the key (/home/SSHUSER1/.ssh/id_ed25519):    
```
Press Enter to continue.   
You should now see this:     
```
Created directory '/home/SSHUSER1/.ssh'.    
Enter passphrase (empty for no passphrase):
```
Press enter to create the SSH key with no passphrase.   
You should now see this: 
```
Created directory '/home/SSHUSER1/.ssh'.                                
Enter passphrase (empty for no passphrase): Enter same passphrase again:
```
Press Enter again to confirm that you want no password.

You should now see something like this: 
```
Enter passphrase (empty for no passphrase): Enter same passphrase again: Your
 identification has been saved in /home/SSHUSER1/.ssh/id_ed25519             
Your public key has been saved in /home/SSHUSER1/.ssh/id_ed25519.pub         
The key fingerprint is:                                                      
SHA256:u715bLPBmxD7Bz6ht7RqJjlMVoerWtO4R0kvJuqshMA sshuser1@yourdomain.com                                                                             
The key's randomart image is:                                                
+--[ED25519 256]--+
|                 |  
|                 |  
|           .     |  
|.         + .    |  
|.E      So.=     |  
| . .    ++*++    |  
|  . .  ==*+=+o   |  
|   . ...*===O=.  |  
|    .o+.o*=*B*   |  
+----[SHA256]-----+  
```
Press F3 to exit the QShell screen. 



















