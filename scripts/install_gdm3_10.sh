#!/bin/bash

non_interactive="DEBIAN_FRONTEND=noninteractive"

# Install display manager
sudo  $non_interactive apt-get install gdm3 -y  --no-install-recommends

# Start gdm 
sudo systemctl start gdm3
# Start gdm on starttup
sudo systemctl enable gdm3
