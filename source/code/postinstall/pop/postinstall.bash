#!/usr/bin/env bash
# Post-install for PopOS
set -euxo pipefail

REPO="https://sosiristseng.github.io/code/postinstall/popos"

# Setup NCHC mirror
sudo -v
sudo sed -i 's/us.archive.ubuntu.com/free.nchc.org.tw/g' /etc/apt/sources.list.d/system.source
sudo sed -i 's/security.ubuntu.com/free.nchc.org.tw/g' /etc/apt/sources.list.d/system.source
sudo apt update
sudo apt install -y apt-transport-https ca-certificates curl git gnupg-agent software-properties-common python3-pip
sudo dpkg --add-architecture i386

# Google chrome
wget -qO- https://dl.google.com/linux/linux_signing_key.pub | sudo tee /etc/apt/trusted.gpg.d/google-chrome.asc > /dev/null
echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-chrome.list > /dev/null

# Vivaldi
wget -qO- https://repo.vivaldi.com/archive/linux_signing_key.pub | sudo tee /etc/apt/trusted.gpg.d/vivaldi.asc > /dev/null
echo "deb https://repo.vivaldi.com/archive/deb/ stable main" | sudo tee /etc/apt/sources.list.d/vivaldi.list > /dev/null

# Anydesk
wget -qO- https://keys.anydesk.com/repos/DEB-GPG-KEY | sudo tee /etc/apt/trusted.gpg.d/anydesk.asc > /dev/null
echo "deb http://deb.anydesk.com/ all main" | sudo tee /etc/apt/sources.list.d/anydesk-stable.list > /dev/null

# Anydesk
wget -qO- https://keys.anydesk.com/repos/DEB-GPG-KEY | sudo tee /etc/apt/trusted.gpg.d/anydesk.asc > /dev/null
echo "deb http://deb.anydesk.com/ all main" | sudo tee /etc/apt/sources.list.d/anydesk-stable.list > /dev/null

# Xanmod linux kernel
wget -qO- https://dl.xanmod.org/gpg.key | sudo tee /etc/apt/trusted.gpg.d/xanmod.asc > /dev/null
echo 'deb http://deb.xanmod.org releases main' | sudo tee /etc/apt/sources.list.d/xanmod-kernel.list > /dev/null

# VS code
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | sudo tee /etc/apt/trusted.gpg.d/microsoft.asc > /dev/null
echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" | sudo tee /etc/apt/sources.list.d/vscode.list > /dev/null

# Zotero
wget -qO- https://github.com/retorquere/zotero-deb/releases/download/apt-get/install.sh | sudo bash

# Brave
wget -qO- https://brave-browser-apt-release.s3.brave.com/brave-core.asc | sudo tee /etc/apt/trusted.gpg.d/brave-browser-release.asc > /dev/null
echo "deb [arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list > /dev/null

# sudo add-apt-repository -yu ppa:appimagelauncher-team/stable  # AppImageLauncher
sudo add-apt-repository -yu ppa:git-core/ppa              # Git stable releases
sudo add-apt-repository -yu ppa:alessandro-strada/ppa     # Google drive client
sudo add-apt-repository -yu ppa:papirus/papirus           # Papirus icon theme
sudo add-apt-repository -yu ppa:yann1ck/onedrive          # OneDrive client
sudo add-apt-repository -yu ppa:graphics-drivers/ppa      # Nvidia Proprietary Driver
sudo add-apt-repository -yu ppa:atareao/telegram          # Telegram

# Set up apt-fast
sudo add-apt-repository -y ppa:apt-fast/stable
echo debconf apt-fast/maxdownloads string 16 | sudo debconf-set-selections
echo debconf apt-fast/dlflag boolean true | sudo debconf-set-selections
echo debconf apt-fast/aptmanager string apt-get | sudo debconf-set-selections

sudo apt update
sudo apt install -y apt-fast
sudo apt-fast full-upgrade -y

# Downoad and install deb
wget -qO /tmp/teamviewer.deb "https://download.teamviewer.com/download/linux/teamviewer_amd64.deb"

sudo apt install -y /tmp/*.deb

# Install packages
wget -qO- ${REPO}/pop.txt | sed 's/#.*$//' | xargs sudo apt-fast install -y

# Local pip packages
[[ -x "$(command -v pip)" ]]  && pip  install -U --user glances bpytop jill youtube-dl