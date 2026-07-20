#! /bin/bash

Wait=120m

#For when it#S started without console
kdialog --title "Bash Script" --passivepopup "Shutdown started, set for $Wait" 5

echo Script started, waiting $Wait then will run ToggleTV and shutdown

$(sleep $Wait)

"/home/MrCatChap/Syncedfolders/Programs I ve made (Desktop host)/TVMode (Switching monitors off and only having TV on)/TVMode.sh"

Wait=30s

$(systemctl poweroff)

echo Done
