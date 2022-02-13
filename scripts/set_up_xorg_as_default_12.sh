#!/bin/bash

# Disable wayland
sed '/\[daemon\]/a WaylandEnable=false' /etc/gdm3/daemon.conf | sudo tee /etc/gdm3/daemon.conf > /dev/null


