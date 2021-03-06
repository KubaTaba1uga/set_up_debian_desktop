#!/bin/bash

non_interactive="DEBIAN_FRONTEND=noninteractive"

if ! [ -x "$(command -v docker)" ]; then

 sudo apt-get remove -y \
  runc \
  docker \ 
  docker.io \
  containerd \
  docker-engine 

 sudo $non_interactive apt-get  install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release \
    apt-transport-https

 sudo curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

 sudo echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

 sudo apt-get update

 sudo $non_interactive apt-get install -y \
  docker-ce \
  docker-ce-cli \
  containerd.io 

 # Allow forwarding packets
 sudo iptables -P FORWARD ACCEPT

 # Save iptables
 sudo iptables-save | sudo tee /etc/iptables/rules.v4 > /dev/null

fi

