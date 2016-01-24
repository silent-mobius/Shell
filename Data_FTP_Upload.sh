#!/usr/bin/env bash
#set -x 
##############################################################################
#Purpose: 
#Ftp upload automation for cron schedular. 
#Created by br0k3ngl255
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
##Vars _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _  
logFolder='/var/log/'
DATE=`date +%Y-%m-%d`
##Funcs  + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + +

usage(){
	echo "Wrong use"
	echo ": "
	echo "uploadViaFTP.sh -I MyFTPServer.com -F destination server -U FTPuser -P FTPpassword"
	}
	
gatherLogs(){ #gather all the needed files in to array send them 
		log_arr[0]=/var/log/alternatives.log
		log_arr[1]=/var/log/mysql.err
		log_arr[2]=/var/log/dmesg
		log_arr[3]=/var/log/auth.log
		#lod_arr[4]=/PATH/TO/FOLDER/OR/FILE/
			for i in $log_arr  #compress all the files
				do
					echo ${log_arr} >> logs_arr_list$$
				done
					tar cfz   SystemLog_$DATE.tar.gz  "${log_arr[@]}"
					mv SystemLog_$DATE.tar.gz /tmp
					rm logs_arr_list$$
	}
###
#Main _ - _ - _ - _ - _ - _ - _ - _ - _ - _ - _ - _ - _ - _ - _ - _ - _ 
###

while getopts "I:F:U:P:h:H" OPTIONS; do
   case ${OPTIONS} in
      I ) ip=$OPTARG;;
      F ) folder=$OPTARG;;
      U ) user=$OPTARG;;
      P ) password=$OPTARG ;;
      h|H) usage;;
      * ) usage;;   # Default
   esac
done

if [[ -z $ip ]] || [[ -z $user ]] || [[ -z $passwd ]];then
	usage
	exit
fi 
gatherLogs

ftp -in <<EOF
open $ip
user $user $password
cd /home/$user
lcd /tmp
put SystemLog_$DATE.tar.gz
close 
bye
EOF
