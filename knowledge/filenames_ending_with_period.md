To fix an issue with a source member that has no extension and won't allow you to clone the repository.

Log in to your git remote host (GitHub, GitLab, etc.) and rename the source members to have an extension. 
Ex: If source member name was SRC001 with no extension, the file name in the git repo is probably currently set to to be SRC001. with a period ending the name.

Log in to the IFS where the repository resides and do a git pull command. This will force the file rename to the local IFS repo copy.

To prevent the issue from happening again the next time you cmmit source members, add a source type such as TXT to the source member in your library source physical files. 

Next time the source members are pushed to the github repository all should work as expected since you renamed the members in the git repository and also added a source type to the source member.

