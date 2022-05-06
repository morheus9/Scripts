#!/bin/bash


#     Kodecs
echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | debconf-set-selections
apt-get install ttf-mscorefonts-installer
#     Update
apt update && apt full-upgrade
#     Golang
rm -r update-golang
git clone https://github.com/udhos/update-golang
cd update-golang
bash ./update-golang.sh
#     Python
add-apt-repository ppa:deadsnakes/ppa
apt update
apt install python3.10
apt install python3-pip
pip install virtualenv
#     Gcc + nettools
apt install ubuntu-restricted-extras libavcodec-extra
apt -y install build-essential
apt install net-tools
#     Apps
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
apt install ./google-chrome-stable_current_amd64.deb
snap install code --classic
snap install libreoffice
snap install foliate
#     Git
apt install git



#########################################################################################

  
##  yes | sudo bash u.sh
