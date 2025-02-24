## GitHub

[GitHub Webseite](https://github.com)

> GitHub Account eMail konfigurieren: `git config --global user.email bcgebert@arcor.de"`

| topic | Task                                             | command                          |
| --- | ------------------------------------------------ | -------------------------------- |
| git | Show git command help                            | git _command_ --help             |
| git | Show global value setting                        | it config --list                 |
| git | \* initialize new Git repository (from dir)      | git init                         |
| git | \* clone (initialize) remote repository to local | git clone _URL_                  |
| git | check and display status of repository           | git status                       |
| git | \* add files to repository                       | git add -A _file_                |
| git | reset files from repository (invert add)         | git reset _filename_             |
| git | show version history of repository               | git log                          |
| git | Show branches of remote repository               | git branch -a                    |
| git | create new branch for work                       | git branch _branch_              |
| git | checkout Files from branch                       | git checkout _branch_            |
| git | \* create snapshot of repository                 | git commit -m "Message"          |
| git | \* connect local repository with GitHub          | git remote add origin _https://_ |
| git | check remote connection                          | git remote -v                    |
| git | get latest version of branch                     | git pull origin _branch_         |
| git | \* upload current snapshot to GitHub             | git push -u origin _branch_      |
| git | merge branchname in current branch               | git merge _branch_               |
| git | Delete branch                                    | git branch -d _branch_           |
| git | undo all current changes                         | git restore .                    |
| git | remove untracked/new files from working dir      | git clean -f                     |
