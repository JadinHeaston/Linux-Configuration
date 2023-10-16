#!/bin/bash
# Installation Script

## Command Aliases

touch ~/.bash_aliases
## Adding repositories

sudo add-apt-repository -y multiverse # Adding Multiverse repository.
sudo add-apt-repository -y ppa:phoerious/keepassxc
sudo add-apt-repository -y ppa:lutris-team/lutris

## Performing initial update

sudo apt update
sudo apt upgrade -y # Updating apt

## Software

### General

#### Gnome Customization

gsettings set org.gnome.desktop.background picture-uri-dark file:///usr/share/backgrounds/Multiverse_by_Emanuele_Santoro.png

##### (blur-my-shell)(https://github.com/aunetx/blur-my-shell)

git clone "https://github.com/aunetx/blur-my-shell"
cd blur-my-shell
make install
cd ~
sudo rm -rf ~/blur-my-shell

##### (improvided workspace indicator)[https://github.com/MichaelAquilina/improved-workspace-indicator]

git clone "https://github.com/MichaelAquilina/improved-workspace-indicator.git"
cd improved-workspace-indicator
make install
cd ~
sudo rm -rf ~/improved-workspace-indicator

##### (netspeedsimplified)[https://github.com/prateekmedia/netspeedsimplified]

git clone "https://github.com/prateekmedia/netspeedsimplified.git"
cd netspeedsimplified
make install
cd ~
sudo rm -rf ~/netspeedsimplified

##### (vitals)[https://github.com/corecoding/Vitals]

sudo apt install gnome-shell-extension-manager gir1.2-gtop-2.0 lm-sensors




exit 1
#### Firefox

sudo apt install -y firefox

#### KeePassXC

sudo apt install -y keepassxc
##Enabling auto-type
#touch ~/.bash_aliases

##### Enabling WebDav support

sudo apt install davfs2
#sudo dpkg-reconfigure davfs2
mkdir -p {KEEPASS_WEBDAV_MOUNT_PATH}
mkdir ~/.davfs2/
touch ~/.davfs2/secrets
echo "https://kp.jadinheaston.com/	{KEEPASS_WEBDAV_USERNAME}	{KEEPASS_WEBDAV_PASSWORD}" > ~/.davfs2/secrets #Tab delimited
chmod 600 ~/.davfs2/secrets
echo "https://kp.jadinheaston.com/ {KEEPASS_WEBDAV_MOUNT_PATH} davfs user,_netdev,auto,file_mode=600,dir_mode=700 0 1" > /etc/fstab
sudo usermod -a -G davfs2 {USERNAME}
touch ~/.bash_profile
sudo systemctl enable NetworkManager-wait-online.service #Disable for a potential boot improvement.
echo "mount {KEEPASS_WEBDAV_MOUNT_PATH}" > ~/.bash_profile #Running on login.
mount {KEEPASS_WEBDAV_MOUNT_PATH}

#### Thunderbird

sudo apt install -y thunderbird

#### VLC

sudo apt install -y vlc

### Programming

#### Beekeeper


#### Discord

# sudo apt install gdebi-core
wget -O ~/discord.deb "https://discordapp.com/api/download?platform=linux&format=deb"
sudo rm -rf ~/discord.deb


#### Git

sudo apt install -y git

##### Git Configuration

git config --global user.name "Jadin Heaston"
git config --global user.email "jadin+heaston"

###### GPG Key

#### Rustdesk

wget -O ~/rustdesk.deb https://github.com/rustdesk/rustdesk/releases/download/1.1.9/rustdesk-1.1.9.deb
sudo apt install ~/rustdesk.deb
sudo rm -rf ~/Minecraft.deb

#### VS Code

sudo apt-get install wget gpg
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
rm -f packages.microsoft.gpg
sudo apt install apt-transport-https
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

wget -O ~/Minecraft.deb https://launcher.mojang.com/download/Minecraft.deb
sudo apt install -y ~/Minecraft.deb
sudo rm -rf ~/Minecraft.deb

### Power Management/Performance

sudo apt install -y tlp tlp-rdw
#https://linrunner.de/tlp/settings/processor.html #***** TODO

## Final updating to ensure verything is up-to-date.
sudo apt update
sudo apt upgrade -y
sudo apt auto-remove -y
killall -3 gnome-shell
