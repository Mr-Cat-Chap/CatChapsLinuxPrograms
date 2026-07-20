#! /bin/bash

CurrentDevice1=$(pactl list sinks short | awk 'NR == 1 {print $2}')
CurrentDevice2=$(pactl list sinks short | awk 'NR == 2 {print $2}')
CurrentDevice=$(pactl get-default-sink short | awk 'NR == 1 {print $1}')
#pactl list sinks short
#pactl get-default-sink short
#echo $CurrentDevice1
#echo $CurrentDevice2

if [ $CurrentDevice == $CurrentDevice1 ]; then
    pactl set-default-sink $CurrentDevice2
    #echo $CurrentDevice2
else
    pactl set-default-sink $CurrentDevice1
    #echo $CurrentDevice1
fi

pactl play-sample service-login

# This works amazingly!
