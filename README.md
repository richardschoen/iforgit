# iforgit
Welcome to iForGit - Git Client for IBM i Source Physical Files

http://www.iforgit.com  
http://www.mobigogo.net/files/docs/iforgit

iForGit is an ***IBM i Specific Git Client*** application that allows Git to be more easily integrated with RDi development environments and traditional 5250 SEU development environments for working with source file members or IFS based source members and seamlessly integrating them with a Git repository for version control and the ability to visually review and compare changes.

The most common use case for this would be companies who have no IBM i source control systems in place, yet want to start doing more than just daily library backups. Or possibly there is a team of .Net or multi-platform developers using Git and the team wants to start managing IBM i source in the same place for compliance reasons.  

iForGit is an affordable alternative to expensive version control systems because you can use your own choice of online or self-hosted repositories (Github, Gitlab, Bonobo Git Server (Windows), Bitbucket or any other Git source server) as well as their associated tools for tickets, project management, continuous integration with IBM i, other custom source management workflows and more. iForGit simply becomes the source control mechanism.

The process of source control can initially be made 100% transparent for SEU, RDi and VS Code based developers (using scheduled auto-commits) so they don't have to remember to commit a source version. The ```STRSEUGIT``` command can be used with PDM to edit a member with SEU and auto commit the source members automatically any time they are edited and saved with SEU.

The ```SRCFRMGIT``` and ```SRCTOGIT``` commands also make checking out, committing or syncing source very easy from SEU, RDi or your own source build applications on IBM i.

The ```SRCFRMSTMF``` and ```SRCTOSTMF``` commands also work for just simple importing and exporting of source members to the IFS for editing from the Integrated File System (IFS) and copying back to a source file.

The ```GITCMD``` and ```GITQSH``` command can also be used to run general git commands over an IFS git repository from a traditional IBM i job stram if you're managing traditional PC-style git repositories in the Integrated File System (IFS)

The ```SRCGITCMD``` command can be used to do view or check out old versions of a source member using the the SRCGITCMD CL command itself in a process or interactively as a PDM option or RDI user action:  
Perform a ```git log``` command to see how many times a member has been committed and determine the git commit hash for checking out the member from your git repository.  
Perform a ```git blame``` command to show a consolodated view of the selected source member commits to determine what older version you may want to view or restore.
Perform a ```git diff``` command for a selected hash to see what has changed.  
Perform a ```git show``` command for a selected hash to show that version of the source member.  
Perform a ```git checkout``` command to check out a selected older version of a source member to a selected source physical file for viewing or working with it via PDM or RDI.  

The initial command set provides Git editing integration, however other features such as a 5250 client, web client, continuous integration and object management commands will be added if we see demand for this.

# iForGit Documentation Site
https://www.mobigogo.net/files/docs/iforgit




# iForGit Wiki Page for KB Articles
https://github.com/richardschoen/iforgit/wiki

# iForGit Issues Page to Report Issues
https://github.com/richardschoen/iforgit/issues

# iForGit web site
Check out the http://iforgit.com site above and request a demo if you think it might fit your IBM i source management needs.

# Other helpful git links

Git documentation\
https://git-scm.com/docs

# Questions or issues
If you have any questions or issues to report, please use this repository or email support: info@mobigogo.net. This site is also where source examples for using iForgit will be posted as documents.

