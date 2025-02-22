# Aerospace - Windows tile manager

config file in ./config/Aerospace.toml

Aerospace: <opt>1 = goto window 1
Aerospace: <opt>2 = goto window 2
Aerospace: <opt><shift>1 = move application to window 1
Aerospace: <opt><shift>2 = move application to window 2
Aerospace: <opt>h = 'focus left'
Aerospace: <opt>j = 'focus down'
Aerospace: <opt>k = 'focus up'
Aerospace: <opt>l = 'focus right'
Aerospace: <opt><shift>h = 'move left'
Aerospace: <opt><shift>j = 'move down'
Aerospace: <opt><shift>k = 'move up'
Aerospace: <opt><shift>l = 'move right'
Aerospace: <opt><shift>s - service mode
Aerospace: <opt><shift>a - app launcher mode
Aerospace: <opt><shift><up> = increase 10%
Aerospace: <opt><shift><down> = decrease 10%

# Vimium - keyboard enabler for Chrome
Vimiumn: ? - open vimium help
Vimiumn: j-k - scroll up or down
Vimiumn: f - open URL in new tab
Vimiumn: F - open URL in current tab
Vimiumn: H - go back in hostory
Vimiumn: L - go forward in history
Vimiumn: t - create tab
Vimiumn: J - tab left
Vimiumn: K - tab right
Vimiumn: x - close tab


# ZSH and tmux commands 

## Mac OsX QWERTZ Keyboard

| symbol | keys            |
| ------ | --------------- |
| ~      | <opt> + n         |
| @      | <opt> + l         |
| \      | Shift + Alt + 7 |
| []     | Alt 5 + 6       |
| \|     | Alt 7           |
| {}     | Alt 8 + 9       |

## Shell commands

|  syntax                                   | explanation                                              |
| ----------------------------------------- | -------------------------------------------------------- |
| VAR='oli'                                 | specifies a variable with string _oli_                   |
| echo "$VAR"                               | evaluates between double quotes and echos                |
| echo "${VAR}ver"                          | appends 'ver' to $VAR, whereas $VARver would be unknown  |
| RESULT=$(id -un)                          | assigns result of command to RESULT                      |
| if [[$VAR = 'oli']]; then echo 'true'; fi | tests whether left side equals right side of term        |
| echo {z..a..2}                            | echos every second char from a to z                      |
| i=image.jpg; mv \$i ${i%jpg}png           | rename image.jpg into image.png                          |
| !v                                        | uses the last comand from shell starting with v, e.g. vi |
| cht                                       | calls the cheatsheet.sh script and curls from https://cht.sh |

## General Commands

| Task                                                                                      | command                   |
| ----------------------------------------------------------------------------------------- | ------------------------- |
| current user                                                                              | id -un                    |
| current user                                                                              | whoami                    |
| show type of command (built in or location)                                               | type -a [[                |
| provide exit code of last command                                                         | echo "${?}"               |
| who is logged in                                                                          | who                       |
| help file                                                                                 | man _command_             |
| find location of a given command in current PATH                                          | which _command_           |
| find location of a command which is not in PATH but in updatedb, respect read permissions | locate _command_          |
| update db for locate command                                                              | sudo updatedb             |
| show date and time                                                                        | date                      |
| print text on screen                                                                      | echo "text"               |
| show processes                                                                            | ps -ef                    |
| show top processes                                                                        | top                       |
| show path for commands                                                                    | echo $PATH                |
| show cron job                                                                             | crontab -l                |
| change cron job                                                                           | crontab -e                |
| write _text_ to /var/log/messages with _myScript:_ tag                                    | logger "text" -t myScript |gg
| open file in text viewer with highlighting                                                | bat _filename_ |

## Cyber/Security/Text Manipulation

| Task                                                                                  | Command                                                     |
| ------------------------------------------------------------------------------------- | ----------------------------------------------------------- |
| generate random special char                                                          | echo '#+\*-\_$%&?' \| fold -w1 \| shuf \| head -c1          |
| encode Base64                                                                         | echo -n "mein Secret" \| base64                             
| decode Base64                                                                         | echo -n "bWVpbiBTZWNyZXQK" \| base64 -d                     |
| SHA hash                                                                              | echo -n "password123" \| shasum                             |
| AES encrypt file with password                                                        | openssl enc -aes256 -base64 -in names.txt -out names.enc    |
| AES decrypt file with password                                                        | openssl enc -d -aes256 -base64 -in names.enc -out names.dec |
| create pub/priv keys with age                                                         | age-keygen --output=keys.txt                                |
| encrypt file with pub key from age                                                    | age --e --r=age1**key --o=text.age text.txt                 |
| decrypt file with private key from age                                                | age --d --i=keys.txt text.age > text.dec                    |
| encrypt file with a passphrase                                                        | echo "geheimer text" \| age -p > text.age                   |
| decrypt file with passphrase                                                          | age -d text.age > text.txt                                  |
| scan port 80 in subnet                                                                | sudo nmap -sS -p80 192.168.178.0/24                         |
| scan all ports on IP with Version                                                     | sudo nmap -O 192.1668.178.10                                |
| transfer data using HTTP                                                              | curl  or curlie                                                       |
| curl data in json and get nice output                                                 | curl 'https://api.github.com/repos/jqlang/jq/commits?per_page=5' \| jq '.' |
| give last 10 lines of file permanent                                                  | tail -f _filename_                                          |
| get all users and home dir from passwd with awk                                       | awk -F ":" '{print $1 "\t"$6}' /etc/passwd                  |
| get all available shells - seperate / filter start with / take last column            | awk -F "/" '/^\// {print $NF}' /etc/shells                  |
| cut all characters from /etc/passwd, 1st and 6th field with : delimiter               | cut -d ':' -f 1,6 /etc/passwd                               |
| give all accounts that use bash as their shell, last characters in etc/passwd file    | grep 'bash$' /etc/passwd                                    |
| find _word_ in curent directory, only in mardown files                                | rg --glob '*.md'  _word_ |
| grep all lines in a _file_ which do not start with #                                  | grep -v '^#' _file_                                         |
| sort file by second column | sort -k 2 _file_ |
| sort passwd file by UID, delimiter : is used and the 3rd column is sorted numerically | cat /etc/passwd \| sort -t ':' -k 3 -n                      |
| get _file_ number of unique lines sorted by count, number sort                        | cat _file_ \| uniq -c \| sort -n                            |
| delete 2nd line - if nothing between start and end                                    | cat _filename_ \| sed '2/^$/d'                              |
| delete all lines that start with a comment                                            | cat _filename_ \| sed '/^#/d'                               |
| delete empty lines and comment lines # in one go                                      | cat _filename_ \| sed '/^$/d ; /^#/d'                       |
| substitute the second match of pattern                                                | cat _filename_ \| sed 's/pattern/replace/2'                 |
| give first 6 lines of ps-ef                                                           | ps -ef \| sed 6q                                            |
| substitute path using alternative delimiter #, i for case insensitive                 | cat _filename_ \| sed 's#/etc/hosts#/archive/user#i'        |
| print each PATH in new line and sort result                                           | echo $PATH \| sed 's/:/\n/g' \| sort                        |


## network

| Task                                       | command                                                        |
| ------------------------------------------ | -------------------------------------------------------------- |
| show own IP address                        | ip addr                                                        |
| check Ip adress available                  | ping _IP_                                                      |
| show IP routing table                      | netstat -rn                                                    |
| show current network connections           | netstat -an                                                    |
| show all open ports IP4 and connected PIDs | sudo netstat -nutlp4 \| grep ":" \| awk '{print $4 "\\t" $NF}' |
| filter own IP                              | ifconfig \| grep "inet"                                        |
| edit network config                        | sudo nano /etc/network/interfaces                              |
| restart network service                    | sudo /etc/init.d/networking restart                            |
| remote login intranet                      | ssh _rechnername_ -l _UID_                                     |
| show firewall status                       | sudo pfctl -s info                                             |
| show route to host                         | traceroute _hostname_                                          |
| varify binding MAC adress to IP            | arp _hostname_                                                 |

## Filesystem

| Task                                            | command                                  |
| ----------------------------------------------- | ---------------------------------------- |
| open fuzzy finder and look for files that contain _w1 w2 w3_                              | fzf _w1_ _w2_ _w3_|
| fuzzy cd                                        | cd ** _tab_ |
| where am I                                      | pwd                                      |
| show files                                      | ls -la                                   |
| create folder                                   | mkdir _folder_                           |
| delete folder                                   | rmdir _folder_                           |
| delete folder and substructure                  | rm -rf _folder_                          |
| create file if new, otherwise update date       | touch _file_                             |
| find _filename_ in _path_ and ignore errors     | find _path_ -name _filename_ 2>/dev/null |
| delete file                                     | rm _file_                                |
| show file                                       | less _file_                              |
| edit file                                       | nano _file_                              |
| edit _file_ in vi                               | vi _file_                                |
| get location of file according to $PATH         | which _filename_                         |
| change file to executable                       | chmod +x _file_                          |
| monitor log file                                | tail -F _file_                           |
| re-run python _script.py_ whenever it changes   | ls *.py \| entr python _script.py_       |
| show space on disc                              | df -h                                    |
| show file type                                  | file _filename_                          |
| show delta between 2 files                      | diff names.txt names.enc                 |
| copy _file_ and preserve date and permission    | cp -p _file_ _newfile_                   |
| zip and archive _folder_ into _file.tgz_        | tar -zvcf _file.tgz_ _folder_            |
| show content of _file.tgz_                      | tar -zvtf _file.tgz_                     |
| extract content in _file.tgz_ to current folder | tar -zvxf _file.tgz_                     |
| create symlink                                  | ln -s ~/folder/filename linkname         |

# Development environment CLI

## GitHub

[GitHub Webseite](https://github.com)

> GitHub Account eMail konfigurieren: `git config --global user.email bcgebert@arcor.de"`

| Task                                             | command                          |
| ------------------------------------------------ | -------------------------------- |
| Show git command help                            | git _command_ --help             |
| Show global value setting                        | it config --list                 |
| \* initialize new Git repository (from dir)      | git init                         |
| \* clone (initialize) remote repository to local | git clone _URL_                  |
| check and display status of repository           | git status                       |
| \* add files to repository                       | git add -A _file_                |
| reset files from repository (invert add)         | git reset _filename_             |
| show version history of repository               | git log                          |
| Show branches of remote repository               | git branch -a                    |
| create new branch for work                       | git branch _branch_              |
| checkout Files from branch                       | git checkout _branch_            |
| \* create snapshot of repository                 | git commit -m "Message"          |
| \* connect local repository with GitHub          | git remote add origin _https://_ |
| check remote connection                          | git remote -v                    |
| get latest version of branch                     | git pull origin _branch_         |
| \* upload current snapshot to GitHub             | git push -u origin _branch_      |
| merge branchname in current branch               | git merge _branch_               |
| Delete branch                                    | git branch -d _branch_           |
| undo all current changes                         | git restore .                    |
| remove untracked/new files from working dir      | git clean -f                     |

## Python / pip usage

| Task                         | command                                     |
| ---------------------------- | ------------------------------------------- |
| create virtuel environment   | python3 -m venv venv                        |
| activate venv                | source venv/bin/activate                    |
| install new package          | pip install _package name_                  |
| write python package in file | pip freeze > requirements.txt               |
| upgrade package              | sudo pip install --upgrade _name_of_module_ |

## SFTP Server

| Task                    | command                     |
| ----------------------- | --------------------------- |
| restart SFTP server     | sudo service vsftpd restart |
| create connection       | sftp _IP_                   |
| change local dir        | lcd _directory_             |
| FTP server change dir   | cd _directory_              |
| list dir on FTP server  | ls                          |
| send file to server     | put _file_                  |
| send dir to server      | put -r _dir_                |
| fetch file from server  | get _file_                  |
| send all files from dir | mput \*                     |
| enable hash             | hash                        |
| close connection        | exit                        |

## Docker

| Task                           | command                    |
| ------------------------------ | -------------------------- |
| show docker processes          | docker ps                  |
| show all docker processes      | docker ps -a               |
| docker container starten       | docker start _containerID_ |
| docker container stoppen       | docker stop _containerID_  |
| remove docker container        | docker rm _containerID_    |
| list all images on docker host | docker image ls            |
| remove image from docker host  | docker rmi _imagename_     |
| show all container data        | docker volume ls           |

# MariaDB SQL Server

[SQL help page](https://dev.mysql.com/doc/mysql-getting-started/en/#mysql-getting-started-basic-ops)

| Task                        | command                                                        |
| --------------------------- | -------------------------------------------------------------- |
| login                       | sudo mysql -u root -p                                          |
| show existing databases     | SHOW DATABASES;                                                |
| create new database         | CREATE DATABASE _name_;                                        |
| set context                 | USE _name_;                                                    |
| show tables                 | SHOW TABLES;                                                   |
| define table                | create table _name_ (id int unsigned not null auto_increment,  |
|                             | name varchar(50) not null,                                     |
|                             | primary key (id));                                             |
| info for table              | DESCRIBE _name_;                                               |
| add records to table        | insert into greifvogel (name, ruf,schwanz) values              |
|                             | ('Adler','kein','breit'),                                      |
|                             | ('Milan','kein','gabel'),                                      |
|                             | ('Bussard','piae','breit');                                    |
| get records from table      | SELECT name FROM greifvogel WHERE schwanz = 'breit';           |
| delete record               | DELETE FROM greifvogel WHERE name='Adler';                     |
| create user                 | CREATE USER 'python-user'@'%' IDENTIFIED BY 'Password1$';      |
| grant access                | GRANT ALL PRIVILEGES ON greifvoegel . \* TO 'python-user'@'%'; |
| Flush privileges to mariadb | FLUSH PRIVILEGES;                                              |

> MariaDB neu starten: `sudo service mysql restart`

# tMux

## tMux CLI commands

| command | comment |
| --- | --- |
| tmux ls | show sessions |
| tmux attach | re-attach to existing session |
| tmux kill-server | kill server to ensure .tmux.conf is loaded |
| tmuxp load tmsession.yaml | load multiple windows with python tmux loader |

## tMux Windows Navigation

| command  | comment |
| --- | --- |
| <ctrl>x c |    create window |
| <ctrl>x n |    navigate windows |
| <ctrl>x 1 |    goto window 1 |
| <ctrl>x % |    split horizontal |
| <ctrl>x " |    split vertical |
| <ctrl>x hjkl |    move left/down/up/right |
| <ctrl>x d | detach from tmux session |
| <ctrl>x s | show running sessions |
| <ctrl>x r | reload config |

# Raspberry PI

| Task                  | command                        |
| --------------------- | ------------------------------ |
| reboot                | sudo reboot                    |
| halt stop             | sudo halt                      |
| Raspi config          | sudo raspi-config              |
| update packet list    | sudo apt-get update            |
| upgrade RasPi         | sudo apt-get upgrade           |
| install package       | sudo apt-get install _package_ |
| delete package        | sudo apt-get remove _package_  |
| update distribution   | sudo apt-get dist-upgrade      |
| cleanup apt archive   | sudo apt-get clean             |
| install bluetooth app | sudo apt install blueman       |
