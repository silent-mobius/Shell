#!/bin/bash
#set -x 
#############################################################################
#Purpose: 
#       Adjust script running to the scan
#created by : nr0k3ngl255
##############################################################################
##Vars_ - _ - _ - _ - _ -_- _ - _ - _ - _ - _ - _ - _ - _ - _ - _ - _ - _ - _ - _ -
logFile="scan.txt"
folder="/tmp"
##funcs+ + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + +
verify_tools(){
	check_tool=$(ls /usr/bin|grep $t > /dev/null ;echo $?)
	tools=('nmap' 'xprobe2' 'nbtscan')
	for t in $tools;do
		if [ check_tool == "0" ];then
			True
		else
			echo "Please install $t"
		fi
				done
	}
osCheck(){
xprobe2  $ip |grep "Running OS"|head -1|awk {'print  "OS[" $6 $7 "\t" $8"]"'} >> $folder/$logFile &
}
nameCheck(){
nbtscan -r $ip|tail -1|awk {'print "PC_name[" $2 "]" '} >> $folder/$logFile &
}

backupPlan(){
    nmap -O $ip|grep MAC|awk {'print "Manufactorer ["$4 "\t" $5 "\t" $6"]"'} >> $folder/$logFile &
}
cleanStat(){
    echo " " > $folder/$logFile
}
portKnock(){
	python << EOF
import sys
import logging
logging.getLogger("scapy.runtime").setLevel(logging.ERROR)
from scapy.all import *
 
dst_ip = sys.argv[0]
src_port = RandShort()
#dst_port=80
dst_port=[1,20,21,22,23,25,37,42,53,57,67,68,80,81,82,88,111,113,118,119,135,137,138,139,143,161,162,280,311,443,445,465,530,543,544,546,547,631,636,646,660,666,691,750,751,752,753,754,760,808,843,860,989,990,992,993,1010,3306,8080,1194,5000,12975,17500]
 
for i in dst_port:
     stealth_scan_resp = sr1(IP(dst=dst_ip)/TCP(sport=src_port,dport=dst_port,flags="S"),timeout=10)
     if(str(type(stealth_scan_resp))=="<type 'NoneType'>"):
          print "Filtered"
     elif(stealth_scan_resp.haslayer(TCP)):
          if(stealth_scan_resp.getlayer(TCP).flags == 0x12):send_rst = sr(IP(dst=dst_ip)/TCP(sport=src_port,dport=dst_port,flags="R"),timeout=10)
          print "Open"
     else:
           pass
EOF
	}
##Actions ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

while getopts "i:f:p:" OPTIONS;do #use these paramaeters to tun the script
     case ${OPTIONS} in
          i ) interface=$OPTARG;;
          f ) folder=$OPTARG;;
          p ) ip=$OPTARG;;
          * ) echo "Unknown option";;
     esac
done


verify_tools

if [ ! -e /tmp/scan.txt ];then
touch /tmp/scan.txt
else 
	cleanStat
fi


nameCheck
	osCheck;backupPlan
	portKnock
		
