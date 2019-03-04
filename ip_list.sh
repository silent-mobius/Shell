#!/usr/bin/env bash

########################################################################
#created by	: br0k3ngl255
#purpose	: print table of network interfaces with ip and mac addrs
#date		: 27.02.2019
#version	: 0.2.19
########################################################################
# task ahead:
	#create a script that will print all the interfaces, with their IP 
	#MAC addresses in a pretty table.

###variables ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
#messages
msg_parameter_missing=" you have not provided one of the paramenters :"
msg_unvalid_user="You are not allowed to recieve this type of information"
msg_file_missing="you are missing bin file--> please install ifconfig"
#misc
line="================================================================="

#files


#folders


#combo


#arrays

###Functions /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\

check_bin(){
	if [ -e $(which ifconfig) ];then
		true
	else
		printf "%s " $msg_file_missing
		exit 1
	fi
	}
	
table_print(){

	local format=" %-16s %-16s %12s \n"
	
	INETS=$(ifconfig -a|grep flags|awk '{print $1}'|sed 's/\:/ /')

	
	printf "%s\n" "$line"
		printf "$format"  "INET" "IP" "MAC"
	printf "%s\n" "$line"
	
	for inet in  $INETS
		do
			IP=$(ifconfig $inet|grep -v  inet6| egrep 'inet'|awk '{print $2}')
			MAC=$(ifconfig $inet|grep -v  inet6| egrep 'ether'|awk '{print $2}')
			if [[ $IP == "" ]];then
				IP="#### NONE ####"
			fi
			if [[ $MAC == "" ]];then
				MAC="#### NONE ####"
			fi
			
			printf "$format" "$inet" "$IP" "$MAC"
				
		done
	printf "%s\n" "$line"
	}
####
#Main - _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _
####
valid_user=$(cat /etc/passwd|grep $UID &> /dev/null;echo $?)

if [ $valid_user != 0 ];then
	echo $msg_unvalid_user
	exit 1
else	
	check_bin
		table_print
fi
