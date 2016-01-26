#!/usr/bin/env bash
#set -x 
#############################################################################
#Purpose: 
#       Adjust script running to the scan
#created by : br0k3ngl255
##############################################################################
#Copyright (c) <2014-2016>, <LinuxSystems LTD>
#All rights reserved.
#Redistribution and use in source and binary forms, with or without
#modification, are permitted provided that the following conditions are met:
#    * Redistributions of source code must retain the above copyright
#      notice, this list of conditions and the following disclaimer.
#    * Redistributions in binary form must reproduce the above copyright
#      notice, this list of conditions and the following disclaimer in the
#      documentation and/or other materials provided with the distribution.
#    * Neither the name of the <LinuxSystems LTD> nor the
#      names of its contributors may be used to endorse or promote products
#      derived from this software without specific prior written permission.
#
#THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
#ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
#WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
#DISCLAIMED. IN NO EVENT SHALL <COPYRIGHT HOLDER> BE LIABLE FOR ANY
#DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
#(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
#LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
#ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
#(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
#SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
########################################################################
: '
DISCLAIMER :  use this at your own risk
'
##Vars_ - _ - _ - _ - _ -_- _ - _ - _ - _ - _ - _ - _ - _ - _ - _ - _ - _ - _ - _ -
logFile="scan.txt"
folder="/tmp"
os_type=$(lsb_release -si)
install_mngr=""
##funcs+ + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + +

help(){ #how to use this is script
	echo "wrong use"		
	echo "use -i for interface"
	echo "use -p for IP"
	echo "use -f for save folder (/tmp is default)"
	echo "all options must be satisfied"
	}

get_os_details(){
	if [ $os_type == 'Debian' ] || [ $os_type == 'Ubuntu'] || [ $os_type == 'Mint' ];then
		install_mngr='apt-get'
	elif [ $os_type == 'Redhat' ] ||[ $os_type == 'Centos' ] || [ $os_type == 'Fedora' ];then
		install_mngr='yum'
	else
		echo "not supported"
			exit 1
	fi
	
	}

verify_tools(){ # verify all the tools needed for this script to work
		if [ ! $(which nbtscan) ];then
			$install_mngr install nbtscan -y
		fi
		if [ ! $(which xprobe2) ];then
			$install_mngr install xprobe2 -y
		fi
		if [ ! $(which nmap) ];then
			$install_mngr install nmap -y
		fi
		if [ ! $(which scapy) ];then
			$install_mngr install scapy -y
		fi
	}
	
osCheck(){ #checking on OS type
	
xprobe2  $ip |grep "Running OS"|head -1|awk {'print  "OS[" $6 $7 "\t" $8"]"'} >> $folder/$logFile &

}

nameCheck(){ #checking if the target/client has a name
	
nbtscan -r $ip|tail -1|awk {'print "PC_name[" $2 "]" '} >> $folder/$logFile &

}

backupPlan(){ #just in case one of the function won't work
	
    nmap -O $ip|grep MAC|awk {'print "Manufactorer ["$4 "\t" $5 "\t" $6"]"'} >> $folder/$logFile &

}

cleanStat(){ # used to clean  temp file use for reading data about users
    echo " " > $folder/$logFile
}

portKnock(){ #embedded script - does not works well - need to re-embedd it somehow
	PSS=$1
	python  $PSS << EOF
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

if  [ $"EUID" != "0" ];then
	echo "get root"
	exit
else
	get_os_details
	verify_tools

		if [ ! -e /tmp/scan.txt ];then
			touch /tmp/scan.txt
		else 
			cleanStat
		fi

	nameCheck
	osCheck; #backupPlan
	portKnock $(cat /tmp/scan.txt)
fi
