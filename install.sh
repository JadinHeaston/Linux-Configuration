#!/bin/bash
# Installation Script

## Command Aliases

#touch ~/.bash_aliases
#echo "alias lock=\"i3lock-fancy -p -g\"" > ~/.bash_aliases #Locks the screen (pixelating and greyscaling background)

## Adding repositories

sudo add-apt-repository -y multiverse # Adding Multiverse repository.
sudo add-apt-repository -y ppa:phoerious/keepassxc
sudo add-apt-repository -y ppa:lutris-team/lutris

## Performing initial update

sudo apt update && sudo apt upgrade -y # Updating apt

## Software

### General

#### Window Management ([material-shell](https://github.com/material-shell/material-shell))

sudo apt install -y make npm git
git clone https://github.com/material-shell/material-shell.git
cd material-shell
make install
cd ~

#sudo apt install -y awesome #Installing awesome
#echo "exec awesome" > ~/.xinitrc #Launching awesome
#echo "startx" >> ~/.bash_profile #Removed need to type on login

###### Removing previous window manager.

mv /usr/share/xsessions/ubuntu.desktop /usr/share/xsessions/ubuntu.desktop.bak
mv /usr/share/xsessions/ubuntu-xorg.desktop /usr/share/xsessions/ubuntu-xorg.desktop.bak

##### Custom Theme (https://github.com/HikariKnight/material-awesome)

###### Dependencies

#sudo apt install -y i3lock-fancy #Lock Screen - https://github.com/meskarune/i3lock-fancy
#sudo apt install -y rofi #Application Launcher - https://github.com/meskarune/i3lock-fancy
#sudo apt install -y materia-gtk-theme #GTK theme - https://github.com/nana-4/materia-theme
#sudo apt install -y papirus-icon-theme #Icon theme - https://github.com/PapirusDevelopmentTeam/papirus-icon-theme
#sudo apt install -y lxappearance
##sudo apt install -y redshift #Bluelight filter - https://github.com/jonls/redshift
#sudo apt install -y qt5-style-plugins
#echo "XDG_CURRENT_DESKTOP=Unity" > /etc/environment
#echo "QT_QPA_PLATFORMTHEME=gtk2" > /etc/environment

#### Firefox

sudo apt install -y firefox

#### KeePassXC

sudo apt install -y keepassxc

### VLC

sudo apt install -y vlc

### Programming

#### Beekeeper


#### Git

sudo apt install -y git

##### Git Configuration

git config --global user.name "Jadin Heaston"
git config --global user.email "jadin+heaston"

###### GPG Key

#### VS Code

sudo apt-get install wget gpg
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
rm -f packages.microsoft.gpg
sudo apt install apt-transport-https
sudo apt install -y code

### Gaming

#### Lutris

sudo apt update
sudo apt install -y lutris

#### Steam

sudo dpkg --add-architecture i386
sudo apt-get install -y steam
sudo dpkg --remove-architecture i386

#### Minecraft

wget https://launcher.mojang.com/download/Minecraft.deb
sudo apt install -y ./Minecraft.deb
sudo rm -rf ./Minecraft.deb

# Final updating to ensure verything is up-to-date.
sudo apt update && sudo apt upgrade -y