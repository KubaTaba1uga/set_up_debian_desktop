#!/bin/bash

non_interactive="DEBIAN_FRONTEND=noninteractive"

sudo  $non_interactive apt-get install -y wget htop xsel git software-properties-common
