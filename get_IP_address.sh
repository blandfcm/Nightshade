#!/bin/bash

ifconfig | grep "inet addr:" > ip.txt

cat ip.txt | mailx -r connorblandford@gmail.com -s "PI IP" connorblandford@gmail.com



