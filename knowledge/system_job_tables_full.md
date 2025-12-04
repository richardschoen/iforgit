# Job Tables Fill Up When Running LIBSRCEXP or when exporting many source members
On some systems job descriptions may be set up to always produce a joblog which 
can cause a system job table issue when many QShell/PASE jobs are run in sequence.  
The system job tables can fill up and force a system IPL. 

The IBM i system can only have a select maximum number of jobs (based on QMAXJOB system value). 
And when a job produces a spool file or has a joblog in *PENDING status, the job may still take 
up a job count entry even though the job may have ended and technically disappeared.

This relates directly to iForGit because iForGit runs many instances of the ```git`` command via QShell/PASE when the ```LIBSRCEXP``` command is run against one or more libraries.    

It's probably a good idea to check your max jobs system value setting and job descriptions to make sure they are not always creating a joblog. 

❗If exporting a large number of source members and a job produces
a joblog (if LOG value set to 4/00/*MSG or 4/00/*SECLVL), there's a chance the system job 
tables could fill up.

## Checking for potential issues

### Display maximum jobs allowed in system
Command to display system value for max jobs
```
DSPSYSVAL SYSVAL(QMAXJOB)
```
The max value this can be set to is 970000 jobs. Keep it down around 400000 is possible. 
If you run into a system lock condition this system value can be raised to 900000 temporarily if needed.  
 
❗Don't make any changes to this system value yet. Use ```WRKSYSVAL QMAXJOB``` to change this setting if desired. 

**Change to 400000. You can go higher but keep it well below the max job count of 970000 in case of errors, you can up the max job count before IPLing.

### Display job tables
Command to display job tables. If job tables fill up the system may halt.
```
DSPJOBTBL
```
This will show how many active job table entrues may be already filled up.

### This command shows pending joblogs that may show after jobs run 
Jobs may generate spool files in pending status. The WRKJOBLOG command 
below will show if there are any pending joblogs which can cause the
system to halt because these take up job table entries until the job ends
of is cleared from the system by deleting any spool files related to the job.

Command to show pending joblogs
```
WRKJOBLOG JOBLOGSTT(*PENDING) JOB(*ALL/*ALL/*ALL)
```
This may be most likely cause of job tables filling up.

### Clear/remove pending job tables IBMi 
https://www.ibm.com/support/pages/node/643397  

### Clear pending joblog entries. 
Per the link above, run the following program call to clean all pending joblog entries.  
```
CALL PGM(QWTRMVJL) PARM(X'0000002C000000005CC1D3D34040404040405CC1D3D34040
404040405CC1D3D340405CC1D3D3404040404040' 'RJLS0100' X'0000000000000000')
```

### Run WRKJOBLOG again to make sure there are no joblogs pending after running above program call.
```
WRKJOBLOG JOBLOGSTT(*PENDING) JOB(*ALL/*ALL/*ALL)
```

### Clearing output queues to end jobs can also help.

### Check server job description for ssh to make sure it's not 4/00/*MSG or 4/00/*SECLVL
```
WRKJOBD JOBD(QGPL/QDFTSVR)
-or- just
CHGJOBD JOBD(QGPL/QDFTSVR) LOG(4 0 *NOLIST)  
```
If the LOG setting was set to *MSG or *SECLVL, this job desc can cause spool files to get created or joblogs to be pending. The LOG setting should be set to ```4/00/*NOLIST``` so a joblog doesn't get generated for normal completion of git/ssh command calls.

If you change this job desc, restart SSH server afterwards.
```
ENDTCPSVR *SSHD
STRTCPSVR *SSHD
```

### Check server job description to make sure it's not 4/00/*MSG or 4/00/*SECLVL
```
WRKJOBD JOBD(QSYS/QSRVJOB)
-or- just 
CHGJOBD JOBD(QSYS/QSRVJOB) LOG(4 0 *NOLIST)  

```
If the LOG setting was set to *MSG or *SECLVL, this job desc can cause spool files to get created or joblogs to be pending. The LOG setting should be set to ```4/00/*NOLIST``` so a joblog doesn't get generated for normal completion of server job command calls. (This jobd may not be related to what we need.)

### Check user job description who runs the iForGit commands to make sure it's not 4/00/*MSG or 4/00/*SECLVL
```
WRKJOBD JOBD(LIB/USERJOBLOG)   
Ex: This example assumes user has a joblog named: USERJOBLOG in library: LIB.
```
If the LOG setting was set to *MSG or *SECLVL, this job desc can cause spool files to get created or joblogs to be pending. The LOG setting should be set to ```4/00/*NOLIST``` so a joblog doesn't get generated for normal completion of git/ssh command calls.

If you change this setting, log off and log back on for any users who will run iForGit commands so the new job description settings get picked up.
