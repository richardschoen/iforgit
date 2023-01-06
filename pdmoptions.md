# PDM User Defined Options for iForGit

## GB - Git Blame  
```
IFORGIT/SRCGITCMD SRCFILE(&L/&F) SRCMBR(&N) IFSREPODIR(*LIBREPODTAARA)
SRCOPTION(*BLAME) SRCHASH(*MOSTRECENT) DSPSTDOUT(*YES)
```
## GC - Git Checkout
Use this option to check out an old version of a source member to source member: TMPSOURCE  
in source file: QTEMP/TMPSOURCE. TMPSOURCE gets auto-created during a checkout.  
If you want to select a specific git hash to check out, prompt for the SRCGITCOMD using F4.  

```
IFORGIT/SRCGITCMD SRCFILE(&L/&F) SRCMBR(&N) IFSREPODIR(*LIBREPODTAARA) SRCOPTION(*CHECKOUT) SRCHASH(' ') DSPSTDOUT(*NO) DSPCHKOUT(*BROWSE)
```
  
## GD - Git diff

```
IFORGIT/SRCGITCMD SRCFILE(&L/&F) SRCMBR(&N) IFSREPODIR(*LIBREPODTAARA) SRCOPTION(*DIFF) SRCHASH(*MOSTRECENT) DSPSTDOUT(*YES)  
```

## GE - Export Source Member to Git 
Use this option to send and commit current source member version to the git repository.
                                                                                
```
IFORGIT/SRCTOGIT SRCFILE(&L/&F) SRCMBR(&N) SRCHEADER(*YES) SRCDATSEQ(*NO) REPLACE(*YES)  
EDITOPT(*NONE) VALIDREPO(*YES) IFSMKDIR(*YES) INITREPO(*YES) COMMITOPT(*COMMITSYNC) COMMENT(*DATEUSER)  
```

## GI - Import Source Member from Git Repository
Use this option to import most recent commit back to the library source member.

```
IFORGIT/SRCFRMGIT IFSREPODIR(*LIBREPODTAARA) FROMIFSFIL(*LIBFILEPATH) SRCFILE(&L/&F) SRCMBR(&N)   
SRCTYPE('&T') SRCDATSEQ(*NO) VALIDREPO(*YES) COMMITOPT(*COMMIT)         
```

## GL - Git log

```
IFORGIT/SRCGITCMD SRCFILE(&L/&F) SRCMBR(&N) IFSREPODIR(*LIBREPODTAARA) SRCOPTION(*LOG) DSPSTDOUT(*YES)                           
```
## GS - Git show
   
```
IFORGIT/SRCGITCMD SRCFILE(&L/&F) SRCMBR(&N) IFSREPODIR(*LIBREPODTAARA) SRCOPTION(*SHOW) SRCHASH(*MOSTRECENT) DSPSTDOUT(*YES)     
```

## GT - git command
```
IFORGIT/GITCMD IFSREPODIR('/gitrepos/&l') CMDOPTS(('add .' 'commit -m "Commit"' pull push) DSPSTDOUT(*YES)
```


# Granular Git Member Processing with CL command SRCGITCMD

The SRCGITCMD command can be used to view or check out old versions of a source member using the the SRCGITCMD CL command itself in a process or interactively as a PDM option or RDI user action. Perform tasks such as Viewing Git History, Performing Diff or Blame operations and Checking Out/Restoring an Old Versions to a library for viewing or editing.

## Option - GL
Perform a git log command to see how many times a member has been committed and determine the git commit hash for checking out the member from your git repository.

Command: ```IFORGIT/SRCGITCMD SRCFILE(&L/&F) SRCMBR(&N) IFSREPODIR(*LIBREPODTAARA) SRCOPTION(*LOG) DSPSTDOUT(*YES)```

## Option GB
Perform a git blame command to show a consolidated view of the selected source member commits to determine what older version you may want to view or restore. Perform a git diff command for a selected hash to see what has changed.
                                                                                
Command: ```IFORGIT/SRCGITCMD SRCFILE(&L/&F) SRCMBR(&N) IFSREPODIR(*LIBREPODTAARA) SRCOPTION(*BLAME) SRCHASH(*MOSTRECENT) DSPSTDOUT(*YES)```

## Option GD  
Perform a git diff command for a selected hash to do a diff based on the most recent version compared with the selected hash version. You must specify a member commit hash value or *MOSTRECENT in the SRCHASH parameter to show the most recent version file version.  
                                                                                
Command: ```IFORGIT/SRCGITCMD SRCFILE(&L/&F) SRCMBR(&N) IFSREPODIR(*LIBREPODTAARA) SRCOPTION(*DIFF) SRCHASH(*MOSTRECENT) DSPSTDOUT(*YES)```

## Options GS
Perform a git show command for a selected hash to show that version of the source member. *MOSTRECENT will show the most recent commit.

Command: ```IFORGIT/SRCGITCMD SRCFILE(&L/&F) SRCMBR(&N) IFSREPODIR(*LIBREPODTAARA) SRCHASH(*MOSTRECENT) SRCOPTION(*SHOW) DSPSTDOUT(*YES)```

## Option GC 
Perform a git checkout command to check out a selected older version of a source member to a selected source physical file for viewing or working with it via PDM or RDI. By default the source member gets checked out to file: QTEMP/TMPSOURCE member: TMPSOURCE for being viewed via SEU. 

Note: This command can also be used to checkout the selected version and restore to the original source location or another work library is the DESTFILE/DESTMBR parameters are specified. 

Command: ```IFORGIT/SRCGITCMD SRCFILE(&L/&F) SRCMBR(&N) IFSREPODIR(*LIBREPODTAARA) SRCOPTION(*CHECKOUT) SRCHASH(' ') DSPSTDOUT(*NO) DSPCHKOUT(*BROWSE)```

