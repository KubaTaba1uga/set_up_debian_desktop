#/bin/bash

sudo apt-get install wget build-essential libreadline-gplv2-dev  ca-certificates libncursesw5-dev libssl-dev libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev libffi-dev zlib1g-dev -y

cd .prep

mkdir python_installation

cd python_installation

wget https://github.com/actions/python-versions/releases/download/3.9.8-118810/python-3.9.8-linux-18.04-x64.tar.gz

tar xzf python-3.9.8-linux-18.04-x64.tar.gz

tar xzf Python-3.9.8.tgz

cd Python-3.9.8

./configure --enable-optimizations  

make -j 4

sudo make altinstall   

sudo rm -r -f ../python_installation
