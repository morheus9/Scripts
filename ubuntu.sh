#!/bin/bash
#Fonts without installation confirmation 
echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | sudo debconf-set-selections
sudo apt-get install ttf-mscorefonts-installer
#Updating of system
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
#Kodecs + Gcc for Go
sudo apt install ubuntu-restricted-extras libavcodec-extra
sudo apt -y install build-essential
#IDEs + programs
sudo snap install telegram-desktop
sudo snap install pycharm-professional --classic
sudo snap install code --classic
sudo snap install libreoffice
sudo snap install foliate
#Git
sudo apt install git
#Docker
sudo apt-get update
sudo apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
 curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io
sudo docker run hello-world
