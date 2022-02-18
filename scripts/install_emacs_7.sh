#!/bin/bash

non_interactive="DEBIAN_FRONTEND=noninteractive"

# Install elpy requirements
sudo $non_interactive apt-get install virtualenv black flake8 pylint mypy -y
python3 -m pip install jedi 

# Install emacs
sudo apt-get install -y build-essential git autoconf texinfo libgnutls28-dev libxml2-dev libncurses5-dev libjansson-dev bear

git clone git://git.sv.gnu.org/emacs.git

cd emacs

./autogen.sh CFLAGS="-ggdb3 -O0" CXXFLAGS="-ggdb3 -O0" LDFLAGS="-ggdb3" 
./configure --with-modules --with-json

bear make -j$(nproc)

sudo make install

cp ./emacs/.emacs ~/
