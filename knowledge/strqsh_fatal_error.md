# Get following error when running git command in STRQSH: “fatal: unable to create thread: Resource temporarily unavailable” 

Problem:   
User get the following error: ```fatal: unable to create thread: Resource temporarily unavailable``` when running ```git status``` or any other git command from the STRQSH command prompt agaainst a large git repository. 

Resolution:   
Kadler shared this link about multi-threading in QSH or STRQSH:   
https://ibmi-oss-docs.readthedocs.io/en/latest/troubleshooting/README.html#commands-are-failing-in-qsh   

We were running in STRQSH and it appears I didn't set the multithreaded flag before running git commands.   

One of the following will resolve the issue:   

Before running STRQSH or QSH commands:   
```ADDENVVAR  ENVVAR(QIBM_MULTI_THREADED) VALUE(Y) REPLACE(*YES)```    

-or-    

After STRQSH, run following command:      
```export QIBM_MULTI_THREADED=N```   

Once the multithreaded environment variable is present, your git commands .

In the above scenario I was using STRQSH because the customer didn't have a working SSH server where I could log in via SSH.   

If I had been able to log in via SSh there would not have been any problems.  

