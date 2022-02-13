#!/bin/bash


non_interactive="DEBIAN_FRONTEND=noninteractive"

sudo  $non_interactive apt-get install transmission-cli transmission-common transmission-daemon -y
