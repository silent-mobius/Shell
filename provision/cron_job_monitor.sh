#!/usr/bin/env bash

########################################################################
#created by : br0k3ngl355
#purpose: monitor a service/system task via cron job
#
#
########################################################################


#Vars ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
cron_time_stamp=5
logfile=cron_job_mon.log
logfolder=/var/log/cron_mon
logFile=$logfolder/$logfile
alert_color='\033[0;31m'
suggest_color='\033[1;36m'
NC='\033[0m' # No Color

#Funcs /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
usage(){
	printf "${alert_color} Incorrect use${NC}\n"
	cron_job_monitor -j JOB/SERVICE -t TIMESTAMP
	}


help(){
	printf "${suggest_color} Incorrect use${NC}\n"
	printf "${suggest_color}cron_job_monitor -j JOB/SERVICE -t TIMESTAMP ${NC}\n"
	printf ""
	
	}
	
log_check(){
	if [ ! -e $logfolder ];then
		echo 'creating log folder'
			mkdir -p $logfolder
			
			if [ "$?" == "0" ];then
				true;
			else
				echo "something went wrong --> check permissions"
				exit 1
			fi
				
	fi
	
	if [ ! -e $logfile ]
		echo 'creating log file'
			touch $logfolder/$logfile
			
			if [ "$?" == "0" ];then
				true;
			else
				echo "something went wrong --> check permissions"
				exit 1
			fi
	if [ -e $logFile ];then
		echo 'log file exists'
		true;
	else
		echo "something went wrong --> check permissions"
			exit 1
		
	fi
	}

cron_time_setup(){ #Need to config function for time management to cron
	 Time=$1
	 if [ $Time == "" ];then
		usage
		exit 1
	else
			
	 fi
	}

cron_job_setup(){ #Need to config function for job management to cron
	 Job=$1
		 if [ $Job == "" ];then
		usage
		exit 1
	else
			
	 fi
	}
	
	
###
#Main - _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _
###

if [ $EUID != "0" ];then
	echo "Invalid User -- Please get Root Privileges"
else
	while getopts ":j:J:t:T:h:H" opt;
		do
			case ${opt} in
			
				j|J) cron_job_setup  $OPTARG
					;;
				t|T) cron_time_setup $OPTARG
					;;
				h|H) help 
					;;
				*) printf "${alert_color} Invalid Option ${NC}\n" ;
						usage;
							help;
					;;
			
			esac
		done
			
