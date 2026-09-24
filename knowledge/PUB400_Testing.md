# Testing iForGit Commands on PUB400 to version Git source
I have installed a working version of iForGit on PUB400.   

You can quickly test the basic functionality on PUB400 with a local repository. 

❗You can use iForGit with remote repos, but that takes a little more setup and should probably NOT be done on PUB400. 

**Reach out to MobiGoGo if you need help: richard@mobigogo.net**

## Setting up your job

### Set up for iForGit usage. (PUB400 is a Germany based system so make sure you use CCSID 37)
```
CHGJOB CCSID(37)
```

### Add IFORGIT to your lib list
```
ADDLIBLE LIB(IFORGIT)
```

### Set up your Git user name (one time)
Use your first and last name and email to set up so Git can identify your user in Git when commits are made.
```
SETGBLUSR USERNAME('FirstName LastName')               
      USEREMAIL(email@yourdomain.com)     
      DSPSTDOUT(*YES)                          
```

### Change Your User to Use iForGit PDM Options
Normally you can create these options on your system, but PUB400 locks things down for PDM options.

### Start up PDM
```
STRPDM
```
Take Option - 9. Work with user-defined options 

Set user defined options file:
File: ```QAUOOPTGIT```      
Library: ```IFORGIT```             
Member: ```QAUOOPTGIT```     

### Set up a git repository for your library
This example uses a user named ```BOB``` and library named ```BOBS1```.   
The repo will get created in a directory in BOBs home dir named ```/home/BOB/gitrepos/BOBS1```.   
The IFS repository directory will get auto-created during first export.
```
SETLIBREPO LIBRARY(BOBS1)                                     
           IFSREPODIR('/home/BOB/gitrepos/BOBS1')        
           ENABLEGIT(*YES)                                        
```
This command sets the GITENABLED and GITREPODIR data area values in your library. (Run one time).   

### First time export all source to your new git repo. (Repo auto-created)
```
LIBSRCEXP LIBRARY(BOBS1) STARTDATE(*ALL)           
```
This will create the Git repository and export to the IFS repo set in the previous step.  

### You can see your repo and exported source in the Git repository directory via WRKLNK
```
WRKLNK  OBJ('/home/BOB/gitrepos/BOBS1')
```

### Doing your first edit and commit

Go to PDM to work with a source file:   
```WRKMBRPDM```. 

Edit a CL or RPGLE source member and save it.  

Use PDM option ```GE``` to export changes to your Git repository. (F4 prompt if desired to see parameters).   

Use PDM option ```GI``` to import last member from Git repository and overlay existing local copy.

Use PDM option ```GV``` to view the Git history and view or restore a source member from repo.

**That concludes your first basic test of iForGFit.**

❗iForGit CL commands also work well with RDI and VS Code.   

To learn more or discuss your scenario please reach out to MobiGoGo LLC. 
Email: richard@mobigogo.net    
Web: https://www.iforgit.com   

Every shop has very different source versioning and deployment needs. Feel free to reach out to discuss your specific scenario.  




