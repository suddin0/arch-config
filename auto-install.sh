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


printf "\e[38;5;82mWould you like to set a root password? y, N\n\e[39m"
read root_pass
if [[ $root_pass == +("y"|"Y"|"yes") ]]
then
	passwd
fi


#create new user and it's password
printf "\e[38;5;82mCreate a new user :  y, N\n\e[39m"
read creat_n_user
if [[ $creat_n_user == +("y"|"Y"|"yes") ]]
then
  printf "\e[38;5;82mNew user name :\n\e[39m"
  read n_user_name
  useradd -m $n_user_name
  printf "\e[38;5;82m:The user $n_user_name is created\n\e[39m"
  printf "\e[38;5;82m:Enter a password for  $n_user_name:\n\e[39m"
  passwd $n_user_name
fi


printf "\e[38;5;82mWould you like to set your computer in French? y/N \e[39m"
read -a lchoice
if [[ $lchoice == +("y"|"Y"|"yes") ]];
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
  localectl set-locale LANG=fr_FR.UTF-8
  export LANG=C

fi

#update pkg lists and upgrade
printf "\e[38;5;82mUpdating corrent repo and softwares\n\e[39m"
yes "" | pacman -Syu

#install the graphique softwares
printf "\e[38;5;82mInstalling graphical utils\n\e[39m"
yes "" | pacman -S xorg sudo
yes "" | pacman -S xorg-servers xorg-drivers

#install the Network softwares and enabling network manager
printf "\e[38;5;82mInstalling Network utils\n\e[39m"
yes y  | pacman -S xorg-xinit xorg-xterm dialog wpa_supplicant wpa_supplicant_gui
yes y  | pacman -S networkmanager network-manager-applet dnsmasq bluez ppp dhclient
yes y  | pacman -S modemmanager
printf "\e[38;5;82mEnabling NetworkManager\n\e[39m"
systemctl enable NetworkManager.service

#install the Desktop Environment
printf "\e[38;5;82mInstalling Xfce4 environment and cie\n\e[39m"
yes "" | pacman -S xfce4 fish thunar gnome-disk-utility
yes "" | pacman -S xfce4-goodies

#installing the softwares
printf "\e[38;5;82mInstalling languages, libraries and varias other tools\n\e[39m"
yes y  | pacman -S python python-setuptools python-pip sqlite mpdecimal xz tk 
yes y  | pacman -S python2 python2-setuptools python2-pip
yes y  | pacman -S gcc clang thunar sakura file-roller libcanberra gvfs nautilus
yes y  | pacman -S vim leafpad qt4
yes "" | pacman -S qt5
yes "" | pacman -S vlc
yes y  | pacman -S gdb valgrind
yes y  | pacman -S chromium pulseaudio pulseaudio-alsa pavucontrol wget ruby curl
yes "" | pacman -S firefox
yes y  | pacman -S pepper-flash transmission-gtk autofs udiskie

#graphic manipulation
printf "\e[38;5;82mInstall image editor tooms like gimp, inkscape, etc... Y, n\n\e[39m"
read hard_utils
if [[ $hard_utils != +("n"|"N"|"no"|"non") ]]
then
  yes y  | pacman -S inkscape gimp
fi

#install hardware manip utiles
printf "\e[38;5;82mInstall hardware utils Y, n\n\e[39m"
read hard_utils
if [[ $hard_utils != +("n"|"N"|"no"|"non") ]]
then
  yes y  | pacman -S arduino
fi

#install office tools
printf "\e[38;5;82mInstall libre office Y, n\n\e[39m"
read hard_utils
if [[ $hard_utils != +("n"|"N"|"no"|"non") ]]
then
  yes y  | pacman -S libreoffice-fresh
fi




#install Yaourt Package manager
printf "\e[38;5;82mSeting yourt Package manager\n\e[39m"
echo "

[archlinuxfr]
SigLevel = Never
Server = http://repo.archlinux.fr/\$arch " >> /etc/pacman.conf
yes y | pacman -Sy yaourt

#installing theme manager
#bash theme-manager/configure
#make

printf "\e[38;5;82mSetting themes on /usr/share/themes \n\e[39m"
cp -rf ./themes/arc-dark /usr/share/themes/Arc-Dark

#putting config files
if [[ $creat_n_user == +("y"|"Y"|"yes") ]]
then
  printf "\e[38;5;82mSetting Conf files \n\e[39m"
  if [[ ! -d "/home/$n_user_name/.config" ]]
  then
    mkdir "/home/$n_user_name/.config" #create the directory in user space
    echo ./conf/fish-conf.fish > /home/$n_user_name/.config/fish/config.fish
  else
    echo ./conf/fish-conf.fish > /home/$n_user_name/.config/fish/config.fish
  fi
  cp -f ./conf/tmux.conf /home/$n_user_name/.tmux.conf

fi

#install virtual machine
printf "\e[38;5;82mWould you like to install virtual box: Y,n \n\e[39m"
read v_machine
if [[ $v_machine != +("n"|"N"|"no"|"non") ]]
then
  MACHINE_TYPE=`uname -m`
  if [[ $MACHINE_TYPE == "x86_64" ]]
  then
    printf "\e[38;5;82mInstalling Virtual machine for x86_64 arch\n\e[39m"
    curl "http://download.virtualbox.org/virtualbox/5.1.26/VirtualBox-5.1.26-117224-Linux_amd64.run" | sh
  else
    printf "\e[38;5;82mInstalling Virtual machine for x86 arch\n\e[39m"
    wget "http://download.virtualbox.org/virtualbox/5.1.26/VirtualBox-5.1.26-117224-Linux_x86.run" | sh
  fi
fi


#add user to sudo groupe . It is done now as the sudo is installed by now
if [[ $v_machine != +("n"|"N"|"no"|"non") ]]
then
  usermod -aG sudo $n_user_name
fi



#Install a boot loader

printf "\e[38;5;82mChose a boot loader\n\e[39m"

printf "\e[38;5;226m1: Syslinux : A simple and light weight bootloader\n\e[39m"
printf "\e[38;5;226m2: Grub2    : A complete bootloader with a lot of options\n\n\e[39m"




printf "\e[38;5;82mDefault bootloader: Syslinux\n\n\e[39m"
printf "\e[38;5;82m: \e[39m"
read bootloader
yes "" | pacman -Syu

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
  printf "\e[38;5;82mInstalling syslinux and setting it up\n\e[39m"
  yes y | pacman -S syslinux
  yes y | pacman -S gptfdisk
  syslinux-install_update -i -a -m
fi


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
  cp -rf  ./themes/deepin /usr/share/sddm/themes/deepin
  cat     ./conf/sddm.conf > /etc/sddm.conf
fi



printf "\e[38;5;226mDo not forget to set your pertition to boot in /boot/syslinux/syslinux.cfg\n\e[39m"
