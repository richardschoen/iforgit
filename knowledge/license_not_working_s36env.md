# iForGit Is Throwing License Errors After Pasting License Code
After pasting the license key to the 5250 command line, all the iForGit commands are still throwing invalid license errors.  

Characters were also auto-converted to upper case when the code was pasted.   

## Resolution  
I noticed the the user profile Special Environment ```SPCENV``` value was set to ```*S36```.   

This causes data entry or pasted text to automatically convert to upper case, thus messing up the license code which contains mixed-case values.   

In the user profile, change ```SPCENV``` = ```*NONE```, then log off and log back in.

Paste the license code and notice that all text should now be in proper case.

Test iForGit ```LIBSRCEXP``` or ```SRCTOGIT``` commands to see if any license errors occur.
