# Using the STRSEUGIT command to edit source via PDM and SEU

## Question
Customer would like to replace the STRSEU command with a copy of the STRSEUGIT command 
renamed to STRSEU so that iForGit can be called automatically when a user edits a source member with option 2 in PDM.   

Can the STRSEUGIT command be used to replace the STRSEU command ?

## Answer   
Unfortunately the STRSEUGIT command **should not** be copied over the top of the STRSEU 
commands in library QSYS or QPDA or renamed to be STRSEU.

The reason this won't work is that the STRSEUGIT command calls STRSEU internally and this 
creates an infinite loop of errors calling the STRSEU command from within the renamed version 
of the STRSEUGIT command. 

Instead developers should use the ```E``` PDM option to call STRSEUGIT to check out and edit 
the most recent git version of a source member. Or developers could use the the ```B``` PDM option 
to check out and browse the most recent version of a source member. 

❗STRSEUGIT will overlay existing source member contents from the the Git repository so it can be 
destructive and not recommended to use this command at all. 

In general we recommend that it's better for developers to master using the ```GE``` option to commit 
source changes to git after editing with SEU rather than trying to replace teh STRSEU edit command. 

## Overall Git IBM i Source Member Versioning Philosophy: 
Developers really need to become an active part of the source versioning process. The ```GE``` PDM 
option makes it very simple to version a source member right after making changes or periodically 
throughout the day.

And periodically or at the end of the day, the LIBSRCEXP command can be used to capture any missed
changes where a developer didn't commit changes to git throughout the day.





