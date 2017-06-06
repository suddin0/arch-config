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

printf "\e[38;5;11m1: Syslinux : A simple and light weight bootloader\n\e[39m"
printf "\e[38;5;11m2: Grub2    : A complete bootloader with a lot of options\n\n\e[39m"

printf "\e[38;5;82mDefault bootloader: Syslinux\e[39m"
read bootloader

if [[ $bootloader == "2" ]]
then
  echo "install Grub2"
fi
