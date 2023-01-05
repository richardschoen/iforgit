# PDM User Defined Options for iForGit

## GB - Git Blame  
```
IFORGIT/SRCGITCMD SRCFILE(&L/&F) SRCMBR(&N) IFSREPODIR(*LIBREPODTAARA)
SRCOPTION(*BLAME) SRCHASH(*MOSTRECENT) DSPSTDOUT(*YES)
```
## GC - Git Checkout
```
Use this option to check out an old version of a source member to source member: TMPSOURCE  
in source file: QTEMP/TMPSOURCE. TMPSOURCE gets auto-created during a checkout.  
If you want to select a specific git hash to check out, prompt for the SRCGITCOMD using F4.  

IFORGIT/SRCGITCMD SRCFILE(&L/&F) SRCMBR(&N) IFSREPODIR(*LIBREPODTAARA) 
SRCOPTION(*CHECKOUT) SRCHASH(' ') DSPSTDOUT(*NO) DSPCHKOUT(*BROWSE)
```
  
   Option  . . . . . . . . :   GD                                               
                                                                                
   Command . . . . . . . . :   IFORGIT/SRCGITCMD SRCFILE(&L/&F) SRCMBR(&N) IFSRE
PODIR(*LIBREPODTAARA) SRCOPTION(*DIFF) SRCHASH(*MOSTRECENT) DSPSTDOUT(*YES)     


   Option  . . . . . . . . :   GE                                               
                                                                                
   Command . . . . . . . . :   IFORGIT/SRCTOGIT SRCFILE(&L/&F) SRCMBR(&N) SRCHEA
DER(*YES) SRCDATSEQ(*NO) REPLACE(*YES) EDITOPT(*NONE) VALIDREPO(*YES) IFSMKDIR(*
YES) INITREPO(*YES) COMMITOPT(*COMMITSYNC) COMMENT(*DATEUSER)                   

   Option  . . . . . . . . :   GI                                               
                                                                                
   Command . . . . . . . . :   IFORGIT/SRCFRMGIT IFSREPODIR(*LIBREPODTAARA) FROM
IFSFIL(*LIBFILEPATH) SRCFILE(&L/&F) SRCMBR(&N) SRCTYPE('&T') SRCDATSEQ(*NO) VALI
DREPO(*YES) COMMITOPT(*COMMIT)                                                  

   Option  . . . . . . . . :   GL                                               
                                                                                
   Command . . . . . . . . :   IFORGIT/SRCGITCMD SRCFILE(&L/&F) SRCMBR(&N) IFSRE
PODIR(*LIBREPODTAARA) SRCOPTION(*LOG) DSPSTDOUT(*YES)                           

   Option  . . . . . . . . :   GS                                               
                                                                                
   Command . . . . . . . . :   IFORGIT/SRCGITCMD SRCFILE(&L/&F) SRCMBR(&N) IFSRE
PODIR(*LIBREPODTAARA) SRCOPTION(*SHOW) SRCHASH(*MOSTRECENT) DSPSTDOUT(*YES)     

   Option  . . . . . . . . :   GT                                                
                                                                                 
   Command . . . . . . . . :   IFORGIT/GITCMD IFSREPODIR('/gitrepos/&l') CMDOPTS(
('add .' 'commit -m "Commit"' pull push) DSPSTDOUT(*YES)                         
















  
  
  
