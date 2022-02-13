#!/bin/bash

# Set up gdm3 as default display manager
sudo cat "/usr/sbin/gdm3" | sudo tee /etc/X11/default-display-manager > /dev/null
