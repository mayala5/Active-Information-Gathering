#!/bin/bash

# Author: Matias Ayala
# Date Created: 27 Feb 2023
# Last Modified: 27 Feb 2023

# Description:
# This script automates some Active Information processes and compiles the data into files. 

# Usage:
# The client will be prompted for an IP address for the tools to run against. This IP address is
# saved to a variable and this variable is used in commands. Recommend running wireshark at the same time for
# deeper insight into network traffic between host and target. 

# Prompts the client to enter the IP address and saves it into a variable called target
read -p "Please enter the IP address you would like to develop an active info report for: " target 

echo "The IP address entered was $target"

sleep 1s
echo " "

echo "Starting to run Active Info gathering tools on $target"

# create a variable with timestamp for report
report="$(date +%d-%m-%Y_%H-%M-%S)"

echo "Nmap scan for service version"

echo "Nmap Service version $target" >> activeInfo_report_$report.txt

# Run Nmap -sV and append results to report
sudo nmap -sV $target >> activeInfo_report_$report.txt

echo " "

echo "service version complete"

echo "-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --" >> activeInfo_report_$report.txt
echo "Badsum $target" >> activeInfo_report_$report.txt

echo " "

echo "Running Nmap Badsum"

# Run option badsum and append to report
sudo nmap -badsum ${target} >> activeInfo_report_$report.txt

echo " "

echo "badsum scan completed"

echo "-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --" >> activeInfo_report_$report.txt
echo "Nmap Packet fragmentation" >> activeInfo_report_$report.txt

echo " "

echo "Running packet Fragmentation with random IP address"

# Run packet fragmentation command in Nmap
sudo nmap -sS -sV -F -D RND:1 ${target} >> activeInfo_report_$report.txt

echo " "

echo "Packet fragmentation complete"

echo "-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --" >> activeInfo_report_$report.txt
echo "Packet Fragmentation MTU 16 bytes" >> activeInfo_report_$report.txt

echo " "

echo "Running Packet Fragmentation MTU 16 bytes"
echo " "

# running Packet Fragmentation MTU 16 bytes and append to report
sudo nmap -sS -sV -F -f --mtu 16 --send-eth -D RND:1 ${target} >> activeInfo_report_$report.txt

echo " "

echo "Packet Fragmentation with MTU 16 bytes complete"

echo "-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --" >> activeInfo_report_$report.txt
echo "Packet Fragmentation MTU 24 bytes" >> activeInfo_report_$report.txt

echo " "

echo "Running Packet Fragmentation MTU 24 bytes"
echo " "

# running Packet Fragmentation MTU 24 bytes and append to report
sudo nmap -sS -sV -F -f --mtu 24 --send-eth -D RND:1 ${target} >> activeInfo_report_$report.txt

echo " "

echo "Packet Fragmentation with MTU 32 bytes complete"

echo "-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --" >> activeInfo_report_$report.txt
echo "Packet Fragmentation MTU 32 bytes" >> activeInfo_report_$report.txt

echo " "

echo "Running Packet Fragmentation MTU 32 bytes"
echo " "

# running Packet Fragmentation MTU 32 bytes and append to report
sudo nmap -sS -sV -F -f --mtu 32 --send-eth -D RND:1 ${target} >> activeInfo_report_$report.txt

echo " "

echo "Packet Fragmentation with MTU 24 bytes complete"

sleep 1s
echo " "

echo "Finalizing report"

echo "-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --" >> activeInfo_report_$report.txt

echo "END REPORT" >> activeInfo_report_$report.txt

echo "-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --" >> activeInfo_report_$report.txt

# Wait 5 seconds
sleep 5s

echo "Active Information Gathering report saved in this $PWD to filename activeInfo_${report}.txt"


