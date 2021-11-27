#!/usr/bin/env bash

sudo apt update && sudo apt -y dist-upgrade
sudo apt install -y nmap
sudo apt install -y awscli

wget https://raw.githubusercontent.com/s0570827/Infrastruktur/main/scan_url.sh

chmod +x scan_url.sh

(crontab -l; echo "0 */12 * * * bash /home/ubuntu/scan_url.sh > /dev/null 2>&1")|awk '!x[$0]++'|crontab -

sudo reboot
