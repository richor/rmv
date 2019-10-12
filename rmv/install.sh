#!/bin/sh

echo "input the directory you want to put the rmv command into(do not use ~):\n(to use the default directory /usr/local/bin, type enter please) \n"

read dirpath

if [ -z $dirpath ]; then
    dirpath=/usr/local/bin
    echo "copying 'rmv' to /usr/local/bin...\n"
    cp ./rmv $dirpath
    echo "successfully install the rmv!\n" 
elif [ -e $dirpath ]; then
    echo "the directory" $dirpath "exists already, are you sure want to copy command "rmv" to this place? [Y/N]"
    read ans
    if [ $ans = "Y" ]; then
    cp ./rmv $dirpath
    echo "successfully install command rmv!\n" 
    else
        echo "successfully exiting the installation\n"
    fi
else
    echo "the" $dirpath "doesn't exist, are you sure want to create this directory and copy command "rmv" to this place? [Y/N]" 
    read ans
    if [ $ans = "Y" ]; then
        mkdir $dirpath
        cp ./rmv $dirpath
        echo "successfully install the rmv!\n" 
    else
        echo "successfully exiting the installation\n"
    fi
fi

# modify the command rm to require confirmation
echo "do you want to add alias to .bash_profile? [Y/N]"
read ans
if [ $ans = "Y" ]; then
echo "alias rm='rm -i'" >> ~/.bash_profile
fi
