# Check out source member version copy using SRCGITCMD CL command
The git checkout option is a nice git way to check out a working copy of a source member 
from a git repository for work.

The ```SRCGITCMD``` CL command ```*CHECKOUT``` option is a way to check out a git source member from a git repository via CL command call or PDM option, RDI action or VS Code action. The member is 
automatically checked out to a temporary source member in QTEMP for viewing. The source member can 
be optionally restored to a selected library location as well for further work on the source member. 

Checkout use cases:  
- Simply view a selected version of a source member from your git library repository.
- Check out a temp copy of a selected source member version for viewing from RDI or VS Code.   
- Check out a copy of a selected source member version to a work library under the same name or a new name.

**NOTE:** The checkout option is simply grabbing a copy of the selected source member git version to a 
source physical file for viewing or editing. The source member is not actually being checked out 
like a library book. If desired you can check out a source member and overlay/replace an existing source member, but caution should be exercised so you don't overlay a production level source member if 
you restore to a library other than ```QTEMP``` or ```IFORGITTMP```.

## Examples of using the SRCGITCMD *CHECKOUT option

### Checkout to QTEMP/TMPSOURCE(TMPSOURCE) for simple SEU viewing
This variation of the *CHECKOUT option should be used to simply checkout and 
view a temporary copy of the source member. During checkout the source 
member: QTEMP/TMPSOURCE(TMPSOURCE) always gets created. This temp source member 
is used for viewing or as a source location for copying to a selected destination source member.  

The important command options for this command variation are: 
```
DESTFILE(*IFORGITMP)
DESTOPT(*NONE)
DSPCHKOUT(*BROWSE)
SRCHASH(' ')        
```
These parameters tell the command we simply want to check out the source member to the 
QTEMP/TMPSOURCE location and view it.

**NOTE:** Make sure to specify a git source hash version by using the ```SRCHASH``` parameter. Blanks will return the most recently committed version of a source member. 

#### Example checkout usage to QTEMP/TMPSOURCE for simple member viewing with SEU/PDM
Check out source member HELLO to QTEMP/TMPSOURCE(TMPSOURCE).  
We always create this source member during *CHECKOUT process.  
When DESTOPT = *NONE, this is the member checked out to.  
Use this to view the TMPSOURCE member from QTEMP/TMPSOURCE source file.   
``` 
IFORGIT/SRCGITCMD SRCFILE(GITTEST123/QRPGLESRC)         
                  SRCMBR(HELLO)                         
                  IFSREPODIR(*LIBREPODTAARA)            
                  SRCOPTION(*CHECKOUT)                  
                  SRCHASH(' ')                          
                  DSPSTDOUT(*NO)                        
                  DSPCHKOUT(*BROWSE)                    
                  DESTFILE(*IFORGITMP)                  
                  DESTMBR(TMPSOURCE2)                        
                  DESTOPT(*NONE)                     
                  WRITETOTMP(*YES)                      
                  TMPDESTOPT(*IFORGITMP)                
                  TMPDESTUSR(*CURRENT)                  
```

### Checkout to source member in IFORGITTMP/CURUSER(MBRNAME)
The use case for this variation would be to check out a temporary copy of a member for viewing
or working with in RDI or VS Code. Since these editors can't view the checkout directly, 
the next best thing is to check it out to a consistent temporary location by user id and 
then open in RDI or VS Code to view from the IFORGITTMP/CURUSER source file location.

This variation of the *CHECKOUT option will check out a copy of a source
member to the IFORGITTMP library. A source file is auto-created for the current user. And 
the member name will be as specified on the DESTMBR parameter.

The important command options for this command variation are: 
```
DESTFILE(*IFORGITMP)
DESTMBR(*SRCMBR)
DESTOPT(*REPLACE)
DSPCHKOUT(*NONE)
TMPDESTOPT(*IFORGITMP)                
TMPDESTUSR(*CURRENT)
SRCHASH(' ')                    
```
These parameters tell the command we simply want to check out the source member to the 
IFORGITTMP/CURUSER(MBRNAME) location without doing any viewing. 

**NOTE:** Make sure to specify a git source hash version by using the ```SRCHASH``` parameter. Blanks will return the most recently committed version of a source member. 

**RDI/VS Code NOTE:** The developer will need to set up a source filter in RDI or VS Code to access the
IFORGITTMP/CURUSER source file and view any members you've checked out here.

#### Example checkout usage for IFORGITTMP/CURUSER(MBRNAME) for viewing with RDI/VS Code 
Check out source member HELLO to QTEMP/TMPSOURCE(TMPSOURCE).
We always create this source member during *CHECKOUT process.
Check out source member to IFORGITTMP/CURUSER(MBRNAME) as member name.
When DESTOPT = *ADD we add/append to the IFORGITTMP/CURUSER(MBRNAME) member.
When DESTOPT = *REPLACE we replace the IFORGITTMP/CURUSER(MBRNAME) member. 
```
IFORGIT/SRCGITCMD SRCFILE(YOURPRDLIB/QRPGLESRC)         
                  SRCMBR(HELLO)                         
                  IFSREPODIR(*LIBREPODTAARA)            
                  SRCOPTION(*CHECKOUT)                  
                  SRCHASH(' ')                          
                  DSPSTDOUT(*NO)                        
                  DSPCHKOUT(*NONE)                    
                  DESTFILE(*IFORGITMP)                  
                  DESTMBR(*SRCMBR)                        
                  DESTOPT(*REPLACE)                     
                  WRITETOTMP(*YES)                      
                  TMPDESTOPT(*IFORGITMP)                
                  TMPDESTUSR(*CURRENT)                  
```

### Checkout source version copy to selected library and member name
The use case for this variation would be to check out a copy of a source member version to your own 
development library or other library to work with it. You can check out and restore the 
the source member copy under its original source member name or under a specified member name.

The important command options for this command variation are: 
```
DESTFILE(YOURDEVLIB/QRPGLESRC)  
DESTMBR(*SRCMBR)           
DESTOPT(*REPLACE)
DSPCHKOUT(*NONE)
TMPDESTOPT(*IFORGITMP)                
TMPDESTUSR(*CURRENT)
SRCHASH(' ')        
```
These parameters tell the command we simply want to check out the source member to the 
specified source file and member name. ```YOURDEVLIB``` can be whatever library you want to use.

#### Example checkout usage to your selected development or work library 
Check out source member HELLO to QTEMP/TMPSOURCE(TMPSOURCE).   
We always create this source member during *CHECKOUT process.    
Check out source member to dev lib YOURPRDLIB/QRPGLESRC(HELLO) as member name.  
When DESTOPT = *ADD we add/append to the IFORGITTMP/CURUSER(MBRNAME) member.  
When DESTOPT = *REPLACE we replace the IFORGITTMP/CURUSER(MBRNAME) member.  
```
IFORGIT/SRCGITCMD SRCFILE(YOURPRDLIB/QRPGLESRC)     
                  SRCMBR(HELLO)                     
                  IFSREPODIR(*LIBREPODTAARA)        
                  SRCOPTION(*CHECKOUT)              
                  SRCHASH(' ')                      
                  DSPSTDOUT(*NO)                    
                  DSPCHKOUT(*NONE)                
                  DESTFILE(YOURDEVLIB/QRPGLESRC)          
                  DESTMBR(*SRCMBR)                    
                  DESTOPT(*REPLACE)                     
                  WRITETOTMP(*YES)                  
                  TMPDESTOPT(*IFORGITMP)            
                  TMPDESTUSR(*CURRENT)              
```
