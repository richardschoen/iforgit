# iforgit
Welcome to iForGit - Git Integration for IBM i

http://www.mobigogo.net/files/docs/iforgit

iForGit is an IBM i specific source control application that allows Git to be more easily integrated with RDi development environments and traditional 5250 SEU development environments for working with source file members or IFS based source members and seamlessly integrating them a Git repository for version control.

iForGit is a nice alternative to expensive version control systems because you can use your own choice of online or self-hosted repositories (Github, Gitlab, Bonobo Git Server (Windows), Bitbucket or any other Git source server) as well as their associated tools for tickets, project management, continuous integration with IBM i, other custom source management workflows and more.

The process of source control can be made 100% transparent for SEU based developers so they don't have to remember to commit a source version. The STRSEUGIT command can be used to commit source members automatically any time they are edited with SEU.

The SRCFRMGIT and SRCTOGIT commands also make checking out, committing or syncing source very easy from SEU, RDi or your own source build applications on IBM i.

The SRCFRMSTMF and SRCTOSTMF commands also work for just simple importing and exporting of source members to the IFS for editing from the Integrated File System (IFS) and copying back to a source file.

The initial command set provides Git editing integration, however other features such as a 5250 client, web client, continuous integration and object management commands will be added if we see demand for this.
