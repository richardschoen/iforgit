# One time Github remote set up for local IFS repository
There are two ways to connect a GitHub repository to the IFS repo for use with iForGit:
- Scenario 1: You have a brand new GitHub repo and you want to connect it to IBM i before exporting source from your IBM i source files.
- Scenario 2: You have a brand new GitHub repo and you want to connect it to an existing IFS based Git repository. You were keeping your Git repos local in the IFS and are now starting to connect them to GitHub as you evolve to start using GitHub.    

❗Your user profile must also have an ssh public and private key file generated in the ```~/.ssh directory``` for the selected user. And the public key must be set for the selected user in the GitHub repository before attempting to connect to your GitHub repository from IBM i.

## Scenario 1 - Recommended Brand New Repo Setup and Connection to IBM i
Normally we recommend the following repository GitHub setup:
- Create Github repository. (Use IBM i library name if possible).    
- Clone the repository to the IFS directory.    
```
cd /gitrepos
git clone git@github.com:githubsiteprofile/githubrepo.git
```
- Make a source member change in selected library.
- Run the GE PDM option or SRCTOGIT command with the *COMMITSYNC option
Example committing source member HELLO:    
```
IFORGIT/SRCTOGIT SRCFILE(LIBNAME/QRPGLESRC)      
                 SRCMBR(HELLO)                      
                 SRCHEADER(*YES)                    
                 SRCDATSEQ(*NO)                     
                 REPLACE(*YES)                      
                 EDITOPT(*NONE)                     
                 VALIDREPO(*YES)                    
                 IFSMKDIR(*YES)                     
                 INITREPO(*YES)                     
                 COMMITOPT(*COMMITSYNC)             
                 COMMENT(*DATEUSER)
```
If the commit succeeds, all is good. If needed reach out to MobiGoGo support to review your set up.

## Scenario 2 - Connecting an existing Local IFS Repository to GitHub
These are the steps to connect an existing local IFS based repository to a GitHub site and push the existing contents and Git history.   

This assumes your local Git repository was created before the remote repository.   

Log on to an IBM i 5250 session. You can also probably use an SSH session if desired.
 
Start QShell session or go to SSH terminal bash prompt.     
```strqsh```
 
Change to Git repository directory.    
```cd /gitrepos/libname```  
 
Add remote origin SSH URL for repository (Can find in GitHub). This would typically be the URL to your remote repo. For SSH always use: git@github.com as the user. GitHub knows your SSH public and private keys based on how you set them up on GitHub and the IBM i.     

```git remote add origin git@github.com:githubsiteprofile/libname.git```.  

Example site named ```libname``` on site, richardschoen:   
```git remote add origin git@github.com:richardschoen/libname.git```.  

❗  You have to do the following steps to rename the ```master``` branch that gets created automatically by IBM i and iForgit when it first calls the ```git init``` command to create the repo on the IFS. We will rename the repo from ```master``` to ```main``` which is now the GitHub default.  

**The branch name change thing is a change made by GitHub and other sites to use "main" as default branch instead of "master" a few years back.**

Check to see if your your repo branch is master or main:
```git status```. 

If it says: ```On branch main``` your repo is already set to main, so you only need to do the following step:   
```
git push --set-upstream origin main
```

Otherwise you need to rename the master branch to main in the IFS, get the remote repo, merge the remote repo with the local repo allowing unrelated histories. Then do a first time push ignoring setting the upstream GitHub remote repo be main.   
```
git switch main
git fetch origin
git merge origin/main --allow-unrelated-histories
git push --set-upstream origin main
```
## Your GitHub and local IFS repositories should now be connected
❗All other subsequent pushes to remote can just use:  ```git push``` or ```*COMMITSYNC``` on all iForGit Commands.    

 **If needed reach out to MobiGoGo support to review your set up.**

## Viewing your .git/config file
In case you want to look at your ```.git/config``` file within your repository with EDTF or from PASE or Midnite Commander it should look like this:
```
[core]
        repositoryformatversion = 0
        filemode = true
        bare = false
        logallrefupdates = true
        ignorecase = true
[remote "origin"]
        url = git@github.com:richardschoen/libname.git
        fetch = +refs/heads/*:refs/remotes/origin/*
[branch "main"]
        remote = origin
        merge = refs/heads/main
```
