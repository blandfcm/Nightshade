# Nightshade
**Project name:** Nightshade

**Description:** This project idea is rooted in security. This project will be able to show people the simple and dangerous threat that is posed due to unsecure "free" wifi network. The project is an embedded system designed to fit inside a phone case that will allow a user to deploy a free wifi hotspot. This will then track all the data that is being routed through the device. 

**Author:** Connor Blandford  

**Installation:**

   * See Wiki for full tutorials on how to install everything below  
   * Make sure you have a Wifi USB adaptor that can connect to the internet.   
   * Install Postfix and Mailx to your device  
   * Enable SSH on your device 
   * Setup hostapd on your device 
   * Setup dnsmasq on your device 
   
**Usage:**

   * Edit the script "execute_when_internet_detected" to have your email address
   * Execute the  script "execute_when_internet_detected" in order to receive and email with your devices IP address
   
         bash ./execute_when_internet_detected
   
   * SSH into your Pi
   * Run the following commands:
   
         sudo service hostapd start  
         sudo service dnsmasq start
   
   * When satisified with its run time, stop it with:
   
         sudo service hostapd stop 
         sudo service dnsmasq stop 
         
   * Run the filter program on your log file
         
         TODO
   
**Resources:**

   * Heirloom Mailx:
      http://heirloom.sourceforge.net/mailx.html
      
   **Broadcasting Wifi Resource:**
      http://elinux.org/RPI-Wireless-Hotspot
      https://frillip.com/using-your-raspberry-pi-3-as-a-wifi-access-point-with-hostapd/
      https://seravo.fi/2014/create-wireless-access-point-hostapd
