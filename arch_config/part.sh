#!/bin/sh

source $(pwd)/arch_config/misc.sh

NULL=/dev/null

function create_user
{
	useradd -m $1
	N_OK "Created new user $1"
	N_WAR "Enter new password for user $1"
	passwd $1
}

function core_tools
{
	N_WAR "Updating pacman repo"
	yes "" | sudo  pacman -Syu > $NULL

	N_WAR "Installing X utils for graphics"
	yes "" | pacman -S xorg sudo gksudo \
			 xorg-servers xorg-drivers \
			 xorg-xinit xorg-xterm dialog > $NULL
	INST_OK "Basic graphical libraries and tools"
	
	N_WAR "Installing network related tools"
	yes y  | pacman -S xorg-xinit xorg-xterm dialog
			 wpa_supplicant wpa_supplicant_gui \
			 networkmanager network-manager-applet \
			 dnsmasq bluez ppp dhclient \
			 modemmanager > $NULL
}
