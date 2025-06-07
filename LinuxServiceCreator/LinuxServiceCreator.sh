#! /bin/bash
#Stuff with "TempValue" is probably waiting for user input
#Need to set stuff like --no-browser and --no-restart depending on the program, so ask the user if they want them turned on, maybe turn them on by default though
ServicesFolder="/home/MrCatChap/.config/systemd/user/"
ServiceName="TempValue"
ServiceLauncher="TempValue"
ServiceDescription="TempValue"

read -p "Enter name of service, this will be what it's called in the services folder " ServiceName

read -p "Enter location of application to launch " ServiceLauncher
echo $ServiceLauncher

read -p "Describe what the program is for " ServiceDescription
echo $ServiceDescription

#Below is the service text
cat << EOF > $ServicesFolder$ServiceName.service
[Unit]
Description=$ServiceDescription
StartLimitIntervalSec=60
StartLimitBurst=4

[Service]
ExecStart=$ServiceLauncher serve --no-browser --no-restart --logflags=0
Restart=on-failure
RestartSec=1
SuccessExitStatus=3 4
RestartForceExitStatus=3 4

# Hardening
SystemCallArchitectures=native
MemoryDenyWriteExecute=true
NoNewPrivileges=true

[Install]
WantedBy=default.target
EOF

#This has to be run fpr the service to be enabled
systemctl --user enable --now $ServiceName
if [ $? == 0 ]; then
    echo Service started
else
    echo Service probably not started
fi
