#!/bin/bash

# Read Wifi Name
echo -n ESSID:
read wifi

# Read username
echo -n User:
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
echo -e "\tssid=\"$wifi\"" >> a.txt
echo -e "\tscan_ssid=1" >> a.txt
echo -e "\tkey_mgmt=IEEE8021X" >> a.txt
echo -e "\teap=PEAP" >> a.txt
echo -e "\tphase2=\"auth_MSCHAPV2\"" >> a.txt
echo -e "\tidentity=\"$name\"" >> a.txt
echo -e "\tpassword=\"$password\"" >> a.txt
echo } >> a.txt

#sudo cp a.txt /etc/wpa_supplicant/wpa_supplicant.conf
#rm a.txt

# These commands will reset the wifi to allow for it to reconnect without reboot
#sudo ifdown wlan0
#sudo ifup wlan0

# other tutorial said
#sudo /etc/init.d/networking restart


echo
