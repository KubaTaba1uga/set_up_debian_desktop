#!/bin/bash

non_interactive="DEBIAN_FRONTEND=noninteractive"

sudo $non_interactive apt-get install openssh-server -y

# Disable root login
echo "PermitRootLogin no" | sudo tee -a /etc/ssh/sshd_config > /dev/null

# Allow keys authentication 
echo "PubkeyAuthentication yes" | sudo tee -a /etc/ssh/sshd_config > /dev/null

# Disable password authentication
echo "PasswordAuthentication no" | sudo tee -a /etc/ssh/sshd_config > /dev/null
echo "PermitEmptyPasswords no" | sudo tee -a /etc/ssh/sshd_config > /dev/null

# Drop incoming packages
sudo iptables -P INPUT DROP

# Allow port 22
sudo iptables -A INPUT -p tcp --dport 22 -j ACCEPT
sudo iptables -A INPUT -p tcp --sport 22 -j ACCEPT


# Save iptables
sudo iptables-save | sudo tee /etc/iptables/rules.v4 > /dev/null

