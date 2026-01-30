# Create IBM i SSH User info for use with SSH/SFTP login, iForgit, Git, Github and Other Remote Git Repositories
This document covers the steps to create an SSH user to be able to connect with iForGit to remote Git repositories.

The private key file can also be used to connect from a PC or Mac to your IBM i over SSH. 

❗SSH users and public/private keys are the only safe way to use remote git repositories with IBM i.

# Set up SSH User Example
We will use a user name of ```SSHUSER1``` for this example.

❗Ideally each user connecting to a remote Git repository should have their own unique SSH public and private key. However you can use a shared SSH key as well for connecting if you don't want to create a unique SSH key file for each user.

### Create a user profile (skip if user exists)
```
CRTUSRPRF USRPRF(SSHUSER1) HOMEDIR('/home/SSHUSER1') 
```

### Create the user home directory (skip if user home dir exists)
```
MKDIR DIR('/home/SSHUSER1') DTAAUT(*INDIR) OBJAUT(*INDIR) 
```
### Create the user home .ssh directory (skip if user home dir exists)
```
MKDIR DIR('/home/SSHUSER1/.ssh') DTAAUT(*INDIR) OBJAUT(*INDIR) 
```

### Make the user owner of their home directory
```
CHGOWN OBJ('/home/SSHUSER1') NEWOWN(SSHUSER1) RVKOLDAUT(*YES) SUBTREE(*NONE)
```
### Make the user owner of their home .ssh directory
```
CHGOWN OBJ('/home/SSHUSER1/.ssh') NEWOWN(SSHUSER1) RVKOLDAUT(*YES) SUBTREE(*ALL)
```

### Exclude *PUBLIC users from access to the home and .ssh dir
```
CHGAUT OBJ('/home/SSHUSER1') USER(*PUBLIC) OBJAUT(*SAME) DTAAUT(*NONE)
CHGAUT OBJ('/home/SSHUSER1') USER(*PUBLIC) OBJAUT(*NONE) DTAAUT(*SAME)
CHGAUT OBJ('/home/SSHUSER1/.ssh') USER(*PUBLIC) OBJAUT(*SAME) DTAAUT(*NONE)
CHGAUT OBJ('/home/SSHUSER1/.ssh') USER(*PUBLIC) OBJAUT(*NONE) DTAAUT(*SAME)
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
❗The shorthand version of the above SSH key generation steps that could be used for additional users is: 
```
ssh-keygen -f /home/SSHUSER1/.ssh/id_ed25519 -t ed25519 -N ' '
```
Now run the following command to copy your public key to the authorized_keys file. This will allow SSHUSER1 to log in remotely via SSH and using the private key file: ```id_ed255419```    
```
cp /home/SSHUSER1/.ssh/id_ed25519.pub /home/SSHUSER1/.ssh/authorized_keys
```
Run the following commands to set permissions on your SSH key files and .ssh directory:
```
chmod 755 /home/SSHUSER1 
chmod 700 /home/SSHUSER1/.ssh 
chmod 600 /home/SSHUSER1/.ssh/authorized_keys
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
      authorized_keys        STMF                                         
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
**authorized_keys** is an IFS copy of the public key in the user home directory. This allows them to connect to the IBM i using their private key instead of needing to enter a password if they are using an SSH terminal client such as putty or the ssh command in Windows, Linux or MacOS. 
**Note:** This is not needed for hooking up to remote git repositories but it's good when you want secure access to the IBM i via an SSH terminal

## Results
The ```SSHUSER1``` user profile should be able to connect and log in to the IBM i system via an SSH terminal login using the private key file ```id_ed25519``` if the IBM i SSH server is enabled. Once logged in the user can run PASE, qsh or bash commands. The ```id_ed25519``` file should be downloaded to their PC or Mac system and properly secured for use with an ssh terminal.

More importantly the user should now be able to be connected to a GitHub or other remote git repository using the information from the public key file (```id_ed25519.pub```) once the public key file gets uploaded and associated with their GitHub or other remote repository user account.
