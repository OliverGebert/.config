# ZSH and tmux commands 

## Mac OsX QWERTZ Keyboard

| symbol | keys            |
| ------ | --------------- |
| ~ | <opt> + n |
| @ | <opt> + l |
| \ | Shift + Alt + 7 |
| [] | Alt 5 + 6 |
| \| | Alt 7 |
| {} | Alt 8 + 9 |

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
| zsh | cht | calls the cheatsheet.sh script and curls from https://cht.sh |
| zsh | help | searches all *Helper.md files and shows matches |
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
| zsh | logger "text" -t myScript | write _text_ to /var/log/messages with _myScript:_ tag                                    |gg
| zsh | bat _filename_ | open file in text viewer with highlighting                                                |

## Cyber/Security/Text Manipulation

| topic | result                                                                                  | Command                                                     |
| --- | ------------------------------------------------------------------------------------- | ----------------------------------------------------------- |
| zsh | generate random special char                                                          | echo '#+\*-\_$%&?' \| fold -w1 \| shuf \| head -c1          |
| zsh | encode Base64                                                                         | echo -n "mein Secret" \| base64                             
| zsh | decode Base64                                                                         | echo -n "bWVpbiBTZWNyZXQK" \| base64 -d                     |
| zsh | SHA hash                                                                              | echo -n "password123" \| shasum                             |
| zsh | AES encrypt file with password                                                        | openssl enc -aes256 -base64 -in names.txt -out names.enc    |
| zsh | AES decrypt file with password                                                        | openssl enc -d -aes256 -base64 -in names.enc -out names.dec |
| zsh | create pub/priv keys with age                                                         | age-keygen --output=keys.txt                                |
| zsh | encrypt file with pub key from age                                                    | age --e --r=age1**key --o=text.age text.txt                 |
| zsh | decrypt file with private key from age                                                | age --d --i=keys.txt text.age > text.dec                    |
| zsh | encrypt file with a passphrase                                                        | echo "geheimer text" \| age -p > text.age                   |
| zsh | decrypt file with passphrase                                                          | age -d text.age > text.txt                                  |
| zsh | scan port 80 in subnet                                                                | sudo nmap -sS -p80 192.168.178.0/24                         |
| zsh | scan all ports on IP with Version                                                     | sudo nmap -O 192.1668.178.10                                |
| zsh | transfer data using HTTP                                                              | curl  or curlie                                                       |
| zsh | curl data in json and get nice output                                                 | curl 'https://api.github.com/repos/jqlang/jq/commits?per_page=5' \| jq '.' |
| zsh | give last 10 lines of file permanent                                                  | tail -f _filename_                                          |
| zsh | get all users and home dir from passwd with awk                                       | awk -F ":" '{print $1 "\t"$6}' /etc/passwd                  |
| zsh | get all available shells - seperate / filter start with / take last column            | awk -F "/" '/^\// {print $NF}' /etc/shells                  |
| zsh | cut all characters from /etc/passwd, 1st and 6th field with : delimiter               | cut -d ':' -f 1,6 /etc/passwd                               |
| zsh | give all accounts that use bash as their shell, last characters in etc/passwd file    | grep 'bash$' /etc/passwd                                    |
| zsh | find _word_ in curent directory, only in mardown files                                | rg --glob '*.md'  _word_ |
| zsh | grep all lines in a _file_ which do not start with #                                  | grep -v '^#' _file_                                         |
| zsh | sort file by second column | sort -k 2 _file_ |
| zsh | sort passwd file by UID, delimiter : is used and the 3rd column is sorted numerically | cat /etc/passwd \| sort -t ':' -k 3 -n                      |
| zsh | get _file_ number of unique lines sorted by count, number sort                        | cat _file_ \| uniq -c \| sort -n                            |
| zsh | delete 2nd line - if nothing between start and end                                    | cat _filename_ \| sed '2/^$/d'                              |
| zsh | delete all lines that start with a comment                                            | cat _filename_ \| sed '/^#/d'                               |
| zsh | delete empty lines and comment lines # in one go                                      | cat _filename_ \| sed '/^$/d ; /^#/d'                       |
| zsh | substitute the second match of pattern                                                | cat _filename_ \| sed 's/pattern/replace/2'                 |
| zsh | give first 6 lines of ps-ef                                                           | ps -ef \| sed 6q                                            |
| zsh | substitute path using alternative delimiter #, i for case insensitive                 | cat _filename_ \| sed 's#/etc/hosts#/archive/user#i'        |
| zsh | print each PATH in new line and sort result                                           | echo $PATH \| sed 's/:/\n/g' \| sort                        |


## network

| topic | result                                       | command                                                        |
| --- | ------------------------------------------ | -------------------------------------------------------------- |
| zsh | show own IP address                        | ip addr                                                        |
| zsh | check Ip adress available                  | ping _IP_                                                      |
| zsh | show IP routing table                      | netstat -rn                                                    |
| zsh | show current network connections           | netstat -an                                                    |
| zsh | show all open ports IP4 and connected PIDs | sudo netstat -nutlp4 \| grep ":" \| awk '{print $4 "\\t" $NF}' |
| zsh | filter own IP                              | ifconfig \| grep "inet"                                        |
| zsh | edit network config                        | sudo nano /etc/network/interfaces                              |
| zsh | restart network service                    | sudo /etc/init.d/networking restart                            |
| zsh | remote login intranet                      | ssh _rechnername_ -l _UID_                                     |
| zsh | show firewall status                       | sudo pfctl -s info                                             |
| zsh | show route to host                         | traceroute _hostname_                                          |
| zsh | varify binding MAC adress to IP            | arp _hostname_                                                 |

## Filesystem

| topic | result                                            | command                                  |
| --- | ----------------------------------------------- | ---------------------------------------- |
| zsh | open fuzzy finder and look for files that contain _w1 w2 w3_                              | fzf _w1_ _w2_ _w3_|
| zsh | fuzzy cd                                        | cd ** _tab_ |
| zsh | where am I                                      | pwd                                      |
| zsh | show files                                      | ls -la                                   |
| zsh | create folder                                   | mkdir _folder_                           |
| zsh | delete folder                                   | rmdir _folder_                           |
| zsh | delete folder and substructure                  | rm -rf _folder_                          |
| zsh | create file if new, otherwise update date       | touch _file_                             |
| zsh | find _filename_ in _path_ and ignore errors     | find _path_ -name _filename_ 2>/dev/null |
| zsh | delete file                                     | rm _file_                                |
| zsh | show file                                       | less _file_                              |
| zsh | edit file                                       | nano _file_                              |
| zsh | edit _file_ in vi                               | vi _file_                                |
| zsh | get location of file according to $PATH         | which _filename_                         |
| zsh | change file to executable                       | chmod +x _file_                          |
| zsh | monitor log file                                | tail -F _file_                           |
| zsh | re-run python _script.py_ whenever it changes   | ls *.py \| entr python _script.py_       |
| zsh | show space on disc                              | df -h                                    |
| zsh | show file type                                  | file _filename_                          |
| zsh | show delta between 2 files                      | diff names.txt names.enc                 |
| zsh | copy _file_ and preserve date and permission    | cp -p _file_ _newfile_                   |
| zsh | zip and archive _folder_ into _file.tgz_        | tar -zvcf _file.tgz_ _folder_            |
| zsh | show content of _file.tgz_                      | tar -zvtf _file.tgz_                     |
| zsh | extract content in _file.tgz_ to current folder | tar -zvxf _file.tgz_                     |
| zsh | create symlink                                  | ln -s ~/folder/filename linkname         |


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
