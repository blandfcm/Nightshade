#!/bin/bash

./wpa_setup.sh                      # setup wifi that we will siphon off of
./execute_when_internet_detected.sh # makes sure we have internet after switch

# this helps to make sure the wifi starts correctly
./stop_wifi.sh                      # stops the wireless access point
./start_wifi.sh                     # starts the wireless access point
./stop_wifi.sh                      # stops the wireless access point
./start_wifi.sh                     # starts the wireless access point

sleep 30s                           # stays on for this amount of time

sudo cp default_wpa.conf /etc/wpa_supplicant/wpa_supplicant.conf

./stop_wifi.sh                      # stops the wireless access point

sleep 30s                           # stays on for this amount of time

sudo shutdown                       # reboot
