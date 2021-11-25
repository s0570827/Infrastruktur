#!/usr/bin/env bash

sudo apt update && sudo apt -y dist-upgrade
sudo apt install -y nmap
sudo apt install -y awscli

wget https://raw.githubusercontent.com/s0570827/Infrastruktur/main/scan_url.sh

chmod +x scan_url.sh
#0 */12 * * *
(crontab -l; echo "*/5 * * * * /home/ubuntu/scan_url.sh")|awk '!x[$0]++'|crontab -


sudo reboot
