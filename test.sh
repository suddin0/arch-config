#!/bin/sh

echo "A directory name ?"
read dirname
if [[ ! -d "/home/$dirname/.config" ]]
then
	echo "There is no such Directory: $dirname"
else
	echo "Directory exists"
fi