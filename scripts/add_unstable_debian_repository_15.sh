#!/bin/bash

echo "deb http://deb.debian.org/debian/ unstable main contrib non-free" | sudo tee  /etc/apt/sources.list.d/debian-unstable.list > /dev/null

echo -e 'Package: *
Pin: release a=stable
Pin-Priority: 900

Package: *
Pin: release a=unstable
Pin-Priority: 10' | sudo tee /etc/apt/preferences.d/99pin-unstable > /dev/null

sudo apt-get update
