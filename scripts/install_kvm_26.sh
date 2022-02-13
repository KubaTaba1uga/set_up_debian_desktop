#!/bin/bash

sudo apt-get update

non_interactive="DEBIAN_FRONTEND=noninteractive"

sudo  $non_interactive apt-get install qemu-kvm libvirt-clients libvirt-daemon-system bridge-utils virt-manager  -y

sudo systemctl enable --now libvirtd 

sudo usermod -a -G libvirt $USER 
