#!/bin/bash

#---------------------------------------------------Update
apt update && apt full-upgrade

#---------------------------------------------------Vscode
apt-get install wget gpg
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
rm -f packages.microsoft.gpg
apt install apt-transport-https
apt update
apt install code

#---------------------------------------------------Chrome
cat << EOF > /etc/apt/sources.list.d/google-chrome.list
deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main
EOF
wget -O- https://dl.google.com/linux/linux_signing_key.pub |gpg --dearmor > /etc/apt/trusted.gpg.d/google.gpg
apt update
apt install google-chrome-stable

#---------------------------------------------------Nvidia_Drivers
apt-add-repository contrib
apt-add-repository non-free
apt update
apt install nvidia-driver

#---------------------------------------------------Add_user
sudo adduser pi
usermod -aG sudo pi

######### Telegram + chrome_setup ######################################################################
#     https://web.telegram.org
#     please off hardware acceleration in chrome
########################################################################################################

######### Install_golang ###############################################################################
#     rm -r update-golang
#     git clone https://github.com/udhos/update-golang
#     cd update-golang
#     bash ./update-golang.sh
########################################################################################################

######## Install_Python ################################################################################
#     apt install build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev libsqlite3-dev wget libbz2-dev
#     wget https://www.python.org/ftp/python/3.10.4/Python-3.10.4.tgz
#     tar -xf Python-3.10.*.tgz
#     cd Python-3.10.*/
#     ./configure --enable-optimizations
#     make -j 4
#     make altinstall
#     apt install python3-pip
#     pip install -U pipenv
#     pipenv --python 3.10
#
#     cat <<EOF | sudo tee ~/.bashrc
#     alias python='/usr/local/bin/python3.10'
#     EOF
#     source ~/.bashrc
########################################################################################################
