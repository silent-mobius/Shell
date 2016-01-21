#!/bin/bash
#set -x 
#############################################################################
#Purpose: 
#       Adjust script running to the scan
# Created by : br0k3ngl255
##############################################################################
##Vars_ - _ - _ - _ - _ -_- _ - _ - _ - _ - _ - _ - _ - _ - _ - _ - _ - _ - _ - _ -
logFile="scan.txt"
folder="/tmp"
##funcs+ + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + +
osCheck(){
xprobe2  $ip |grep "Running OS"|head -1|awk {'print  "OS[" $6 $7 "\t" $8"]"'} >> $folder/$logFile &
}
nameCheck(){
nbtscan -r $ip|tail -1|awk {'print "PC_name[" $2 "]" '} >> $folder/$logFile &
}

portScan(){
echo "IP[${ip}]" >> $folder/$logFile # what ip am I running on??
portScanner_byport.py $ip|grep Open  >> $folder/$logFile 2> /dev/null &
}
backupPlan(){
    nmap -O $ip|grep MAC|awk {'print "Manufactorer ["$4 "\t" $5 "\t" $6"]"'} >> $folder/$logFile &
}
cleanStat(){
    echo " " > $folder/$logFile
}

##Actions ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

while getopts "i:f:p:" OPTIONS;do
     case ${OPTIONS} in
          i ) interface=$OPTARG;;
          f ) folder=$OPTARG;;
          p ) ip=$OPTARG;;
          * ) echo "Unknown option";;
     esac
done

if [ ! -e /tmp/scan.txt ];then
touch /tmp/scan.txt
else 
	cleanStat
fi

nameCheck
	osCheck;backupPlan
		portScan
