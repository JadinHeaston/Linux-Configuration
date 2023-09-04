#!/bin/bash
# Installation Script

## Adding repositories

sudo add-apt-repository -y multiverse # Adding Multiverse repository.
sudo add-apt-repository -y ppa:phoerious/keepassxc
sudo add-apt-repository -y ppa:lutris-team/lutris

# Performing initial install

sudo apt update && sudo apt upgrade -y # Updating apt

## Software

### General

#### Firefox

sudo apt -y install firefox

#### KeePassXC

sudo apt -y install keepassxc

### VLC

sudo apt -y install vlc

### Programming

#### Beekeeper


#### Git

sudo apt -y install git

##### Git Configuration

git config --global user.name "Jadin Heaston"
git config --global user.email "jadin+heaston"

###### GPG Key

#### VS Code

sudo apt -y install software-properties-common apt-transport-https wget
wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
sudo apt -y install code

### Gaming

#### Lutris

sudo apt update
sudo apt -y install lutris

#### Steam

#sudo apt-get -y install steam

#### Minecraft

wget https://launcher.mojang.com/download/Minecraft.deb
sudo apt -y install ./Minecraft.deb
sudo rm -rf ./Minecraft.deb


# Final updating to ensure verything is up-to-date.
sudo apt update && sudo apt upgrade -y