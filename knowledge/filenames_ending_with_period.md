# iForGit - Fixing Source Members with No Source Type
If checking out a git repository with IBM i source members in it from Windows, you may get an **invalid path error** if a file name ends with a period. Windows does not like file names that end with a period.      

The following steps outline how to fix the repository and the source member names so the issue doesn't happen again. 

### Steps to Fix Up Your Git Repository and Library Source Members with No Source Type
To fix an issue with a source member that has no extension and won't allow you to clone the repository to windows, do the following steps:

-  To prevent the issue from happening again the next time you commit source members, add a source type such as TXT to the source member in your library source physical files. For our example let's assume a source member name of: **SRC001** exists in our library in source file QCLSRC. Add the source type of: **TXT**.

- Log in to your git remote host (GitHub, GitLab, etc.) and rename the source members to have an extension in your git repository. (You can also do it via the git command line if you know what you're doing). 
  Ex: If source member name was **SRC001** with no extension, the file name in the git repo is probably currently set to to be **SRC001.** with a period ending the name. You should rename the file in the respository to something like: **SRC001.TXT**. Now your source physical file and remote repository are lined up. 

- To sync the local git repository for the library withe the remote name changes, log in via SSH or PASE and change to the git repository directory (EX: /gitrepos/qgpl) in the the IFS where the repository resides. Run the **git pull** command. This will force the file rename we did in the remote git repository to update the local IFS repo copy.  

- After this is done, run the **git status** (to show status of local git repo copy) and **git remote** show origin (to show the status of local and remote repository).

If you don't see any errors, both repositories are in sync. 

Next time the source members are pushed to the github repository all should work as expected since you renamed the members in the git repository and also added a corresponding source type to the source member.

