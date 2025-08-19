## GitHub

[GitHub Webseite](https://github.com)

> GitHub Account eMail konfigurieren: `git config --global user.email bcgebert@arcor.de"`

| topic | command                          | Task                                             |
| --- | -------------------------------- | ------------------------------------------------ |
| lazygit | lg                               | opens lazygit in window with .git file in current path |
| lazygit | q                           | quit lazygit |
| lazygit | <space> in window [2]       | marks current line or folder for commit |
| lazygit | c                           | commit marked files |
| lazygit | P                           | push current comitt to github |
| lazygit | p                           | pull from repo |
| lazygit | z                           | undo last commit |
| lazygit | [12345]                     | toggles between widows 12345 |    
| lazygit | [jk]                        | scroll down or up |
| lazygit | /                           | find text in windows |
| lazygit | ?                           | open pop up with help on keybindings and commands 
| git | git _command_ --help             | Show git command help                            |
| git | git config --list                 | Show global value setting                        |
| git | git init                         | \* initialize new Git repository (from dir)      |
| git | git clone _URL_                  | \* clone (initialize) remote repository to local |
| git | git status                       | check and display status of repository           |
| git | git add -A _file_                | \* add files to repository                       |
| git | git reset _filename_             | reset files from repository (invert add)         |
| git | git log                          | show version history of repository               |
| git | git branch -a                    | Show branches of remote repository               |
| git | git branch _branch_              | create new branch for work                       |
| git | git checkout _branch_            | checkout Files from branch                       |
| git | git commit -m "Message"          | \* create snapshot of repository                 |
| git | git remote add origin _https://_ | \* connect local repository with GitHub          |
| git | git remote -v                    | check remote connection                          |
| git | git pull origin _branch_         | get latest version of branch                     |
| git | git push -u origin _branch_      | \* upload current snapshot to GitHub             |
| git | git merge _branch_               | merge branchname in current branch               |
| git | git branch -d _branch_           | Delete branch                                    |
| git | git restore .                    | undo all current changes                         |
| git | git clean -f                     | remove untracked/new files from working dir      |
| git | echo ".DS_Store" >> ~/.gitignore_global | echo exclusion into global ignore file for all repos |
| git | git config --global core.excludesfile ~/.gitignore_global | switch global exclude on |

