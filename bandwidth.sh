#!/bin/bash
iface=eth2
sfile=/var/log/sysstat/sa19

echo -e "\nMarch 19th"
echo -e "\nStats for $iface" 
ethtool $iface | egrep 'Speed|Duplex|Link' && echo -e "\n" 
ip a | grep inet | grep $iface | awk '{print $2}'
echo -e "\n"; ip -s link | grep -A5 $iface 
date 
sar -n DEV -f $sfile | egrep $iface | awk 'BEGIN {print "\nInbound kb/s + Outbound kb/s = Total Traffic\n"} {print $1, " --- ", $6, "+", $7, "=", (($6+$7)*1024)/2^30"Gb/s"}' | grep -v Average
echo -e "\nError Statistics"
ethtool -S $iface | egrep 'err|miss|drop'
