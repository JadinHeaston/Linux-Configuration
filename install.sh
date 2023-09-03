#!/bin/bash
# Installation Script

## Adding repositories

sudo add-apt-repository multiverse # Adding Multiverse repository.
sudo add-apt-repository ppa:phoerious/keepassxc
sudo add-apt-repository ppa:lutris-team/lutris

# Performing initial install

sudo apt update && sudo apt upgrade -y # Updating apt

## Software

### General

#### Firefox

sudo apt install firefox

#### KeePassXC

sudo apt install keepassxc

### VLC

sudo apt install vlc

### Programming

#### Beekeeper


#### Git

sudo apt install git

##### Git Configuration

git config --global user.name "Jadin Heaston"
git config --global user.email "jadin+heaston"

###### GPG Key

#### VS Code

sudo apt install software-properties-common apt-transport-https wget
wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
sudo apt install code -y

### Gaming

#### Lutris

sudo apt update
sudo apt install lutris

#### Steam

#sudo apt-get install steam -y

#### Minecraft

wget https://launcher.mojang.com/download/Minecraft.deb
sudo apt install ./Minecraft.deb
sudo rm -rf ./Minecraft.deb


# Final updating to ensure verything is up-to-date.
sudo apt update && sudo apt upgrade -y