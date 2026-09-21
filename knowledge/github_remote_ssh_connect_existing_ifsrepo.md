# One time Github remote set up for remote repository
These are the steps to connect an existing local IFS based repository to a GitHub site and push the contents.   

This assumes your local Git repository was created before the remote.   

Log on to an IBM i 5250 session. You can also probably use an SSH session if desired.
 
Start QShell session or SSH terminal.     
```strqsh```
 
Change to Git repository directory.    
```cd /gitrepos/libname```  
 
Add remote origin for repository. This would typically be the URL to your remote repo along with Github user and password info.   

```git remote add origin git@github.com:githubsiteprofile/githubrepo.git```.  

Example site:   
```git remote add origin git@github.com:richardschoen/iforgit.git```.  

First time push sets the master.  
❗Your user profile must also have an ssh public and private key file generated in the ```~/.ssh directory``` for the selected user. And the public key must be set for the selected user in the GitHub repository.

```git push --set-upstream origin master```.    
 
❗All other subsequent pushes to remote can just use:  ```git push``` or ```*COMMITSYNC``` on all iForGit Commands

