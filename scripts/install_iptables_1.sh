#!/bin/bash

non_interactive="DEBIAN_FRONTEND=noninteractive"

sudo $non_interactive apt-get install iptables -y

# Enable non interactive mode
echo iptables-persistent iptables-persistent/autosave_v4 boolean true | sudo debconf-set-selections
echo iptables-persistent iptables-persistent/autosave_v6 boolean true | sudo debconf-set-selections

sudo $non_interactive apt-get install iptables-persistent -y

# Allow UDP 
sudo iptables -I INPUT -p udp --sport 53 -j ACCEPT
sudo iptables -I INPUT -p tcp --sport 53 -j ACCEPT
# Allow HTTP
## For all output packages
sudo iptables -A OUTPUT -p tcp --dport 80 -m state --state NEW,ESTABLISHED -j ACCEPT
## For input packages which are going back
sudo iptables -A INPUT -p tcp --sport 80 -m state --state ESTABLISHED -j ACCEPT
# Allow HTTPS
## For all output packages
sudo iptables -A OUTPUT -p tcp --dport 443 -m state --state NEW,ESTABLISHED -j ACCEPT
## For input packages which are going back
sudo iptables -A INPUT -p tcp --sport 443 -m state --state ESTABLISHED -j ACCEPT

# Save iptables
sudo iptables-save | sudo tee /etc/iptables/rules.v4 > /dev/null
