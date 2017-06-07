#!/bin/bash

clear

file="/etc/localtime"
if [ -f "$file" ]
then
	rm -f $file
fi
printf "\e[38;5;82mTime is set as Europe/Paris\n\e[39m"
ln -s /usr/share/zoneinfo/Europe/Paris /etc/localtime


printf "\e[38;5;82mComputer name: \e[39m"
read cname
echo $cname > /etc/hostname

printf "\e[38;5;82mWould you like to set your computer in French? y/N \e[39m"
read -a lchoice
if [[ $lchoice == "y" ]];
then
  echo "
  LC_PAPER=fr_FR.UTF-8
  LC_IDENTIFICATION=fr_FR.UTF-8
  LC_TELEPHONE=fr_FR.UTF-8
  LANG=fr_FR.UTF-8
  LC_MONETARY=fr_FR.UTF-8
  LC_NAME=fr_FR.UTF-8
  LC_NUMERIC=fr_FR.UTF-8
  LC_MEASUREMENT=fr_FR.UTF-8
  LC_TIME=fr_FR.UTF-8
  LC_ADDRESS=fr_FR.UTF-8" > /etc/locale.conf
fi

printf "\e[38;5;82mChose a boot loader\n\e[39m"

printf "\e[38;5;226m1: Syslinux : A simple and light weight bootloader\n\e[39m"
printf "\e[38;5;226m2: Grub2    : A complete bootloader with a lot of options\n\n\e[39m"

printf "\e[38;5;82mDefault bootloader: Syslinux\n\n\e[39m"
printf "\e[38;5;82m: \e[39m"
read bootloader

if [[ $bootloader == "2" ]]
then
  printf "\e[38;5;226mProvide your main partition where iso is installed (Ex: /dev/sda)\n\e[39m"
  read grubpart
  yes y | pacman -S grub
  if [[ $grubpart == "" ]];
  then
    printf "\e[38;5;226mPartition is not specified. Grub will be installed in /dev/sda\n\e[39m"
    grub-install --target=i386-pc /dev/sda
  else
    grub-install --target=i386-pc $grubpart
  fi
else
  yes y | pacman -S syslinux
  yes y | pacman -S gptfdisk
  syslinux-install_update -i -a -m
fi

#install the graphique softwares
yes "" | pacman -S xorg
yes "" | pacman -S xorg-servers

#install the Network softwares and enabling network manager
yes y  | pacman -S xorg-xinit xorg-xterm dialog wpa_supplicant wpa_supplicant_gui
yes y  | pacman -S networkmanager network-manager-applet dnsmasq bluez ppp dhclient
yes y  | pacman -S modemmanager wicd
systemctl enable NetworkManaget.service

#install the Desktop Environment
yes "" | pacman -S xfce4
yes "" | pacman -S xfce4-goodies

#installing the softwares
yes y  | pacman -S python python-setuptools python-pip sqlite mpdecimal xz tk
yes y  | pacman -S python2 python2-setuptools python2-pip
yes y  | pacman -S gcc thunar sakura file-roller libcanberra gvfs vlc nautilus
yes y  | pacman -S chromium firefox pulseaudio pulseaudio-alsa pavucontrol wget


#install sublime text
curl -O https://download.sublimetext.com/sublimehq-pub.gpg
pacman-key --add sublimehq-pub.gpg
pacman-key --lsign-key 8A8F901A
rm sublimehq-pub.gpg
echo -e "\n[sublime-text]\nServer = https://download.sublimetext.com/arch/dev/x86_64" | sudo tee -a /etc/pacman.conf
sudo pacman -S sublime-text

#installing theme manager
#bash theme-manager/configure
#make


#installing Display manager to login
printf "\e[38;5;82mChose a Display Manager\n\e[39m"

printf "\e[38;5;226m1: SDDM    : SDDM is a modern display manager for X11 and \
Wayland aiming to be fast, simple and beautiful.\n\e[39m"
printf "\e[38;5;226m2: LightDM : LightDM is a cross-desktop display manager.\n\n\e[39m"


printf "\e[38;5;82mDefault Display Manager: SDDM\n\n\e[39m"
printf "\e[38;5;82m: \e[39m"
read dmopt
if [[ $dmopt == "2" ]]
then
  yes y | pacman -S lightdm lightdm-gtk-greeter
  systemctl enable lightdm
else
  yes y | pacman -S sddm
  systemctl enable sddm
fi


printf "\e[38;5;226mDo not forget to set your pertition to boot in /boot/syslinux/syslinux.cfg\n\e[39m"
