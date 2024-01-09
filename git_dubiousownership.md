## IBM i developer getting dubious ownership error when non-owner repo user tries to commit changes
Whether using the iForGit ```SRCTOGIT``` command or just using the git command from QShell, PASE or SSH, the following error occurs for any user who doesn't own the git repository.   

Example of error in IBM i job log or git command line:
```
fatal: detected dubious ownership in repository at '/gitrepos/gittest123'.
To add an exception for this directory, call:.                            
.                                                                         
git config --global --add safe.directory /gitrepos/gittest123.
```

## Cause
Looks like this error just started occurring as of git version ```2.35.2``` Git is being more strict on dir ownerships of local repos. 

As of 1/8/2024, the newest available version of git on IBM i is ```2.39.3``` which means this error can start to occur. 

Here’s a sample link to read about it:   
https://stackoverflow.com/questions/73485958/how-to-correct-git-reporting-detected-dubious-ownership-in-repository-withou

## Resolution
In the last line of the article it shows the following git config change which is probably the appropriate resolution.

Run the following command from each users SSH session or via STRQSH one time only.  
```git config --global safe.directory '*'```      

Or have each developer run the following CL commands:   
```IFORGIT/GITQSH CMDLINE('git config --global --add safe.directory ''*''') DSPSTDOUT(*NO)```   

After running this once for each IBM i git user they should no longer see this issue.    
               
When I tested, this seemed to solve it from my test environment with V7R4. 
