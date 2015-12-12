#!/bin/bash

# Install aws-cli
pip install awscli

# Add moonlight-embedded to apt source list
echo "deb http://archive.itimmer.nl/raspbian/moonlight jessie main" >> /etc/apt/sources.list

echo "Updating sources... "
# Update apt sources
apt-get update

echo "Installing moonlight-embedded... "
# Get moonlight embedded
apt-get install moonlight-embedded

# Make some nifty aliases
echo "alias moonlight-stream-720='moonlight stream -720 -30fps -mapping /usr/local/bin/xbox.map -app'" >> ~/.bash_aliases
echo "alias moonlight-stream-1080='moonlight stream -1080 -30fps -mapping /usr/local/bin/xbox.map -app'" >> ~/.bash_aliases

# Set up controllers
modprobe -r xpad
echo "blacklist xpad" >> /etc/modprobe.d/gamepad.conf

echo "Installing xbodrv... "
# Get xboxdrv
apt-get install xboxdrv

echo "Done with setup! Restart your pi to finish the setup."
echo ""
echo "If you want to use controllers, please"
echo "edit your /etc/rc.local file and add the line"
echo "xboxdrv --silent &"
echo "before the exit 0."