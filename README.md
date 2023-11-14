# Start Managing IBM i Source Members with Git in 10 Minutes
IBM i Git Source Management Made Easy  

Implement Git for your Classic IBM i Source Version Control in Minutes  

## Welcome to iForGit - Git Client for IBM i Source Physical Files  

iForGit Information Document (PDF)   
<a href="https://github.com/richardschoen/iforgit/raw/master/iForGitInfo2023Q3.pdf">View iForGit Information Document</a>

iForGit Home Page  
https://www.iforgit.com  

Visit the iForGit Documentation  
https://www.mobigogo.net/files/docs/iforgit

Request an iForGit Demo  
<a href="mailto:info@mobigogo.net?">info@mobigogo.net</a>

## Overview
Git is the most popular source control versioning tool available for developers today. Git has been available natively on IBM i for IFS source management for several years. The biggest challenge with using Git for traditional IBM i developers has been the lack of seamless integration and management of SEU, PDM and source physical files with a Git repository for classic 5250 based source version control. RDi developers have tried iProjects and other methods to manage source in the IFS, but the result is often a complex and frustrating edit, compile and commit workflow experience that doesn’t feel natural because of the many manual steps.  

iForGit solves the problem of awkward IBM i Git source management with a native IBM i Git client interface allowing Git to be easily integrated with 5250 development workflows using SEU, PDM and RDi editors and custom user options. iForGit commands also work with SSH terminal sessions to integrate with editors such as VS Code and others that support SSH connectivity.  

IBM i developers can learn to use iForGit within minutes or source version commits can be fully automated so developers initially have zero learning curve.  

## Optionally use iForGit with other commercial or custom IBM i source/object build solutions
For more complete source management and automated build processes, iForGit commands can be used in conjunction with open and commercial IBM i enterprise source and project management toolsets if their git support is lacking or non-existent. ```(Aldon, Turnover, Arcad, MDCMS, etc)```

iForGit can also augment a custom source control/build solution if a development team has already implemented their own custom source management solution that doesn't integrate to git. 

iForGit brings the ability to version source code from all your source physical files to git no matter what you use today.    

## Highlights
•	Install and start versioning IBM i source with Git in minutes.  
•	Immediately add audited Git IBM i source management and compliance.  
•	Source code versioning can be made 100% automatic and transparent for developers.  
•	Works with PDM, SEU, RDi and VS Code to manage source versioning.  
•	Git repository backups can be scheduled for automatic hands-off source version commits.  
•	Local Git source repositories are managed in the IFS to augment existing source backups.  
•	Git repositories can live on-premise or in the cloud using a remote Git host such as:   
                  GitHub, Bitbucket, GitLab, GitBucket, Azure DevOps, Bonobo Git Server or any Git project hosting environment.  
•	Descriptive source member information can be stored in source member headers.   
•	Line numbers and date sequences can be retained to support SEU and RDi editing environments.  
•	Source change and audit info can be viewed with git log, show, diff or blame.   
•	Old source member versions can be easily restored to source library from a Git repository.  
•	Git source control can enhance and augment existing source control and build processes.  

## Detail

iForGit is an ***IBM i Specific Git Client*** application that allows Git to be more easily integrated with RDi development environments and traditional 5250 SEU development environments for working with source file members or IFS based source members and seamlessly integrating them with a Git repository for version control and the ability to visually review and compare changes.

The most common use case for this would be companies who have no IBM i source control systems in place, yet want to start doing more than just daily library backups. Or possibly there is a team of .Net or multi-platform developers using Git and the team wants to start managing IBM i source in the same place for compliance reasons.  

iForGit is an affordable alternative to expensive version control systems because you can use your own choice of online or self-hosted repositories (Github, Gitlab, Bonobo Git Server (Windows), Bitbucket or any other Git source server) as well as their associated tools for tickets, project management, continuous integration with IBM i, other custom source management workflows and more. iForGit simply becomes the source control mechanism.

The process of source control can initially be made 100% transparent for SEU, RDi and VS Code based developers (using scheduled auto-commits) so they don't have to remember to commit a source version. The ```STRSEUGIT``` command can be used with PDM to edit a member with SEU and auto commit the source members automatically any time they are edited and saved with SEU.

The ```SRCFRMGIT``` and ```SRCTOGIT``` commands also make checking out, committing or syncing source very easy from SEU, RDi or your own source build applications on IBM i.

The ```SRCFRMSTMF``` and ```SRCTOSTMF``` commands also work for just simple importing and exporting of source members to the IFS for editing from the Integrated File System (IFS) and copying back to a source file.

The ```GITCMD``` and ```GITQSH``` command can also be used to run general git commands over an IFS git repository from a traditional IBM i job stram if you're managing traditional PC-style git repositories in the Integrated File System (IFS)

The ```SRCGITCMD``` command can be used to view or check out old versions of a source member using the the SRCGITCMD CL command itself in a process or interactively as a PDM option or RDI user action. The following options are currently supported:   
Perform a ```git log``` command to see how many times a member has been committed and determine the git commit hash for checking out the member from your git repository.  
Perform a ```git blame``` command to show a consolidated view of the selected source member commits to determine what older version you may want to view or restore.
Perform a ```git diff``` command for a selected hash to see what has changed.  
Perform a ```git show``` command for a selected hash to show that version of the source member.  
Perform a ```git checkout``` command to check out a selected older version of a source member to a selected source physical file for viewing or working with it via PDM or RDI.  

The initial command set provides Git editing integration, however other features such as a 5250 client, web client, continuous integration and object management commands will be added if we see demand for this.

# iForGit Documentation Sitecommand to check out a selected older version of a source member to a selected source physical file for viewing or working with it via PDM or RDI.  

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

# SRCTOGIT - Export Member to Git Repo DIrectory
This CL command can be used to export/commit source member changes to the associated git repository.  

# SRCFRMGIT - Import Member from Git Repo DIrectory
This CL command can be used to import most recent commit versionfrom the associated git repository.  

If you want to import a specific version based on its commit hash, you can use the SRCGITCMD option with *CHECKOUT as the option and specify a destination source file and member.  

# SRCGITCMD - Run Git Cmd Against Repo Mbr  
This CL command can be used to view older git versions or check out an individual source member to a source physical file for viewing/editing.

# SRCGITCMD usage examples  

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

**SRCFILE** - The source file to work with via the associated iForGit git repository. 

**SRCMBR** - The source member to work with via the associated iForGit git repository. 

**IFSREPODIR** - The destination git repo IFS directory. This directory contains the path to the library's git directory associated with the library. Default - *LIBREPODTAARA points to the GITREPODIR data are in the source library specified on the SRCFILE parameter.

**SRCOPTION** - This is the git option to perform on the selected source member. 

```*BLAME``` - This option displays the entire source member change history in a consolidated view along with the short commit hash value and author name. This is good for getting a quick look at the commit history for a source member and knowing who performed each commit.  

```*BLAMELONG``` - This option displays the entire source member change history in a consolidated view along with the full commit hash value and author name. This is good for getting a quick look at the commit history for a source member and knowing who performed each commit.  

```*SHOW``` - This option displays the entire source file contents for a specific commit level. You must specify a member commit hash value or *MOSTRECENT in the SRCHASH parameter to show the most recent version file version.  

```*DIFF``` - This option does a diff based on the most recent version compared with the selected hash version. You must specify a member commit hash value or ```*MOSTRECENT``` in the SRCHASH parameter to show the most recent version file version.  

```*LOG```  -  Display the commit log along with the commit hash values for each commit of the source member. The folloing log values are displayed: commit hash, author info who performed the commit, commit date/time and comment. The full commit hash or the first 8 characters of the hash can be copied for use with the *CHECKOUT option to check out a source member version based on its commit hash value.  

```*CHECKOUT``` - Check out a selected commit version of a source member. You must specify a member commit hash value or blanks to check out most recent version in the SRCHASH parameter. The selected git version source file will get automatically populated into the following source member in library QTEMP for each user: QTEMP/TMPSOURCE. Member: TMPSOURCE  

**SRCHASH** - Source version hash to check out, view of compare. Use *BLAME or *LOG to determine available hash versions. Or you can use any of the git command options in PASE/SSH if you like the git to determine the hash version for a commit or source member.

**DEBUGQSSH** - Prompt GITQSH command to see the full git command line that gets generated. Only use this option interacively from a 5250 session for debugging purposes. Default-*NO
 
**DSPSTDOUT** - Display the outfile contents. Nice when debugging. 

**LOGSTDOUT** - Place STDOUT log entries into the current jobs job log. Use this if you want the log info in the IBM i joblog. All STDOUT entries are written as CPF message: **QSS9898**

**PRTSTDOUT** - Print STDOUT to a spool file. Use this if you want a spool file of the log output.

**DLTSTDOUT** - This option insures that the STDOUT IFS temp files get cleaned up after processing. All IFS log files get created in the /tmp/qsh directory.

**DSPCHKOUT** - Display checked out source member once checkout is complete if the SRCOPTION-*CHECKOUT is used to check out a git repo member.  Default - *NONE  

Options:  
```*NONE``` - Don't display the checked out source member after checkout when *CHECKOUT is used for the SRCOPTION parameter. Just cjeck out and create the selected source member, but don't view it.   

```*BROWSE``` - Open the source member for browsing via the SEU editor. If *NONE is specified for the DESTOPT parameter, the member created in QTEMP/TMPSOURCE named: TEMPSOURCE will be viewed. If *ADD/REPLACE is selected, the member specified in the DESTFILE/DESTMBR parameter will be used.  

```*EDIT``` -  Launch the source member for editing via the SEU editor.  If *NONE is specified for the DESTOPT parameter, the member created in QTEMP/TMPSOURCE named: TEMPSOURCE will be edited. If *ADD/REPLACE is selected, the member specified in the DESTFILE/DESTMBR parameter will be used.  

```*PDM``` - Perform a WRKMBRPDM command on the source member so it gets listed in PDM. Then PDM actions can be performed on the source member.  If *NONE is specified for the DESTOPT parameter, the member created in QTEMP/TMPSOURCE named: TEMPSOURCE will be listed via WRKPBMPDM. If *ADD/REPLACE is selected, the member specified in the DESTFILE/DESTMBR parameter will be used.  

**DESTFILE** - Checkout to destination source file. This is source file the checked out git member placed in after it has been checked out from the git repository if DESTOPT-*ADD/*REPLACE is selected. If DESTOPT - *NONE is specified, the source member only gets checked out to temporary file ```QTEMP/TMPSOURCE``` name ```TMPSOURCE```. *NONE insures that only temporary members are generated in library QTEMP and not persisted outside of library QTEMP.  
Default: QTEMP/TMPSOURCE  
  
This option is useful if you want to persist a checked out source member in a source library for comparison or other purposes.  

**DESTMBR** - The source mmmber name the checked out git member gets placed in to if DESTOPT-*ADD/*REPLACE is selected. Default - TMPSOURCE2

**DESTOPT** - Add or replace member records in the destination source file member. Default - *NONE  
  
```*NONE``` - The source member only gets checked out to temporary file ```QTEMP/TMPSOURCE``` with member name ```TMPSOURCE```. *NONE insures that only temporary members are generated in library QTEMP and not persisted outside of library QTEMP.  

```*ADD``` - If *ADD is specified, the source member gets auto-created in QTEMP/TMPSOURCE but then gets copied/persisted to the source file specified in the DESTFILE/DESTMBR option and records are added during the source copy. This allows a single destination source member to receive the contents of multiple versions of a git source member if desired.   

```*REPLACE``` - If *REPLACE is specified, the source member gets auto-created in QTEMP/TMPSOURCE but then gets copied/persisted to the source file specified in the DESTFILE/DESTMBR option and records are replaced during the source copy. This allows a single destination source member to receive the contents of a single git source member.    

# Automatic Rolling 7 Day Source Change Commits for a library - SAMPLE
This example call to the ```LIBSRCEXP``` command illustrates how to do a passive rolling 7 day commit of source member changes for a library. This is a great way to auto-commit any outstanding member changes daily if developers miss or don't do any commits during the day. Change commits should be captured as often as possible to keep ongoing change history current in case of the need to roll back changes. Individual member commits are usually done by each developer using the SRCTOGIT command which is used to commit changes for an individual source member to a git repository.

The ```LIBSRCEXP``` command can be placed on the job scheduler to run one or more times per day to passively capture source member changes to git. Developers don't have to initially change their existing edit, compile processes until they are ready to start doing individual source changes commts after editing to start maintaining a more granular source member change history.   

Source member comments will be timestamped with the IBM i job data and user ID who ran the job unless you enter your own custom comment.

```
IFORGIT/LIBSRCEXP LIBRARY(MYLIB)                  
          FILE(*ALL)                      
          STARTDATE(*LAST7)               
          ENDDATE(*STARTDATE)             
          IFSREPODIR(*LIBREPODTAARA)      
          SRCHEADER(*YES)                 
          REPLACE(*YES)                   
          VALIDREPO(*YES)                 
          IFSMKDIR(*YES)                  
          INITREPO(*YES)                  
          COMMITOPT(*COMMITSYNC)          
          COMMENT(*DATEUSER)              
          AUTHORITY(*INDIR)               
          JOBMSGQFUL(*WRAP)               
```

# Initializing or refreshing git repository with all source members for a library - SAMPLE
This example call to ```LIBSRCEXP``` illustrates how to export copies of all source members in a library to a git repository and auto-create the repository when setting up a repo for the first time. This command can also be run at the end of each month in case any source changes fall out of the 7 day rolling commit window and you didn't run the ```LIBSRCEXP``` with ```STARTDATE(*ROLLING7)``` every day for some reason. ```STARTDATE(*ALL)``` will catch up the git repository for all changes that may have been previously missed if you missed your daily commit schedule.   

The ```LIBSRCEXP``` command can be placed on the job scheduler to run one or more times per day to passively capture source member changes to git. Developers don't have to initially change their existing edit, compile processes until they are ready to start doing individual source changes commts after editing to start maintaining a more granular source member change history.   

Source member comments will be timestamped with the IBM i job data and user ID who ran the job unless you enter your own custom comment.
   
```
IFORGIT/LIBSRCEXP LIBRARY(MYLIB)                  
          FILE(*ALL)                      
          STARTDATE(*ALL)               
          ENDDATE(*STARTDATE)             
          IFSREPODIR(*LIBREPODTAARA)      
          SRCHEADER(*YES)                 
          REPLACE(*YES)                   
          VALIDREPO(*YES)                 
          IFSMKDIR(*YES)                  
          INITREPO(*YES)                  
          COMMITOPT(*COMMITSYNC)          
          COMMENT(*DATEUSER)              
          AUTHORITY(*INDIR)               
          JOBMSGQFUL(*WRAP)               
```

