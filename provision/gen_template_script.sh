#!/usr/bin/env bash

##############################################################################
# created by : br0k3ngl255
# purpose	 : create template generation that will read variables
# from stdin and will generate script 
# date		 : 25/12/2018
# version	 : 0.2.11
##############################################################################

##Vars :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
#msg vars 
msg_start="starting to generate the template"
msg_error="ERROR !!! stopped generating the template"
msg_end="finished generating the template"
msg_create="creating the template script"
#misc vars
line="########################################################################"

#conf vars
Time=1
shabang="#!/usr/bin/env"
ENV=$2
script_name=$1
extension=$3
comment="#"
debug="set -xe"
Date="Date: $(date +%d/%m/%y)"
Ver="Version: 0.0.0"
Purp="Purpose: "
Auth="Create by : "
##Funcs /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/

####
#Main - _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _
####

if [ "$script_name" == "" ];then
	read -p "What shall we call the script? ==>>  " script_name
fi

if [ "$ENV" == "" ];then
	echo "assuming bash type script"
	ENV="bash"
	sleep $Time
fi

if [ "$extension" == "" ];then
	echo "assuming .sh extension"
	extension="sh"
	sleep $Time
fi

echo $line
echo $msg_start
echo $line

	sleep $Time

echo $msg_create
echo ""
printf "%s \n" "$shabang $ENV" > "$script_name.$extension"
printf "%s \n" "$debug" >> "$script_name.$extension"
printf "%s \n" $line >> "$script_name.$extension"
printf "%s \n" "$comment $Auth" >> "$script_name.$extension"
printf "%s \n" "$comment $Purp" >> "$script_name.$extension"
printf "%s \n" "$comment $Date" >> "$script_name.$extension"
printf "%s \n" "$comment $Ver" >> "$script_name.$extension"
printf "%s \n" $line >> "$script_name.$extension"
printf "%s \n"
	sleep $Time

echo $line
echo $msg_end
echo $line
