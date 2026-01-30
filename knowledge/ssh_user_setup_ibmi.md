# Create an SSH User for use with iForgit, Git, Github and Other Remote Git Repositories
This document covers the steps to create an SSH user for use with iForGit and remote Git repositories.

SSH users and public/private keys are the only safe way to use remote git repositories with IBM i.

# Set up SSH User Example
We will use a user name of ```SSHUSER1``` for this example.

### Create a user profile (skip if user exists)
```
CRTUSRPRF USRPRF(SSHUSER1) HOMEDIR('/home/SSHUSER1') 
```

### Create the user home directory (skip if user home dir exists)
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
### Create SSH  public/private keys for user from 5250 session
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

The SSHUSER1 public and private key IFS files should now exist.   

Run the following command to verify the files exist:
```
WRKLNK OBJ('/home/SSHUSER1/.ssh/*') DSPOPT(*ALL)
```
You should see something like this to confirm the SSH public a private keys exist:   
```
                            Work with Object Links                            
                                                                              
Directory  . . . . :   /home/SSHUSER1/.ssh                                    
                                                                              
Type options, press Enter.                                                    
  2=Edit   3=Copy   4=Remove   5=Display   7=Rename   8=Display attributes    
  11=Change current directory ...                                             
                                                                              
Opt   Object link            Type     Attribute    Text                       
      .                      DIR                                              
      ..                     DIR                                              
      id_ed25519             STMF                                             
      id_ed25519.pub         STMF                                             
                                                                        Bottom
Parameters or command                                                         
===>                                                                          
F3=Exit   F4=Prompt   F5=Refresh   F9=Retrieve   F12=Cancel   F17=Position to 
F22=Display entire field           F23=More options                           
```
**id_ed25519** is the private key file. (don't give this to anyone)   
**id_ed25519.pub** is the public key file. (This file can be downloaded and uploaded/used on GitHub or other remote Git repos such as Azure Devops, GitLab, Bitbucket, etc for authentication. The public key gets associated to the git user in Github or the remote repository)

















