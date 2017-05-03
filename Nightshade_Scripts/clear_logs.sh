#!/bin/bash

sudo cp /var/log/dnsmasq.log dnsmasq_log_backup.log
sudo echo "Cleared on: " > /var/log/dnsmasq.log
sudo date >> /var/log/dnsmasq.log 

