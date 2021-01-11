---
title: "Postinstall for Endeavour OS"
date: 2020-10-23T15:25:08+08:00
tags: ["postinstall", "endeavour os", "linux"]
categories: ["Linux"]
comments: true
---

Things to do after installing Endeavour OS.

<!--more-->

## Find fastest repository server

Click `select mirror` in the welcome APP and save the mirror list.

## Install kernel

Install `akm` kernel manager

```bash
sudo pacman -S akm
```

## Postinstall script

Save this content as `pkgs.txt`

```txt
# Pkg manager
yay
pikaur
pamac-aur
pigz
lzop
zstd
base-devel
python-pip

# Dev
llvm
clang
cmake
git
git-lfs
gitkraken

# Text editing
texlive-most
pandoc
typora
libreoffice-fresh
zotero
visual-studio-code-bin

# Network
firefox
vivaldi
vivaldi-ffmpeg-codecs
brave-bin
cifs-utils
gufw
telegram-desktop
teamviewer

# System
htop
glances
bpytop
zsh
timeshift
cronie
# timeshift-autosnap
podman-docker
appimagelauncher

# CLI / Terminal
parallel
pv
progress
trash-cli
tilix

# Input methods
ibus
ibus-chewing

# Fonts
ttf-roboto
ttf-fira-sans
noto-fonts
noto-fonts-cjk
noto-fonts-emoji
wqy-microhei
wqy-zenhei
ttf-opensans
nerd-fonts-complete

# Multimedia
vlc
smplayer
smplayer-skins
smplayer-themes
ffmpeg
youtube-dl

# Themes for KDE
plasma-browser-integration
kvantum-qt5
kvantum-theme-materia
papirus-icon-theme
materia-gtk-theme
materia-kde
qogir-icon-theme-git
qogir-gtk-theme-git
qogir-kde-theme-git
```

```bash
REPO=https://sosiristseng.github.io/code/postinstall/eos

# Customize makepkg.conf later
cp /etc/makepkg.conf ~/.makepkg.conf

# Setup ibus
cat << "EOF" >> ~/.xprofile
# ~/.xprofile
export GTK_IM_MODULE=ibus
export QT_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
ibus-daemon -drx
EOF


# Setup environment variables in profile
cat << "EOF" >> ~/.profile
# ~/.profile

[[ -d "${HOME}/.local/bin" ]] && PATH="${HOME}/.local/bin:${PATH}"

export BROWSER=$(command -v xdg-open)
export EDITOR=$(command -v nano)
export JULIA_NUM_THREADS=$(nproc)
export ELECTRON_TRASH=gio
EOF

# Setting up yay
mkdir -p ~/.config/yay
yay --save --answerclean All --answerdiff None --answeredit None --answerupgrade None --cleanafter --batchinstall --sudoloop

# First phase system setup with services
yay -S --noconfirm --needed teamviewer docker timeshift cronie
sudo systemctl enable --now cronie.service
sudo systemctl enable --now fstrim.timer
sudo systemctl enable --now teamviewerd
sudo systemctl enable --now docker.service
sudo systemctl disable org.cups.cupsd.service || echo "CUPS not installed!"
sudo systemctl enable --now org.cups.cupsd.socket || echo "CUPS not installed!"

# Install the rest
# Check pkgs.txt before running the line below
sed 's/#.*$//' pkgs.txt | xargs yay -S --noconfirm --needed
```

## If using NVIDIA GPU

Install Nvidia DKMS driver for all kernels and CUDA runtime:

```bash
sudo pacman -S nvidia-dkms cuda cudnn
```

## Theme settings

### KDE

- Kvantum theme: Qogir Dark
- Global theme: Qogir Dark
- Plasma style: Qogir Dark
- Application style: kvantum
- GTK style: Qogir Dark
- Window decorations: Qogir Dark
- Colors: Qogir Dark
- Fonts
  - General: Roboto medium 10.5pts
  - Monospace: Hack Nerd Font 10.5pt
- Icons: Qogir Dark
- Cursors: Qogir Dark

## Additional packages

Use `yay -S <pkgname>`

- [PyCharm](https://www.jetbrains.com/pycharm/): `pycharm-community-jre`
- [Anydesk](https://anydesk.com/en/downloads/linux): `anydesk-bin`
- Java runtime: `jre-openjdk`
- Flatpak: `flatpak`
- Snap: `snapd`
- Google drive client: `google-drive-ocamlfuse-opam`
- Onedrive client: `onedrive-abraunegg`
- FreeFileSync: `freefilesync-bin`
- Bottom: `bottom-bin`

### VirtualBox

From [VirtualBox@eos](https://endeavouros.com/docs/applications/how-to-install-virtualbox/)

Install the packages
```bash
sudo pikaur -S virtualbox virtualbox-guest-iso net-tools virtualbox-ext-oracle
```

And the add your username to the `vbox` group.
```bash
sudo gpasswd -a username vboxusers
```
