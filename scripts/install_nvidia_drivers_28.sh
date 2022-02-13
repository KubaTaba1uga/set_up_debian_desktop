#!/bin/bash

non_interactive="DEBIAN_FRONTEND=noninteractive"

sudo add-apt-repository contrib

sudo apt-get update

sudo $non_interactive apt-get install linux-headers-amd64 -y

sudo  $non_interactive apt-get install -y --fix-missing nvidia-driver
