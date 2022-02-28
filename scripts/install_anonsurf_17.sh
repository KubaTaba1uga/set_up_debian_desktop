#!/bin/bash

mkdir /tmp/install_anonsurf

git clone https://github.com/Und3rf10w/kali-anonsurf.git /tmp/install_anonsurf

cd /tmp/install_anonsurf

sudo /bin/bash installer.sh

cd ..

rm -rf /tmp/install_anonsurf
