# RDI User Actions for Managing Source with Git and iForGit   
The following are sample RDI actions that can be used with the iForGit commands to manage a git repository of source members from RDI.

You can use these sample RDI actions provided or create your own as desired.  

## Commit source member to Git Repo-SRCTOGIT 
Commit the selected source member to a git repository using the SRCTOGIT CL command.  We will prompt the user for teh CL command unless you uncheck the option to prompt first. 

Action Name: ```Commit Source Member to Git Repo-SRCTOGIT```    

Comment: ```Export source to git repository```   

Command: ```IFORGIT/SRCTOGIT SRCFILE(&L/&F) SRCMBR(&N) IFSREPODIR(*LIBREPODTAARA) SRCHEADER(*YES) SRCDATSEQ(*NO) REPLACE(*YES) EDITOPT(*NONE) VALIDREPO(*YES) IFSMKDIR(*YES) INITREPO(*YES) COMMITOPT(*COMMIT) COMMENT(*DATEUSER)```    

Prompt first - ```Check/enable this option to prompt before running action CL command```

Show action - ```Check/enable this option to make sure action is not hidden.```

Defined Types = ```ALL``` unless you want to limit to only selected source member types.   


