#! /bin/bash

ISO="TempValue"

read -p "Enter location of ISO: " ISO

if [ -e "/var/mnt/iso" ]; then
    echo "Mounting to /var/mnt/iso"
    sudo mount -o loop """$ISO""" /mnt/iso
else
    echo "/var/mnt/iso does not exist, creating mounting path"
    sudo mkdir /mnt/iso
    sudo mount -o loop """$ISO"""/mnt/iso
fi

xdg-open /var/mnt/iso

read -p "When done type "unmount": "

sudo umount /var/mnt/iso
