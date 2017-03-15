#!/bin/bash
#Written by Connor Blandford

#makes sure file is in correct place for mailing system
sudo cp /etc/resolv.conf /var/spool/postfix/etc/

#prevents false positve from previous test 
rm internet_test.txt

connected=0

while [ $connected -eq 0 ] 
do
	ping 8.8.8.8 > internet_test.txt &

	#this is how many bits is sent by a ping, when returns that means ping is being returned
	key=64

	test="internet_test.txt"

	while IFS= read line
	do
		for word in $line
		do
			if [ $key = $word ]
			then
				echo Internet Detected

				connected=1
				
				#gets the IP Address for the Pi
				ifconfig | grep "inet addr:" > ip.txt

				#used to send email to myself when the internet is detected
				cat ip.txt | mailx -r connorblandford@gmail.com -s "PI IP" connorblandford@gmail.com
			
				#breaks out of if and the loops
				break 2 
			fi
		done
	done<"$test"

	#this block of code finds the ping process ID and then kills it
	ps | grep ping > ping.txt
	
	p="ping.txt"
	
	while IFS= read line
	do
		for word in $line
		do
			kill -9 $word
			break 2
	done
	done<"$p"
done


