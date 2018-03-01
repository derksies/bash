#!/bin/bash
#Script for renaming hostname and editing static IP on new sever

#Assign existing hostname to $hostn
hostn=$(cat /etc/hostname)

#Ask user for new IP address $ipaddr
echo "Enter new IP address:"
read ipaddr	

#Ask user for new hostname $newhost
echo "Enter new hostname: "
read newhost

#Change hostname in /etc/hostsname
sudo sed -i "s/$hostn/$newhost/g" /etc/hostname
sudo sed -i "s/$hostn/$newhost/g" /etc/hosts
sudo sed -i "s/192.168.7.13/$ipaddr/g" /etc/network/interfaces

#Display new hostname & IP
echo "Your new hostname is $newhost"
echo "Your new IP is $ipaddr"

#Press any key to reboot
read -s -n 1 -p "Press any key to reboot"
sudo reboot