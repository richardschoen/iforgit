# Job Tables Fill Up When Running LIBSRCEXP or when exporting many source members
On some systems job descriptions may be set up to always produce a joblog which 
can cause a system job table issue when many source members are exported at once. 

## Checking for potential issues

### Display job tables
Command to display job tables
```
DSPJOBTBL
```
This will show how many job table entrues may be already filled up.

If job tables fill up the system may halt.

### This command shows pending joblogs that may show after jobs run 
Jobs may generate spool files in pending status. The WRKJOBLOG command 
below will show if there are any pending joblogs which can cause the
system to halt because these take up job table entries until the job ends
of is cleared from the system by deleting any spool files related to the job.

Command to show pending joblogs
```
WRKJOBLOG JOBLOGSTT(*PENDING) JOB(*ALL/*ALL/*ALL)
```

Clear/remove pending job tables IBMi 
https://www.ibm.com/support/pages/node/643397  


Clearing output queues to end jobs can also help.

Check server job description for ssh to make sure it's not 4/00/*MSG or 4/00/*SECLVL
WRKJOBD JOBD(QGPL/QDFTSVR)

This can cause spool files to get created or joblogs to be pending.

If you change this job desc, restart SSH server afterwards.
ENDTCPSVR *SSHD
STRTCPSVR *SSHD

Check server job description to make sure it's not 4/00/*MSG or 4/00/*SECLVL
WRKJOBD JOBD(QSYS/QSRVJOB)

This can cause spool files to get created or joblogs to be pending.

Check user job description who runs the iForGit commands to make sure it's not 4/00/*MSG or 4/00/*SECLVL

This can cause spool files to get created or joblogs to be pending.

Up the max job count setting for QMAXJOB
WRKSYSVAL QMAXJOB and change value to 400000.

**Can go higher but keep it well below the max job count of 970000 in case of errors, you xan up the jax job count before IPLing.

Clear the pending joblog entries. 
CALL PGM(QWTRMVJL) PARM(X'0000002C000000005CC1D3D34040404040405CC1D3D34040
404040405CC1D3D340405CC1D3D3404040404040' 'RJLS0100' X'0000000000000000')

Make sure there are no joblogs pending
WRKJOBLOG JOBLOGSTT(*PENDING) JOB(*ALL/*ALL/*ALL)

