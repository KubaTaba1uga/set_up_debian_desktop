#!/bin/bash

non_interactive="DEBIAN_FRONTEND=noninteractive"

if ! [ -x "$(command -v emacs)" ]; then

  # Install elpy requirements
  sudo $non_interactive apt-get install virtualenv black flake8 pylint mypy -y
  python3 -m pip install jedi 

  # Install emacs
  sudo $non_interactive apt-get install -y \
        build-essential git autoconf texinfo \
        libgnutls28-dev libxml2-dev libncurses5-dev \
        libjansson-dev libxpm-dev libgif-dev bear \
        libgtk-3-dev libjpeg-dev libtiff-dev 
  
  
  mkdir /tmp/install_emacs

  git clone https://github.com/emacs-mirror/emacs.git /tmp/install_emacs

  /tmp/install_emacs/autogen.sh CFLAGS="-ggdb3 -O0" CXXFLAGS="-ggdb3 -O0" LDFLAGS="-ggdb3" 
  /tmp/install_emacs/configure --with-modules --with-json

  cd /tmp/install_emacs/

  bear make -j$(nproc)

  sudo make install

  sudo rm -rf /tmp/install_emacs


fi

# cp ./emacs/.emacs ~/
