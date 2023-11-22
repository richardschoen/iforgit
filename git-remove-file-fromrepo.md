# Removing a file from a git repository
This article shows how to remove a file from a git repository.

Normally you might leave an old file in your git repository for for history tracking, but there will be times you might want to remove a file from your git repository altogether.

## Scenario: Git has a hard time when cloning a repo that contains a file name that ends with a period 
You may have accidentally checked in a file name that ends with a period. Ex: ```FILE001.```   

Now when you clone your repository to a PC for use with a git client, you get errors and the repo won't check out. How can this be fixed ?   

## Deleting/removing a file from a git repository
If you google: ```remove file from git repository``` there are lots of articles, but I will give you a quick list that works with an IBM i based git repository.    

For this example we will remove a file in subdirectory (source file) ```SOURCE``` file name: ```FILE001.``` from our git repository named ```myrepository```.   

First, log in to an SSH bash session.   

Change to the repository directory   
```cd /gitrepos/myrepository1```   

Remove the file from our git cache. (Actual file in the IFS: /gitrepos/myrespository/SOURCE/FILE001.)   
```git -rm --cached SOURCE/FILE001.```

Commit the removal change to the repository.   
git commit -m "Removed Files FILE001."

Push the change to our remote repository.    
```git push```

Remove the file from the file system.   
```rm SOURCE/FILE001.```

Once your file with the period at the end is eliminated from the repository, you should now be able to clone your repository successfully.
