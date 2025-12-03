## ssh oli@homepi


| topic | short key                    | Task                           |
| --- | ------------------------------ | -------------------------- |
| raspi | sudo systemctl list-unit-files --type=service | show all service and enable status |
| raspi | sudo systemctl daemon-reload | reload service files |
| raspi | sudo systemctl enable opencanary | enable opencanary service |
| raspi | sudo systemctl start opencanary | start opencanary service |
| raspi | systemctl is-enabled opencanary.service | shows enabled status of service |
| raspi | sudo systemctl status opencanary.service | show status and error on service startup |
| raspi | journalctl -u opencanary.service -b \|tail -n 30 | show last 30 lines of ctl journal startup log |
| raspi | vi /etc/opencanaryd/opencanary.conf | edit canary services |
| raspi | sudo vi /etc/systemd/system/opencanary.service | edit systemctl service start for opencanary |
| raspi | sudo ss -tulpn | shows all open ports on server, grep required port |
| raspi | curl ftp://192.168.178.10/ --user pi:123 | test canary on ftp port |
| raspi | echo "test mail" \| mail -s "Test" oli | sends a local mail via postfix to oli |
| raspi | sudo reboot | restart the raspi |
| raspi | sudo apt update | update local list of packages |
| raspi | sudo apt full-upgrade | update all installed packages |
| raspi | dmesg \| tail -n 20 | shows the last 20 line of the mounting info |
| raspi | lsblk | shows info on all devices connected |
| raspi | sudo mkfs.ext4 /dev/sda1 | create linux file system on sda |
| raspi | sudo shutdown now | shutdown  raspi now, power off |


## opencanary.service
[Unit]
Description=OpenCanary Daemon
After=network-online.target
Wants=network-online.target

[Service]
ExecStart=/home/oli/opencanary/venv/bin/opencanaryd --dev --config=/etc/opencanaryd/opencanary.conf
WorkingDirectory=/etc/opencanaryd
Environment="PATH=/home/oli/opencanary/venv/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
User=root
Restart=always

[Install]
WantedBy=multi-user.target
