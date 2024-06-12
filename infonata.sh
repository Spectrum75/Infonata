┌─────────────────────────────────────────────────────────┐
▴	        ✰  Made by Spectrum75                     ▴
▴ 	        www.github.com/spectrum75                 ▴
▴ 	        Infonata version 1.2-Beta                 ▴
└─────────────────────────────────────────────────────────┘

#!/usr/bin/env bash

# Dialog dimensions:
HEIGHT=15
WIDTH=60
CHOICE_HEIGHT=10

# Available options:
OPTIONS=(1 "View Distribution Information"
2 "View Hardware Information"
3 "View Local And Public IP Address"
4 "View CPU Temperature"
5 "About Infonata"
6 "Check User Accounts"
7 "Exit")

# The main page:
SELECTION=$(dialog --clear \
--backtitle "Welcome To Infonata!" \
--title "Selection Menu" \
--no-cancel \
--menu "Please Choose An Option Below:" \
$HEIGHT $WIDTH $CHOICE_HEIGHT \
"${OPTIONS[@]}" \
2>&1 >/dev/tty)

# The options:
clear
case $SELECTION in

1)while true; do
clear
sys_info=$(neofetch --stdout)
dialog --title "Minimal System Information" --msgbox "$sys_info" 0 0
response=$?
if [ $response -eq 0 ]; then
break
fi
sleep 5
done 
;;

# Use inxi with minor formatting, while omitting sensitive data:
2)inxi -Fxzi | grep -Ev 'Serial|Serial Number|UUID|Machine|Device|filter|serial' | sed 's/^System:/\nSystem:/g; s/^CPU:/\nCPU:/g; s/^Memory:/\nMemory:/g; s/^Storage:/\nStorage:/g; s/^Network:/\nNetwork:/g; s/^Graphics:/\nGraphics:/g; s/^Audio:/\nAudio:/g; s/^Drives:/\nDrives:/g; s/^Partition:/\nPartition:/g; s/^Sensors:/\nSensors:/g; s/^Info:/\nInfo:/g; s/^RAID:/\nRAID:/g; s/^Optical:/\nOptical:/g; s/^USB:/\nUSB:/g; s/^PCI:/\nPCI:/g; s/^Smart:/\nSmart:/g' > /tmp/infonata_hardware_info.txt
dialog --title "Hardware Information" --textbox /tmp/infonata_hardware_info.txt 0 0
;;

3)IP_CHECK=true
LOCAL_IP=$(ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1')
if [[ $IP_CHECK == true ]]; then
PUBLIC_IP=$(curl -s4 ip.me)
fi
dialog --title "Your IP Addresses:" --msgbox "Local Address: $LOCAL_IP Public Address: $PUBLIC_IP Public IP was checked with ip.me" 14 35 && clear
;;

4)clear 
while true; do
cpu_temp=$(sensors | grep 'Core' | awk '{print "Core " NR ": " $3}')
dialog --title "CPU Temperatures (Updated Every 5 Seconds)" --infobox "$cpu_temp" 0 0
sleep 5
done
;;

5)dialog --title "About This Script" --msgbox "Infonata is a small utility to check a plethora of information related to your system :)
        ./infonata.sh
    
                           Made By:
                        Spectrum75

                            Visit:
                www.github.com/spectrum75" 0 0 && clear
                ;;

6)AVAILABLE_REAL_USERS=$(cut -d: -f1,3 /etc/passwd | grep -E ':[0-9]{4}$' | cut -d: -f1)
dialog --title "User Accounts:" --msgbox "The following user accounts were found in the system:
$AVAILABE_REAL_USERS" 15 35 && clear
;;

7)clear && exit 0
;;
esac
