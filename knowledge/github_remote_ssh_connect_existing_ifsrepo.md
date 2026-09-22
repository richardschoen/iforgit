# One time Github remote set up for local IFS repository

## Recommended Repo Setup and Connection to IBM i
Normally we recommend the following repository GitHub setup:
- Create Github repository. 
- Clone the repository to the IFS directory. 
```
cd /gitrepos
git clone git remote add origin git@github.com:githubsiteprofile/githubrepo.git
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
# Connecting an existing Local IFS Repository to GitHub
These are the steps to connect an existing local IFS based repository to a GitHub site and push the contents.   

This assumes your local Git repository was created before the remote repository.   

Log on to an IBM i 5250 session. You can also probably use an SSH session if desired.
 
Start QShell session or go to SSH terminal bash prompt.     
```strqsh```
 
Change to Git repository directory.    
```cd /gitrepos/libname```  
 
Add remote origin for repository. This would typically be the URL to your remote repo along with Github user and password info.   

```git remote add origin git@github.com:githubsiteprofile/githubrepo.git```.  

Example site:   
```git remote add origin git@github.com:richardschoen/iforgit.git```.  

❗  You have to do the following steps to rename the ```master``` branch that gets created automatically by iForgit when it first calls the git init command to create the rep. We will rename the repo from ```master``` to ```main``` which is now the GitHub default.  

**The branch name change thing is a change made by GitHub and other sites to use "main" as default branch instead of "master" a few year back.**

❗Your user profile must also have an ssh public and private key file generated in the ```~/.ssh directory``` for the selected user. And the public key must be set for the selected user in the GitHub repository.

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

❗All other subsequent pushes to remote can just use:  ```git push``` or ```*COMMITSYNC``` on all iForGit Commands

