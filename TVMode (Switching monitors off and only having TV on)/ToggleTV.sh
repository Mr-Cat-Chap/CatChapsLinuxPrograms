#! /bin/bash

#This is really basic and has no way of working in any other setup, it's specifically for my setup

#The TV in my current setup has it's status on awk's print $1 NR 52, so find out if it equals "disabled"

#31/05/2026 Need to update this to find the name of the TV and then find the second line after it, just had to update the NR line from 51 to 2 because it had changed the order it lists the devices

TVStatus=$(kscreen-doctor -o | awk 'NR == 52{print $1}')

echo TV is $TVStatus

if [[ $TVStatus =~ "disabled" ]]; then
    kscreen-doctor output.DP-2.enable
    kdialog --title "Bash Script" --passivepopup "TV turned on" 10
else
    kscreen-doctor output.DP-2.disable
    kdialog --title "Bash Script" --passivepopup "TV turned off" 10
fi
