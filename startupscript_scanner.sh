#!/usr/bin/env bash

sudo apt update && sudo apt -y dist-upgrade
sudo apt install -y nmap
sudo apt install -y awscli

#change Link to final Portscan Script
wget https://raw.githubusercontent.com/s0570827/Infrastruktur/main/testscript.sh

#change filename to final portscan script
chmod +x testscript.sh


#change filename of script and repitition of cronjob
#for every 12 hours 0 */12 * * *
#now every minute
(crontab -l; echo "* * * * * /home/ubuntu/testscript.sh")|awk '!x[$0]++'|crontab -


sudo reboot