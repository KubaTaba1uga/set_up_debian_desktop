#!/bin/bash

non_interactive="DEBIAN_FRONTEND=noninteractive"

sudo $non_interactive apt-get install \
libgl1-mesa-dri        \
x11-xserver-utils      \
gnome-session           \
gnome-applets            \
gnome-tweak-tool        \
gnome-icon-theme        \
gnome-backgrounds      \
gnome-control-center     \
gnome-themes-standard \
chrome-gnome-shell \
terminator nautilus guake \
-y --no-install-recommends --fix-missing
