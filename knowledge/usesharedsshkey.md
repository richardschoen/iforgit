# Configuring your IBM i Git repository configs to use a shared GitHub SSH Key
This article discusses setting up your local Git repository config (.gitconfig) for each Git repo to 
utilize a private key stored in the user's home directory. Or the private key can be placed 
in a shared common location so all IBM i users using iForGit can use the same SSH private key without 
storing the key inside the ```.gitconfig``` file.

This example uses GitHub, but the same technique should also work with any other SSH based 
Git repository you want to push Git repository code changes to.

## Example .gitconfig where each user has their own private key in their home directory for Git use with IBM i repos
The sample git configuration below illustrates how you might set up a GitHub SSH public key for 
each individual Git repository user on their GitHub account and then utilize their private key file 
without placing the key value itself into the Git repo configuration file. This example uses ```id_rsa``` as the 
example key file name for each user. However if you want to differentiate git private keys from the user's
regular SSH key you can name the user's private key file for GitHub something like: ```id_github```.   

First add the user's public key to their GitHub user account so that it can be connected to with SSH.   

Next, edit the ```.gitconfig``` file for each relevent GitHub repository to point to the user's 
private key info so Git will look for each users' private key automatically during commits
with one simple change.

This example utilizes an SSH private key file placed in the user's home directory. 
And the private key file is named ```id_rsa```. Adding the ```sshcommand```
directive will use the user's home directory to locate their private key 
when they attempt to commit and push changes from a shared IBM i Git repository.
```
 sshcommand = ssh -i ~/.ssh/id_rsa                     
```

The entire ```.gitconfig``` may look as follows:
```
[core]                                                   
 repositoryformatversion = 0                             
 filemode = true                                         
 bare = false                                            
 logallrefupdates = true                                 
 ignorecase = true                                       
 sshcommand = ssh -i ~/.ssh/id_rsa                 
[remote "origin"]                                        
 url = ssh://git@github.com:/mygithubsite/GITTEST123    
 fetch = +refs/heads/*:refs/remotes/origin/*             
[branch "master"]                                        
 remote = origin                                         
 merge = refs/heads/master                               
[pull]                                                   
```

## Example .gitconfig where a shared SSH private key can be used to commit and push changes to GitHub from IBM i repos
The sample git configuration below illustrates how you might set up a GitHub SSH public key for 
a single shared user on GitHub and then utilize a shared private key file without placing 
the key value itself into your configuration. This example uses a shared private key file named
```id_github``` as the example SSH private key file name. 

First add the shared user's public key to their GitHub user account so that it can be connected to with SSH.

The sample git configuration below illustrates how you might set up a GitHub SSH public key for 
a shared  Git repository user and then utilize the shared private key file without placing the key 
itself into your configuration.

This example utilizes an SSH private key placed in a shared IFS directory ```/gitrepos/.ssh```. 
And the private key file is named ```id_githubssh```
```
 sshcommand = ssh -i /gitrepos/.ssh/id_githubssh                 
```

The entire ```.gitconfig``` may look as follows:
```
[core]                                                   
 repositoryformatversion = 0                             
 filemode = true                                         
 bare = false                                            
 logallrefupdates = true                                 
 ignorecase = true                                       
 sshcommand = ssh -i /gitrepos/.ssh/id_githubssh                 
[remote "origin"]                                        
 url = ssh://git@github.com:/mygithubsite/GITTEST123    
 fetch = +refs/heads/*:refs/remotes/origin/*             
[branch "master"]                                        
 remote = origin                                         
 merge = refs/heads/master                               
[pull]                                                   
```

