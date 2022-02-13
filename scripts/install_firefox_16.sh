#!/bin/bash
non_interactive="DEBIAN_FRONTEND=noninteractive"

sudo  $non_interactive apt-get install -t unstable firefox -y
