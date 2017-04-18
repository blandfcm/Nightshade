#!/bin/bash

# Read password
echo -n ESSID:
read name

# Read password
echo -n Password:
read -s password

# create the wpa_supplicant.conf file with updated info for wifi
echo ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev > a.txt
echo update_config=1 >> a.txt
echo country=US >> a.txt
echo >> a.txt
echo network={ >> a.txt
echo -e "\tssid=\"$name\"" >> a.txt
echo -e "\tpsk=\"$password\"" >> a.txt
echo } >> a.txt

sudo cp a.txt /etc/wpa_supplicant/wpa_supplicant.conf
rm a.txt

# These commands will reset the wifi to allow for it to reconnect without reboot
sudo ifdown wlan1
sudo ifup wlan1


echo
