# Configuring your repository to use a shared GitHub SSH Key
This article discusses setting up your local Git repository config to 
utilize a private key stored in the user's home directory or a share common location 
so all the IBM i users using iForGit can use the same SSH private key without 
storing the key inside the ```.gitconfig``` file.

This example uses GitHub, but the same technique should also work with any other SSH based 
Git repository you want to push code changes to.

## Each user has their own private key in their home directory
The sample git configuration below illustrates how you might set up a GitHub SSH public key for 
each individual Git repository user on GitHub and then utilize their private key file 
without placing the key itself into your configuration. This example uses ```id_rsa``` as the 
example key file name. However if you want to differentiate git private keys you can 
name the user's private key file for GitHub something like: ```id_github```.

First add the user's public key to their GitHub user account so that it can be connected to with SSH.

Next, edit the ```.gitconfig``` file for each relevent GitHub repository to the private key info so 
it will look for each users' private key automatically with one simple change.

This example utilizes an SSH private key placed in the user's home directory. 
And the private key file is named ```id_rsa```. Adding the ```sshcommand```
directive will use the user's home directory to locate their private key 
when they attempt to commit and ush changes from a shared IBM i Git repository.
```
 sshcommand = ssh -i ~/.ssh/id_githubssh                 
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
 url = ssh://git@github.com:/mysite/GITTEST123    
 fetch = +refs/heads/*:refs/remotes/origin/*             
[branch "master"]                                        
 remote = origin                                         
 merge = refs/heads/master                               
[pull]                                                   
```


In this example my private key is in a home directory, but you could place the key in a hard coded 
directory so 

## Each user has a private key in their home directory
The sample git configuration below illustrates how you might set up a GitHub SSH public key for 
each individual Git repository user then utilize their private key file without placing the key 
itself into your configuration.

This example utilizes an SSH private key placed in the user's home directory. 
And the private key file is named ```id_githubssh```
```
 sshcommand = ssh -i ~/.ssh/id_githubssh                 
```

In this example my private key is in a home directory, but you could place the key in a hard coded 
directory so 


