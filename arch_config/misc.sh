#!/bin/sh


COL_OK="\e[92m"
COL_WAR="\e[93m"
COL_ERR="\e[91m"
COL_DEF="\e[97m"


# Notice of installation
function INST_OK 
{
	echo -e "$COL_OK[+] installed $1 $COL_DEF"
}

# notice positive
function N_OK 
{
	echo -e "$COL_OK[+] $1$COL_DEF"
}

# notice Warning
function N_WAR 
{
	echo -e "$COL_WAR[!] $1$COL_DEF"
}

# notice Negative 
function N_ERR 
{
	echo -e "$COL_ERR[X] $1$COL_DEF"
}
