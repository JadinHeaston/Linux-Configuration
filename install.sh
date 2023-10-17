#!/bin/sh

# Installation Script

## Script Variables

KEEPASS_WEBDAV_MOUNT_PATH=/mnt/keedav/
KEEPASS_WEBDAV_URL=
KEEPASS_WEBDAV_USERNAME=
KEEPASS_WEBDAV_PASSWORD=
GIT_USER_NAME="Jadin Heaston"
GIT_USER_EMAIL="86203688+JadinHeaston@users.noreply.github.com"

## Command Aliases

touch ~/.bash_aliases

## Adding repositories

sudo add-apt-repository -y multiverse
sudo add-apt-repository -y ppa:phoerious/keepassxc
sudo add-apt-repository -y ppa:lutris-team/lutris

## Performing initial update

sudo apt update
sudo apt upgrade -y #Updating apt

## Software

### General

#### dconf Customization

sudo apt install -y dconf-editor gnome-shell-extension-manager
echo "Install \"Blur my Shell (aunetx)\" via Extensions and set Sigma to 5 with brighness intensity to .35"

gsettings set org.gnome.mutter workspaces-only-on-primary false

##### Desktop

gsettings set org.gnome.desktop.background picture-uri-dark file:///usr/share/backgrounds/Multiverse_by_Emanuele_Santoro.png
gnome-extensions disable ding@rastersoft.com #Disable desktop icons.

##### Dock

gsettings set org.gnome.desktop.wm.preferences resize-with-right-button true

gsettings set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size 24
gsettings set org.gnome.shell.extensions.dash-to-dock extend-height false
gsettings set org.gnome.shell.extensions.dash-to-dock multi-monitor false
gsettings set org.gnome.shell.extensions.dash-to-dock show-mount false
gsettings set org.gnome.shell.extensions.dash-to-dock show-mounts-network false
gsettings set org.gnome.shell.extensions.dash-to-dock show-trash false
gsettings set org.gnome.shell.extensions.dash-to-dock dock-fixed false
gsettings set org.gnome.shell.extensions.dash-to-dock dock-position 'BOTTOM'
gsettings set org.gnome.shell.extensions.dash-to-dock require-pressure-to-show false

gsettings set org.gnome.settings-daemon.plugins.power idle-dim false
gsettings set org.gnome.desktop.interface show-battery-percentage true


##### Taskbar

gsettings set org.gnome.desktop.interface clock-show-seconds true
gsettings set org.gnome.desktop.interface clock-format 12h
gsettings set org.gnome.desktop.interface clock-show-weekday 12h

#### Firefox

sudo apt install -y firefox

#### KeePassXC

sudo apt install -y keepassxc

##### Enabling auto-type

##### Enabling WebDav support

sudo apt install -y davfs2
#sudo dpkg-reconfigure davfs2
mkdir -p $KEEPASS_WEBDAV_MOUNT_PATH
touch ~/.davfs2/secrets
echo "$KEEPASS_WEBDAV_URL	$KEEPASS_WEBDAV_USERNAME	$KEEPASS_WEBDAV_PASSWORD" > ~/.davfs2/secrets #Tab delimited (# act as comments, escape them)
chmod 600 ~/.davfs2/secrets
echo "$KEEPASS_WEBDAV_URL $KEEPASS_WEBDAV_MOUNT_PATH davfs user,_netdev,auto,file_mode=600,dir_mode=700 0 1" > /etc/fstab
sudo usermod -a -G davfs2 {USERNAME}
touch ~/.bash_profile
sudo systemctl enable NetworkManager-wait-online.service #Disable for a potential boot improvement.
echo "mount $KEEPASS_WEBDAV_MOUNT_PATH" > ~/.bash_profile #Running on login.
mount $KEEPASS_WEBDAV_MOUNT_PATH

#### Thunderbird

sudo apt install -y thunderbird

#### VLC

sudo apt install -y vlc

### Programming

#### Discord

# sudo apt install gdebi-core
wget -O ~/discord.deb "https://discordapp.com/api/download?platform=linux&format=deb"
sudo apt install -y ~/discord.deb
sudo rm -rf ~/discord.deb

#### Git

sudo apt install -y git

##### Git Configuration

git config --global user.name "$GIT_USER_NAME"
git config --global user.email "$GIT_USER_EMAIL"

###### GPG Key

#### Rustdesk

#wget -O ~/rustdesk.deb "https://github.com/rustdesk/rustdesk/releases/download/1.1.9/rustdesk-1.1.9.deb"
#sudo apt install -y pulseaudio ~/rustdesk.deb
#sudo rm -rf ~/rustdesk.deb

#### VS Code

sudo apt-get install wget gpg
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
rm -f packages.microsoft.gpg
sudo apt install -y apt-transport-https
sudo apt update
sudo apt install -y code

### Gaming

#### Lutris

sudo apt update
sudo apt install -y lutris

#### Steam

sudo dpkg --add-architecture i386
sudo apt update
sudo apt-get install -y steam

#### Minecraft

wget -O ~/minecraft.deb "https://launcher.mojang.com/download/Minecraft.deb"
sudo apt install -y ~/minecraft.deb
sudo rm -rf ~/minecraft.deb

### Power Management/Performance

sudo apt install -y tlp tlp-rdw
#https://linrunner.de/tlp/settings/processor.html #***** TODO

## Final updating to ensure verything is up-to-date.
sudo apt update
sudo apt upgrade -y
sudo apt auto-remove -y
