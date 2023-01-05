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
IFORGIT/SRCTOGIT SRCFILE(&L/&F) SRCMBR(&N) SRCHEADER(*YES) SRCDATSEQ(*NO) REPLACE(*YES) EDITOPT(*NONE) VALIDREPO(*YES) IFSMKDIR(*YES) INITREPO(*YES) COMMITOPT(*COMMITSYNC) COMMENT(*DATEUSER)
```

## GI - Import Source Member from Git Repository
Use this option to import most recent commit back to the library source member.

```
IFORGIT/SRCFRMGIT IFSREPODIR(*LIBREPODTAARA) FROMIFSFIL(*LIBFILEPATH) SRCFILE(&L/&F) SRCMBR(&N) SRCTYPE('&T') SRCDATSEQ(*NO) VALIDREPO(*YES) COMMITOPT(*COMMIT)         
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
