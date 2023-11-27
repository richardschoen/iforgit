# Improving GitBucket Repository Directory List Speed and Performance
As you start doing lots of commits, the GitBucket web UI will try to show you history info when listing a repository. To do that it has to touch each file and its metadata in the git repository. 

This can slow down the directory listing immensely. 

How to resolve ?

## Resolution 
Log in to Gitbucket browser as root or Admin user and go to ```System Administration/System Settings```.    

Then find that ```Repository Viewer – Max files in directory``` setting. Change it to something greater than 0.    

I set mine to ```200``` which I guess means if there’s more than 200 files in the directory, GitBucket will list just the file name, but not the last commit comment and updated time.  Apparently if set to 0, it goes thru all the history to determine last comment and updated time for each file member which is what slows it down. That should not be a large deal because you still get history when you drill into an individual file. 

![image](https://github.com/richardschoen/iforgit/assets/9791508/46707700-76ac-42d2-ad75-2ba6606aa6be)

## GitHub reference issue in case you want to read about this issue
https://github.com/gitbucket/gitbucket/issues/3200
