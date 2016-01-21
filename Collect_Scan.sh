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
	from scapy import *
	
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
		
