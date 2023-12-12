#!/bin/bash

# Installation Script

## Importing Variables

if [ -f .env ]; then
	while IFS= read -r line || [[ -n "$line" ]]; do
		if [[ ! $line =~ ^\ *# && $line =~ .*= ]]; then
			# Split the value into the two pairs, delimited by the equals sign (=).
			key=$(echo "$line" | cut -d= -f1);
			value=$(echo "$line" | cut -d= -f2-);
			# Trim leading/trailing whitespace and quotations from the value
			value=$(echo "$value" | sed -e 's/^[[:space:]"'"'"']*//' -e 's/[[:space:]"'"'"']*$//');
			export "$key=$value";
		fi
	done < .env
else
	echo 'INSTALLATION CANCELLED.';
	echo 'No .env file found. Get the example from: https://github.com/jadinheaston/Linux-Configuration/blob/main/.env.example';
	exit;
fi

## Command Aliases

touch ~/.bash_aliases;

## Adding repositories

sudo add-apt-repository -y multiverse;

## Performing initial update

sudo apt update;
sudo apt upgrade -y; #Updating apt

## Software

### General

#### dconf Customization

if [ "${DCONF_EDIT,}" == "true" ]; then
	sudo apt install -y dconf-editor gnome-shell-extension-manager;
	echo 'DCONF_EDIT: Install "Blur my Shell (aunetx)" via Extensions and set Sigma to 5 with brighness intensity to .35';

	gsettings set org.gnome.mutter workspaces-only-on-primary $DCONF_WORKSPACES_ONLY_ON_PRIMARY;
	gsettings set org.gnome.settings-daemon.plugins.power idle-dim $DCONF_IDLE_DIM;
	gsettings set org.gnome.desktop.wm.preferences resize-with-right-button $DCONF_RESIZE_WINDOWS_WITH_RMB;

	##### Desktop

	gsettings set org.gnome.desktop.background picture-uri-dark file:///usr/share/backgrounds/Multiverse_by_Emanuele_Santoro.png;
	if [ "${DCONF_DISABLE_DESKTOP,}" == "true" ]; then
		gnome-extensions disable ding@rastersoft.com; #Disable desktop icons.
	fi

	##### Dock

	gsettings set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size $DCONF_DASH_MAX_ICON_SIZE;
	gsettings set org.gnome.shell.extensions.dash-to-dock extend-height $DCONF_EXTEND_HEIGHT;
	gsettings set org.gnome.shell.extensions.dash-to-dock multi-monitor $DCONF_MULTI_MONITOR;
	gsettings set org.gnome.shell.extensions.dash-to-dock show-mounts $DCONF_SHOW_MOUNTS;
	gsettings set org.gnome.shell.extensions.dash-to-dock show-mounts-network $DCONF_SHOW_MOUNTS_NETWORK;
	gsettings set org.gnome.shell.extensions.dash-to-dock show-trash $DCONF_SHOW_TRASH;
	gsettings set org.gnome.shell.extensions.dash-to-dock dock-fixed $DCONF_DOCK_FIXED;
	gsettings set org.gnome.shell.extensions.dash-to-dock dock-position $DCONF_DOCK_POSITION;
	gsettings set org.gnome.shell.extensions.dash-to-dock require-pressure-to-show $DCONF_REQUIRE_PRESSURE_TO_SHOW;

	##### Taskbar

	gsettings set org.gnome.desktop.interface clock-show-seconds $DCONF_CLOCK_SHOW_SECONDS;
	gsettings set org.gnome.desktop.interface clock-format $DCONF_CLOCK_FORMAT;
	gsettings set org.gnome.desktop.interface clock-show-weekday $DCONF_CLOCK_SHOW_WEEKDAY;
	gsettings set org.gnome.desktop.interface show-battery-percentage $DCONF_SHOW_BATTERY_PERCENTAGE;
fi

#### Firefox

if [ "${INSTALL_FIREFOX,}" == "true" ]; then
	sudo apt install -y firefox
fi

#### KeePassXC

if [ "${INSTALL_KEEPASSXC,}" == "true" ]; then
	sudo add-apt-repository -y ppa:phoerious/keepassxc;
	sudo apt update;
	sudo apt install -y keepassxc

	##### Enabling auto-type

	##### Enabling WebDav support

	sudo apt install -y davfs2
	#sudo dpkg-reconfigure davfs2
	sudo mkdir -p "$KEEPASS_WEBDAV_MOUNT_PATH"
	sudo mkdir ~/.davfs2
	sudo touch ~/.davfs2/secrets
	sudo chown $USER:$USER -R ~/.davfs2
	echo "$KEEPASS_WEBDAV_URL	$KEEPASS_WEBDAV_USERNAME	$KEEPASS_WEBDAV_PASSWORD" >> ~/.davfs2/secrets #Tab delimited (# act as comments, escape them)
	sudo chmod 600 ~/.davfs2/secrets
	sudo su -c "echo \"$KEEPASS_WEBDAV_URL \"$KEEPASS_WEBDAV_MOUNT_PATH\" davfs user,_netdev,auto,file_mode=600,dir_mode=700 0 1\" >> /etc/fstab"
	sudo usermod -a -G davfs2 $USER
	sudo systemctl enable NetworkManager-wait-online.service #Disable for a potential boot improvement.
	touch ~/.bash_profile
	echo "mount \"$KEEPASS_WEBDAV_MOUNT_PATH\"" > ~/.bash_profile #Running on login.
	mount "$KEEPASS_WEBDAV_MOUNT_PATH"
fi

#### Thunderbird

if [ "${INSTALL_THUNDERBIRD,}" == "true" ]; then
	sudo apt install -y thunderbird
fi

#### VLC

if [ "${INSTALL_VLC,}" == "true" ]; then
	sudo apt install -y vlc
fi

### Programming

#### Discord

if [ "${INSTALL_DISCORD,}" == "true" ]; then
	# sudo apt install gdebi-core
	wget -O ~/discord.deb "https://discordapp.com/api/download?platform=linux&format=deb"
	sudo apt install -y ~/discord.deb
	sudo rm -rf ~/discord.deb
fi

#### Git

if [ "${INSTALL_GIT,}" == "true" ]; then
	sudo apt install -y git
	
	##### Git Configuration

	git config --global user.name "$GIT_USER_NAME"
	git config --global user.email "$GIT_USER_EMAIL"

	###### GPG Key
fi

#### Rustdesk

if [ "${INSTALL_RUSTDESK,}" == "true" ]; then
	echo 'RUSTDESK INTSALLATION WiP. NO INSTALLATION DONE.';
	#wget -O ~/rustdesk.deb "https://github.com/rustdesk/rustdesk/releases/download/1.1.9/rustdesk-1.1.9.deb"
	#sudo apt install -y pulseaudio ~/rustdesk.deb
	#sudo rm -rf ~/rustdesk.deb
fi

#### VS Code

if [ "${INSTALL_VSCODE,}" == "true" ]; then
	sudo apt-get install wget gpg
	wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
	sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
	sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
	rm -f packages.microsoft.gpg
	sudo apt install -y apt-transport-https
	sudo apt update
	sudo apt install -y code
fi

### Gaming

#### Lutris

if [ "${INSTALL_LUTRIS,}" == "true" ]; then
	sudo add-apt-repository -y ppa:lutris-team/lutris;
	sudo apt update
	sudo apt install -y lutris
fi

#### Steam

if [ "${INSTALL_STEAM,}" == "true" ]; then
	sudo dpkg --add-architecture i386
	sudo apt update
	sudo apt-get install -y steam
fi

#### Minecraft

if [ "${INSTALL_MINECRAFT,}" == "true" ]; then
	wget -O ~/minecraft.deb "https://launcher.mojang.com/download/Minecraft.deb"
	sudo apt install -y ~/minecraft.deb
	sudo rm -rf ~/minecraft.deb
fi

### Power Management/Performance

if [ "${INSTALL_TLP,}" == "true" ]; then
	sudo apt install -y tlp tlp-rdw
	#https://linrunner.de/tlp/settings/processor.html #***** TODO
fi

## Final updating to ensure verything is up-to-date.
sudo apt update
sudo apt upgrade -y
sudo apt auto-remove -y
