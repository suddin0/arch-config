#!/bin/bash

#ln -s /usr/share/zoneinfo/Europe/Paris /etc/localtime

printf "\e[38;5;82mComputer name: \e[39m"
read cname
#echo $cname > /etc/hostname

printf "\e[38;5;82mWould you like to set your computer in French? y/n \e[39m"
read -a lchoice
#if [[ $lchoice == "y" ]];
#then
#  echo "
#  LC_PAPER=fr_FR.UTF-8
#  LC_IDENTIFICATION=fr_FR.UTF-8
#  LC_TELEPHONE=fr_FR.UTF-8
#  LANG=fr_FR.UTF-8
#  LC_MONETARY=fr_FR.UTF-8
#  LC_NAME=fr_FR.UTF-8
#  LC_NUMERIC=fr_FR.UTF-8
#  LC_MEASUREMENT=fr_FR.UTF-8
#  LC_TIME=fr_FR.UTF-8
#  LC_ADDRESS=fr_FR.UTF-8" > /etc/locale.conf
#else
#  echo "done nothing"
#fi

printf "\e[38;5;82mChose a boot loader\n\e[39m"

printf "\e[38;5;226m1: Syslinux : A simple and light weight bootloader\n\e[39m"
printf "\e[38;5;226m2: Grub2    : A complete bootloader with a lot of options\n\n\e[39m"

printf "\e[38;5;82mDefault bootloader: Syslinux\n\n\e[39m"
printf "\e[38;5;82m: \e[39m"
read bootloader

if [[ $bootloader == "2" ]]
then
  yes y | pacman -S grub
else
  yes y | pacman -S grub
  yes y | pacman -S gptfdisk
  syslinux-install_update -i -a -m

fi

yes "" | pacman -S xorg
yes "" | pacman -S xorg-servers

yes y  | pacman -S xorg-xinit xorg-xterm dialog wpa_supplicant wpa_supplicant_gui\
networkmanager

yes "" | pacman -S xfce4
yes "" | pacman -S xfce4-goodies

yes y  | pacman -S python python-setuptools python-pip sqlite mpdecimal xz tk
yes y  | pacman -S python2 python2-setuptools python2-pip

yes y  |  pacman -S wget


printf "\e[38;5;226mDo not forget to set your pertition to boot in /boot/syslinux/syslinux.cfg\n\e[39m"
