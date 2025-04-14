# ZSH and tmux commands 

## Mac OsX QWERTZ Keyboard

| keyboard | symbol | keys            |
| --- | ------ | --------------- |
| keyboard | ~ | qwertz: <opt> + n |
| keyboard | @ | qwertz: <opt> + l |
| keyboard | \ | qwertz: Shift + Alt + 7 |
| keyboard | [] | qwertz: Alt 5 + 6 |
| keyboard | \| | qwertz: Alt 7 |
| keyboard | {} | qwertz: Alt 8 + 9 |

## Shell commands

| topic |  command                                   | result                                              |
| --- | ----------------------------------------- | -------------------------------------------------------- |
| zsh | VAR='oli' | specifies a variable with string _oli_ |
| zsh | echo "$VAR" | evaluates between double quotes and echos |
| zsh | echo "${VAR}ver" | appends 'ver' to $VAR, whereas $VARver would be unknown |
| zsh | RESULT=$(id -un) | assigns result of command to RESULT |
| zsh | if [[$VAR = 'oli']]; then echo 'true'; fi | tests whether left side equals right side of term |
| zsh | echo {z..a..2} | echos every second char from a to z |
| zsh | i=image.jpg; mv \$i ${i%jpg}png | rename image.jpg into image.png |
| zsh | !v | uses the last comand from shell starting with v, e.g. vi |
| zsh | cht _language_ _topic_ | online help: calls the cheatsheet.sh script and curls from https://cht.sh |
| zsh | help _search_ | searches all *Helper.md files and shows matches |
| zsh | <ctrl>r | shows history of shell commands, with fzf search |

## General Commands

| topic | command                   | result                                                                                      |
| --- | ----------------------------------------------------------------------------------------- | ------------------------- |
| zsh | id -un                    | current user                                                                              |
| zsh | whoami                    | current user                                                                              |
| zsh | type -a _command_         | show type of command built in or location                |
| zsh | echo "${?}"               | provide exit code of last command               |
| zsh | who                       | who is logged in                                                                          |
| zsh | man _command_             | help file                                                                                 |
| zsh | which _command_           | find location of a given command in current PATH                                          |
| zsh | locate _command_          | find location of a command which is not in PATH but in updatedb, respect read permissions |
| zsh | sudo updatedb             | update db for locate command                                                              |
| zsh | date                      | show date and time                                                                        |
| zsh | echo "text"               | print text on screen                                                                      |
| zsh | ps -ef                    | show processes                                                                            |
| zsh | top                       | show top processes                                                                        |
| zsh | echo $PATH                | show path for commands                                                                    |
| zsh | crontab -l                | show cron job                                                                             |
| zsh | crontab -e                | change cron job                                                                           |
| zsh | logger "text" -t myScript | write _text_ to /var/log/messages with _myScript:_ tag                                    |
| zsh | bat _filename_ | open file in text viewer with highlighting                                                |

## Cyber/Security/Text Manipulation

| topic | Command                                                     | result                                                                                  |
| --- | ------------------------------------------------------------------------------------- | ----------------------------------------------------------- |
| zsh | echo '#+\*-\_$%&?' \| fold -w1 \| shuf \| head -c1          | generate random special char                                                          |
| zsh | echo -n "mein Secret" \| base64                             | encode Base64                                                                         |
| zsh | echo -n "bWVpbiBTZWNyZXQK" \| base64 -d                     | decode Base64                                                                         |
| zsh | echo -n "password123" \| shasum                             | SHA hash                                                                              |
| zsh | openssl enc -aes256 -base64 -in names.txt -out names.enc    | AES encrypt file with password                                                        |
| zsh | openssl enc -d -aes256 -base64 -in names.enc -out names.dec | AES decrypt file with password                                                        |
| zsh | age-keygen --output=keys.txt                                | create pub/priv keys with age                                                         |
| zsh | age --e --r=age1**key --o=text.age text.txt                 | encrypt file with pub key from age                                                    |
| zsh | age --d --i=keys.txt text.age > text.dec                    | decrypt file with private key from age                                                |
| zsh | echo "geheimer text" \| age -p > text.age                   | encrypt file with a passphrase                                                        |
| zsh | age -d text.age > text.txt                                  | decrypt file with passphrase                                                          |
| zsh | sudo nmap -sS -p80 192.168.178.0/24                         | scan port 80 in subnet                                                                |
| zsh | sudo nmap -O 192.1668.178.10                                | scan all ports on IP with Version                                                     |
| zsh | curl  or curlie                                             | transfer data using HTTP                                                              |
| zsh | curl 'https://api.github.com/repos/jqlang/jq/commits?per_page=5' \| jq '.' | curl data in json and get nice output                                                 |
| zsh | tail -f _filename_                                          | give last 10 lines of file permanent                                                  |
| zsh | awk -F ":" '{print $1 "\t"$6}' /etc/passwd                  | get all users and home dir from passwd with awk                                       |
| zsh | awk -F "/" '/^\// {print $NF}' /etc/shells                  | get all available shells - seperate / filter start with / take last column            |
| zsh | cut -d ':' -f 1,6 /etc/passwd                               | cut all characters from /etc/passwd, 1st and 6th field with : delimiter               |
| zsh | grep 'bash$' /etc/passwd                                    | give all accounts that use bash as their shell, last characters in etc/passwd file    |
| zsh | rg --glob '*.md'  _word_ | find _word_ in curent directory, only in mardown files                                |
| zsh | grep -v '^#' _file_                                         | grep all lines in a _file_ which do not start with #                                  |
| zsh | sort -k 2 _file_                                            | sort file by second column |
| zsh | cat /etc/passwd \| sort -t ':' -k 3 -n                      | sort passwd file by UID, delimiter : is used and the 3rd column is sorted numerically |
| zsh | cat _file_ \| uniq -c \| sort -n                            | get _file_ number of unique lines sorted by count, number sort                        |
| zsh | cat _filename_ \| sed '2/^$/d'                              | delete 2nd line - if nothing between start and end                                    |
| zsh | cat _filename_ \| sed '/^#/d'                               | delete all lines that start with a comment                                            |
| zsh | cat _filename_ \| sed '/^$/d ; /^#/d'                       | delete empty lines and comment lines # in one go                                      |
| zsh | cat _filename_ \| sed 's/pattern/replace/2'                 | substitute the second match of pattern                                                |
| zsh | ps -ef \| sed 6q                                            | give first 6 lines of ps-ef                                                           |
| zsh | cat _filename_ \| sed 's#/etc/hosts#/archive/user#i'        | substitute path using alternative delimiter #, i for case insensitive                 |
| zsh | echo $PATH \| sed 's/:/\n/g' \| sort                        | print each PATH in new line and sort result                                           |


## network

| topic | command                                                        | result                                       |
| --- | ------------------------------------------ | -------------------------------------------------------------- |
| zsh | ip addr                                                        | show own IP address                        |
| zsh | ping _IP_                                                      | check Ip adress available                  |
| zsh | netstat -rn                                                    | show IP routing table                      |
| zsh | netstat -an                                                    | show current network connections           |
| zsh | sudo netstat -nutlp4 \| grep ":" \| awk '{print $4 "\\t" $NF}' | show all open ports IP4 and connected PIDs |
| zsh | ifconfig \| grep "inet"                                        | filter own IP                              |
| zsh | sudo nano /etc/network/interfaces                              | edit network config                        |
| zsh | sudo /etc/init.d/networking restart                            | restart network service                    |
| zsh | ssh _rechnername_ -l _UID_                                     | remote login intranet                      |
| zsh | sudo pfctl -s info                                             | show firewall status                       |
| zsh | traceroute _hostname_                                          | show route to host                         |
| zsh | arp _hostname_                                                 | varify binding MAC adress to IP            |

## Filesystem

| topic | command                                  | result                                            |
| --- | ---------------------------------------- | ----------------------------------------------- |
| zsh | fzf _w1_ _w2_ _w3_                       | open fuzzy finder and look for files that contain _w1 w2 w3_ |
| zsh | fnv | open fuzzy find from current folder and opens selected file(s) in nvim |
| zsh | fcd | opens selected folder with cd with fuzzy search from current folder and below |
| zsh | fbat | fuzzy search with bat preview |
| zsh | fas | fuzzy search aerospace windows |
| zsh | cd ** _tab_                              | fuzzy cd                                        |
| zsh | pwd                                      | where am I                                      |
| zsh | ls -la                                   | show files                                      |
| zsh | mkdir _folder_                           | create folder                                   |
| zsh | rmdir _folder_                           | delete folder                                   |
| zsh | rm -rf _folder_                          | delete folder and substructure                  |
| zsh | touch _file_                             | create file if new, otherwise update date       |
| zsh | find _path_ -name _filename_ 2>/dev/null | find _filename_ in _path_ and ignore errors     |
| zsh | rm _file_                                | delete file                                     |
| zsh | less _file_                              | show file                                       |
| zsh | nano _file_                              | edit file                                       |
| zsh | vi _file_                                | edit _file_ in vi                               |
| zsh | which _filename_                         | get location of file according to $PATH         |
| zsh | chmod +x _file_                          | change file to executable                       |
| zsh | tail -F _file_                           | monitor log file                                |
| zsh | ls *.py \| entr python _script.py_       | re-run python _script.py_ whenever it changes   |
| zsh | df -h                                    | show space on disc                              |
| zsh | file _filename_                          | show file type                                  |
| zsh | diff names.txt names.enc                 | show delta between 2 files                      |
| zsh | cp -p _file_ _newfile_                   | copy _file_ and preserve date and permission    |
| zsh | tar -zvcf _file.tgz_ _folder_            | zip and archive _folder_ into _file.tgz_        |
| zsh | tar -zvtf _file.tgz_                     | show content of _file.tgz_                      |
| zsh | tar -zvxf _file.tgz_                     | extract content in _file.tgz_ to current folder |
| zsh | ln -s ~/folder/filename linkname         | create symlink                                  |

## tlmgr - cli for latex manager
| topic | command                     | result                    |
| --- | ----------------------- | --------------------------- |
| tlmgr | sudo tlmgr install <package> | install a specific LaTex package |


## SFTP Server

| topic | command                     | result                    |
| --- | ----------------------- | --------------------------- |
| zsh | sudo service vsftpd restart | restart SFTP server     |
| zsh | sftp _IP_                   | create connection       |
| zsh | lcd _directory_             | change local dir        |
| zsh | cd _directory_              | FTP server change dir   |
| zsh | ls                          | list dir on FTP server  |
| zsh | put _file_                  | send file to server     |
| zsh | put -r _dir_                | send dir to server      |
| zsh | get _file_                  | fetch file from server  |
| zsh | mput \*                     | send all files from dir |
| zsh | hash                        | enable hash             |
| zsh | exit                        | close connection        |

# Raspberry PI

| topic | command                        | result                  |
| --- | --------------------- | ------------------------------ |
| zsh | sudo reboot                    | reboot                |
| zsh | sudo halt                      | halt stop             |
| zsh | sudo raspi-config              | Raspi config          |
| zsh | sudo apt-get update            | update packet list    |
| zsh | sudo apt-get upgrade           | upgrade RasPi         |
| zsh | sudo apt-get install _package_ | install package       |
| zsh | sudo apt-get remove _package_  | delete package        |
| zsh | sudo apt-get dist-upgrade      | update distribution   |
| zsh | sudo apt-get clean             | cleanup apt archive   |
| zsh | sudo apt install blueman       | install bluetooth app |
