# Welcome to iForGit - Git Client for IBM i Source Physical Files

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

# iForgit CL Commands

# Using the SRCGITCMD CL command to view older git versions or check out an individual source member to a source physical file for viewing/editing.

The following example checks out a copy of the selecte source member to a source file named TMPSOURCE in library QTEMP. The source member is then viewed via SEU. 

 ``` 
      IFORGIT/SRCGITCMD SRCFILE(RJSDEVMB/SRCGIT)           
      SRCMBR(AAAAAAAXC)                  
      IFSREPODIR(*LIBREPODTAARA)         
      SRCOPTION(*CHECKOUT)               
      SRCHASH(' ')                       
      DSPSTDOUT(*NO)                     
      DSPCHKOUT(*BROWSE)                 
```

# SRCGITCMD command parms

**Overview** - This CL command command to view older git versions or check out an individual source member to a source physical file for viewing/editing.

**SRCFILE** - The source file to work with via the associated iForGit git repository. 

**SRCMBR** - The source mmmber to work with via the associated iForGit git repository. 

**IFSREPODIR** - The destination git repo IFS directory. This directory contains the path to the library's git directory associated with the library. Default - *LIBREPODTAARA points to the GITREPODIR data are in the source library specified on the SRCFILE parameter.

**SRCOPTION** - This is the git option to perform on the selected source member.  
*SHOW      
*BLAME     
*DIFF      
*LOG       
*CHECKOUT  

**SRCHASH** - Source version hash to check out, view of compare. Use *BLAME or *LOG to determine available hash versions. Or you can use any of the git command options in PASE/SSH if you like the git to determine the hash version for a commit or source member.

**DEBUGQSSH** - Prompt GITQSH command to see the full git command line that gets generated. Only use this option interacively from a 5250 session for debugging purposes. Default-*NO
 
**DSPSTDOUT** - Display the outfile contents. Nice when debugging. 

**LOGSTDOUT** - Place STDOUT log entries into the current jobs job log. Use this if you want the log info in the IBM i joblog. All STDOUT entries are written as CPF message: **QSS9898**

**PRTSTDOUT** - Print STDOUT to a spool file. Use this if you want a spool file of the log output.

**DLTSTDOUT** - This option insures that the STDOUT IFS temp files get cleaned up after processing. All IFS log files get created in the /tmp/qsh directory.

**DSPCHKOUT** - Display checked out source member once checkout is complete.  Default - *NONE  

Options:  
*NONE - Don't display the checked out source member after checkout when *CHECKOUT is is used for the SRCOPTION parameter.  
*BROWSE - Launch the source member for browsing via the SEU editor.      
*EDIT -  Launch the source member for editing via the SEU editor.  
*PDM - Perform a WRKMBRPDM on the source member so it gets listed in PDM. Then PDM actions can be performed on the source member.  

**DESTFILE** - Checkout to destination source file. The source file the checked out git member placed in after it has been checked out from the git repository. If DESTOPT - *NONE is specified, the source member only gets checked out to temporary file ```QTEMP/TMPSOURCE``` with member name ```TMPSOURCE```. *NONE insures that only temporary members are generated in library QTEMP and not persisted outside of library QTEMP.  
Default: QTEMP/TMPSOURCE

**DESTMBR** - The source mmmber the checked out git member gets placed in to. Default - TMPSOURCE2

**DESTOPT** - Add or replace member records in the destination source file member. Default - *NONE  
  
Options:
*NONE - The source member only gets checked out to temporary file ```QTEMP/TMPSOURCE``` with member name ```TMPSOURCE```. *NONE insures that only temporary members are generated in library QTEMP and not persisted outside of library QTEMP.
*ADD - If *ADD is specified, the source member gets auto-created in QTEMP/TMPSOURCE but then gets copied/persisted to the source file specified in the DESTFILE/DESTMBR option and records are added during the source copy. This allows a single destination source member to receive the contents of multiple versions of a git source member if desired.  
*REPLACE - If *REPLACE is specified, the source member gets auto-created in QTEMP/TMPSOURCE but then gets copied/persisted to the source file specified in the DESTFILE/DESTMBR option and records are replaced during the source copy. This allows a single destination source member to receive the contents of a single git source member.  


