#!/bin/bash

sed '/\[daemon\]/a DefaultSession=gnome-xorg' /etc/gdm3/daemon.conf | sudo tee /etc/gdm3/daemon.conf > /dev/null
