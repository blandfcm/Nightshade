#!/bin/bash

./wpa_setup.sh                      # setup wifi that we will siphon off of
./execute_when_internet_detected.sh # makes sure we have internet after switch

# this helps to make sure the wifi starts correctly
./stop_wifi.sh
./start_wifi.sh                     # starts the wireless access point

