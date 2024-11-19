# iForGit Simple Source Management CL Commands
This document is a shortcut getting started document for using the simple source management commands in iForGit.

# iForgit Simple Source Management CL Commands

# MBRARC - Take source member archive snapshot to source archive file
This CL command can be used to quickly grab a snapshot copy of any source member and place it into the source archive files IFORGIT/GITSRCARC using an automatically named source member.

This is a good way to quickly snapshot a source member without having to copy and rename it to something meaningful.  

# MBRARC usage examples  
The following example snapshots a source member named MYSOURCE1 to the IFORGIT/GITSRCARC table from QGPL/QRPGLESRC. The source member name in the archive is automatically created. 

 ``` 
 MBRARC SRCFILE(QGPL/QRPGLESRC)    
        SRCMBR(MYSOURCE1)          
        ARCSRCFILE(*DEFAULT)       
```

# MBRARC command parms  

**SRCFILE** - The source file to capture source member from. 

**SRCMBR** - The source member to to capture to the archive IFORGIT/GITSRCARC source file. 

**ARCSRCFILE** - The archive source file to capture source member to. *DEFAULT captures the source members to the IFORGIT/GITSRCARC archive source file with a unique member name. Ex: ```M000000001```

