# Remove source member from Git Repository using iForGit Command

The general Git sequence for deleting a source member from a repository is something like this:
```
# Remove the member from the local IFS repository
git rm /gitrepos/gittest123/qrpglesrc/member1.rpgle
# Commit the delete to the repository
git commit -m "Remove member1.rpgle"
# Push to remote repository to complete the delete
git push 
```
