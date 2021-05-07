# Send GITQSH stdout job log to a new output queue when printing
The GITQSH command logs STDOUT to a spool file using print file QSYSPRT as a base.\
Overriding to the selected output queue can be done before calling the GITQSH command from your own processes as illustrated below

## Overriding just the output queue for printing log spool file IQSHLOG
```
OVRPRTF FILE(QSYSPRT) OUTQ(QSYSPRT) OVRSCOPE(*JOB)       
GITQSH CMDLINE('whatever qsh or git command') PRTSTDOUT(*YES)   
DLTOVR FILE(QSYSPRT) LVL(*JOB) 
```
## Overriding the output queue and spool file name for printing log spool file to spool file GITLOG
```
OVRPRTF FILE(QSYSPRT) OUTQ(QSYSPRT) SPLFNAME(GITLOG) OVRSCOPE(*JOB) 
GITQSH CMDLINE('whatever qsh or git command') PRTSTDOUT(*YES)   
DLTOVR FILE(QSYSPRT) LVL(*JOB) 
```
 
