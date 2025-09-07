# Git, fatal: The remote end hung up unexpectedly
I received this error uploading a git push to my remote Git server.

Fortunately Stack Overflow had an answer:  
https://stackoverflow.com/questions/15240815/git-fatal-the-remote-end-hung-up-unexpectedly

Looks like an easy fix. Set a larger post buffer. That's a first time I've ever seen this in several years of using Git.     
```
git config http.postBuffer 524288000
```
