#! /bin/bash

#The TV in my current setup has it's status on awk's print $1 NR 52, so find out if it equals "disabled"

#Making it better, find the line for the port we wanna turn off DP-1 HDMI-A-1 ect, then go the next line and see if it's enabled, if it is turn it off, we only really need to do this for DP-2 which is the TV in this case

#Finding the DP-2 status

#kscreen-doctor -o | awk '{print NR,$0}'

DP2=$(kscreen-doctor -o | awk '/DP-2/ {print NR}')
DP2=$((DP2+1))
TVStatus=$(kscreen-doctor -o | awk -v DP2="$DP2" 'NR == DP2 {print $1}')

if [[ $TVStatus =~ "disabled" ]]; then
    kscreen-doctor output.DP-2.enable
    kscreen-doctor output.HDMI-A-1.disable
    kscreen-doctor output.DP-1.disable
else
    kscreen-doctor output.HDMI-A-1.enable
    kscreen-doctor output.DP-1.enable
    kscreen-doctor output.DP-2.disable
    kscreen-doctor output.HDMI-A-1.primary
fi

