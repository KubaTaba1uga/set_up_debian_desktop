#!/bin/bash


non_interactive="DEBIAN_FRONTEND=noninteractive"

sudo  $non_interactive apt-get install dirmngr gpg-agent apt-transport-https -y

sudo mkdir -p /usr/local/share/keyrings

gpg --no-default-keyring --keyring /usr/local/share/keyrings/weechat-archive-keyring.gpg --keyserver hkps://keys.openpgp.org --recv-keys 11E9DE8848F2B65222AA75B8D1820DB22A11534E

sudo apt-get update

sudo $non_interactive apt-get install weechat weechat-curses weechat-plugins weechat-python weechat-perl -y


# Add slack
python3 -m pip install websocket_client

wget https://raw.githubusercontent.com/wee-slack/wee-slack/master/wee_slack.py

mkdir  ~/.weechat

mkdir  ~/.weechat/python

mkdir  ~/.weechat/python/autoload

cp wee_slack.py ~/.weechat/python/autoload

rm wee_slack.py
