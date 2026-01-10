# Issue viewing source member when using SRCGITVER command
Customer has some source members that contain special character sequences
from the System/38 CL days that are causing a problem when trying to checkout 
and view them using the SRCGITVER command ```Option 5=View```. IBM i creates the 
checked out source member in the IFS as CCSID (1208) UTF-8. When attempting to 
restore the source to a source member with the CPYFRMSTMF command, the process is 
receiving an error.

An example of the special character sequence ```¬=``` causing the issue:
```
IF         COND((&FIELDA ¬= 'NEW')
```

## Problem Details:
The following error shows on the Work with Source Member Versions/Commits screen error message 
line after trying to use Opt 5=View to view the Git source member. And the source is never displayed:   
```Errors occurred while running command command on source IFS file. Check the joblog.```

When looking in the joblog the error looks like this:    
```
File /home/USER/tmpgit/QCLSRC/SRC001.CLP was found 
Information passed to this operation was not valid.     
Stream file not copied.                                 
Environment variable does not exist.                    
```
This indicated to me that there is a character conversion issue as other source members 
were exporting for viewing just fine with SRCGITVER and Option 5=View.

## Resolution:
When source members are currently saved to Git using iForGit, they are output with CCSID (1252) which
is the equivalent of the *PCASCII setting on the CPYTOSTMF command which is used under the covers.
This seems to capture the source member characters correctly to the Git repository since exported
source members get CCSID (1252).

Apparently on IBM i, when new IFS files are created, there is now a default of CCSID (1208) used to 
create a new file in the IFS. Since Git doesn't know about CCSID it happily checks out the source member
when the user selects to view it. And it creates the checked out source member with CCSID (1208). 
Where the problem occurs is the CPYFRMSTMF command does not seem to like the aforementioned characters 
when it tries to copy the source member to a temporary source member. 

It looks like there is an environment variable ```QIBM_PASE_CCSID``` that can be set at the system level 
or job level to resolve this issue and correctly check out source from the Git repo as CCSID (1252). 
❗My recommendation is to set this at the user job level for now until we can fix this in the SRCGITVER command.
Setting at the system level would require review to make sure you don't cause other issues. 

From an interactive 5250 job, simply run the following command one time:
```
ADDENVVAR ENVVAR(QIBM_PASE_CCSID)     
          VALUE(1252)                 
          CCSID(*JOB)                 
          LEVEL(*JOB)                 
          REPLACE(*YES)
```
Once you've done this, the setting persists until you log off.    

Then try viewing a source member via the SRCGITVER Opt 5=View command and it should work as expected.   
