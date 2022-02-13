#!/bin/bash

sudo apt-get update

non_interactive="DEBIAN_FRONTEND=noninteractive"

sudo  $non_interactive apt-get install software-properties-common apt-transport-https curl -y

curl -sSL https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -

sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"

sudo apt-get update

sudo $non_interactive apt-get install code -y
