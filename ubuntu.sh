#!/bin/bash

echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | sudo debconf-set-selections
sudo apt-get install ttf-mscorefonts-installer
#Update
sudo apt update && sudo apt full-upgrade
#python
sudo add-apt-repository ppa:deadsnakes/ppa
sudo apt update
sudo apt install python3.10
sudo apt install python3-pip
pip install virtualenv
#sudo apt install python3.10-venv
#Snap
sudo apt install snapd
sudo ln -s /var/lib/snapd/snap /snap
sudo snap install snap-store
#Kodecs+Gcc
sudo apt install ubuntu-restricted-extras libavcodec-extra
sudo apt -y install build-essential
#Apps
sudo snap install code --classic
sudo snap install libreoffice
sudo snap install foliate
#Git
sudo apt install git
#Docker
sudo snap install docker
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker 
docker ps