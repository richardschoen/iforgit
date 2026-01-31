# Set up IBM i Library Repository in GitHub
This document describes the process of creating a new library repository in GitHub and then cloning it to uout IBM i system to be used with iForGit.

## Steps 
-Create ssh public/private user key for each IBM i user who will be committing source to a repo. 
You can also set up for just a single user if you plan to share an SSH key. Sharing an SSH key will still allow commits to be separated by git user because each IBM i user will also have a git profile.

-Add public key to GitHub user profile.   


-Create new GitHub repository for a library. Ex: QGPL     
Make sure to create a readme.md file so the repo has at least one file.    

-Clone the repository to /gitrepos/libraryname     

### Create SSH user key on IBM i for 
kkkkk

### Add public user key to your GitHub profile   
Log in to your git user account, navigate to the user profile in the upper right corner. Then select ```Settings```.        

<img width="296" height="434" alt="image" src="https://github.com/user-attachments/assets/33ff4e41-a9ab-4212-b31a-273e694e1672" />


             
Select ```SSH and GPG Keys```         
<img width="294" height="394" alt="image" src="https://github.com/user-attachments/assets/5baf481d-af7f-4d62-a6ea-39d991828ce5" />

Click the ```New SSH Key``` button to add a new SSH public key   
<img width="134" height="55" alt="image" src="https://github.com/user-attachments/assets/d3155e25-1c5d-4425-8c89-0744f7d037d6" />

Key in a ```Title```, select ```Authentication Key``` for ```Key Type``` and paste the value from your public key file into the ```Key``` field.    
If you created a key for your IBM i user, the value to paste in to the Key field will be from the ```id_ed25519.pub``` field.
<img width="956" height="529" alt="image" src="https://github.com/user-attachments/assets/716a1eae-4abb-4aac-b83c-cbe602f4b384" />

Click the ```Add SSH Key``` button to save the public key to the GitHub user profile.



