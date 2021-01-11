#!/usr/bin/env bash
# Dialog Dimensions:
HEIGHT=15
WIDTH=55
CHOICE_HEIGHT=10

# Options:
OPTIONS=(1 "Check Your Distro Info"
2 "Check Your System's Hardware Info"
3 "IP Check"
4 "Check System Temperature"
5 "About"
6 "Run All"
7 "Check User Accounts"
8 "Exit")

# Data For Options:
CHOICE=$(dialog --clear \
--backtitle "Welcome To The Infonata Script!" \
--title "Menu" \
--menu "Please Choose The Appropriate Option Below:" \

$HEIGHT $WIDTH $CHOICE_HEIGHT \
"${OPTIONS[@]}" \
2>&1 >/dev/tty)
# Variables:
ip=$(ip addr | grep 'state UP' -A2 | tail -n1 | awk '{print $2}' | cut -f1 -d'/')
ip2=$(wget -qO- ipinfo.io/ip)
user=$(eval getent passwd {$(awk '/^UID_MIN/ {print $2}' /etc/login.defs)..$(awk '/^UID_MAX/ {print $2}' /etc/login.defs)} | cut -d: -f1)
clear
case $CHOICE in
        1)clear
            $HOME/di.sh
            ;;
        2)clear
           $HOME/hi.sh
            ;;
        3)dialog --title "Your IP Adresses:" --msgbox "Local Adress: $ip Public Adress: $ip2

Public IP was checked with ipinfo.io" 15 35 && clear
            ;;
        4)dialog --title "Your System Temperature:" --msgbox "$(sensors)" 15 35 && clear
       ;;
       5)dialog --title "About This Script" --msgbox "Infonata is a small utility to check a plethora of information related to your system :)

           Made By:
       Spectrumgamer75

           Visit:
www.github.com/spectrumgamer75" 15 35 && clear
;;

6)clear
 $HOME/all.sh
;;

7)dialog --title "User Accounts:" --msgbox "The following user accounts were found in the system:
$user" 15 35 && clear
;;

8)clear && exit 0
;;
esac
#######################################################
# Script Author: Spectrumgamer75                      #
# Visit Me On Github: www.github.com/spectrumgamer75  #
# Infonata Script version 1.0                         #
#######################################################
