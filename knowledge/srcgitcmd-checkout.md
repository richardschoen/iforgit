# Check out source member version using SRCGITCMD CL command
The git checkout option is a nice git way to check out a working copy of a source member 
from a git repository for work.

The ```SRCGITCMD``` CL command *CHECKOUT option is a way to check out a git source member from a git 
repository via CL command call or PDM option, RDI action or VS Code action. The member is 
automatically checked out to a temporary source member in QTEMP for viewing. The source member can 
be optionally restored to a selected library location as well for further work on the source member. 

**NOTE:** The checkout option is simply grabbing a copy of the selected source member version to a 
source physical file for viewing or edtiting. The source member is not actually being checked out 
like a library book. If desired you can check out a source member and overlay/replace an existing source 
member, but caution should be exercised so you don't overlay a production level source member if 
you restore to a library other than ```QTEMP``` or ```IFORGITTMP```.

## Examples of using the SRCGITCMD *CHECKOUT option

### Checkout to QTEMP/TMPSOURCE(TMPSOURCE) for viewing
This variation of the *CHECKOUT option should be used to simply checkout and 
view a temporary copy of the source member. During checkout the source 
member: QTEMP/TMPSOURCE(TMPSOURCE) always gets created. This temp source member 
is used for viewing or as a source location for copying to a selected destination source member.  

The important command options for this command variation are: 
```
DESTFILE(*IFORGITMP)
DESTOPT(*NONE)
DSPCHKOUT(*BROWSE)
```
They tell the command we simply want to check out the source member to the 
QTEMP/TMPSOURCE location and view it.

### Example checkout usage for simple QTEMP/TMSOURCE member viewing
```
/* Check out source member to QTEMP/TMPSOURCE(TMPSOURCE)                    */
/* We always create this source member during *CHECKOUT process             */
/* When DESTOPT = *NONE, this is the member checked out to.                 */
/* Use this to view the TMPSOURCE member from QTEMP/TMPSOURCE source file   */
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

### Checkout to source member in IFORGITTMP/CURUSER(MBRNAME) for viewing
The use case for this variation would be to check out a ctemporary copy of a member for vieiwng
in RDI or VS Code. Since these editors can't view the checkout directly, the next best
thing is to check it out to a consistent temporary location by user id. 

This variation of the *CHECKOUT option will check out a copy of a source
member to the IFORGITTMP library. A source file is auto-created for the current user. And 
the mamber name will be as specified on the DESTMBR parameter.

The important command options for this command variation are: 
```
DESTFILE(*IFORGITMP)
DESTOPT(*REPALCE)
DSPCHKOUT(*BROWSE)
```
They tell the command we simply want to check out the source member to the 
QTEMP/TMPSOURCE location and view it.

```                                                      
/* Check out source member to QTEMP/TMPSOURCE(TMPSOURCE)                    */
/* We always create this source member during *CHECKOUT process    */ 
/* Check out source member to IFORGITTMP/CURUSER(MBRNAME) as member name         */
/* When DESTOPT = *ADD we add/append to the IFORGITTMP/CURUSER(MBRNAME) member   */
/* When DESTOPT = *REPLACE we replace the IFORGITTMP/CURUSER(MBRNAME) member    */ 
NONE, this is the member checked out to.                 */
IFORGIT/SRCGITCMD SRCFILE(GITTEST123/QRPGLESRC)         
                  SRCMBR(HELLO)                         
                  IFSREPODIR(*LIBREPODTAARA)            
                  SRCOPTION(*CHECKOUT)                  
                  SRCHASH(' ')                          
                  DSPSTDOUT(*NO)                        
                  DSPCHKOUT(*BROWSE)                    
                  DESTFILE(*IFORGITMP)                  
                  DESTMBR(HELLO)                        
                  DESTOPT(*REPLACE)                     
                  WRITETOTMP(*YES)                      
                  TMPDESTOPT(*IFORGITMP)                
                  TMPDESTUSR(*CURRENT)                  
```

```
/* Check out source member to QTEMP/TMPSOURCE(TMPSOURCE)                    */
/* We always create this source member during *CHECKOUT process    */ 
/* Check out source member to IFORGITTMP/CURUSER(MBRNAME) as member name         */
/* When DESTOPT = *ADD we add/append to the IFORGITTMP/CURUSER(MBRNAME) member   */
/* When DESTOPT = *REPLACE we replace the IFORGITTMP/CURUSER(MBRNAME) member    */ 
IFORGIT/SRCGITCMD SRCFILE(GITTEST123/QRPGLESRC)     
                  SRCMBR(HELLO)                     
                  IFSREPODIR(*LIBREPODTAARA)        
                  SRCOPTION(*CHECKOUT)              
                  SRCHASH(' ')                      
                  DSPSTDOUT(*NO)                    
                  DSPCHKOUT(*BROWSE)                
                  DESTFILE(JUNK/QRPGLESRC)          
                  DESTMBR(HELLO)                    
                  DESTOPT(*ADD)                     
                  WRITETOTMP(*YES)                  
                  TMPDESTOPT(*IFORGITMP)            
                  TMPDESTUSR(*CURRENT)              
```
