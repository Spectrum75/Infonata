#!/usr/bin/env bash
# Runs all commands at once.
# Variables:
ip=$(ip addr | grep 'state UP' -A2 | tail -n1 | awk '{print $2}' | cut -f1 -d'/')
ip2=$(wget -qO- ipinfo.io/ip)
user=$(eval getent passwd {$(awk '/^UID_MIN/ {print $2}' /etc/login.defs)..$(awk '/^UID_MAX/ {print $2}' /etc/login.defs)} | cut -d: -f1)
function error {
  echo -e "\\e[91m$1\\e[39m"
  exit 1
}
echo -e "\e[7mDistro And Software Information:\e[0m"
echo -en '\n'
echo -en '\n'
neofetch || error \e[31mNeofetch was not found, please install it...\e[0m
echo -en '\n'
echo -en '\n'
echo -en '\n'
echo -en '\n'
echo -e "\e[7mHardware Information:\e[0m"
echo -en '\n'
inxi -Fxxx || error \e[31mInxi was not found, please install it...\e[0m
echo -en '\n'
echo -en '\n'
echo -e "\e[7mIP Addresses:\e[0m"
echo "Local Adress: $ip"
echo "Public Adress: $ip2" || error \e[31mUnable to get public IP, please check your internet connection...\e[0m
echo -en '\n'
echo -en '\n'
echo -en '\n'
echo -e "\e[7mSystem Temperature:\e[0m
$(sensors)" || error \e[31Lm-sensors was not found, please install it...\e[0m
echo -en '\n'
echo -en '\n'
echo -en '\n'
echo -en '\n'
echo -e "\e[7mNormal User Accounts In The System:\e[0m
$user"
