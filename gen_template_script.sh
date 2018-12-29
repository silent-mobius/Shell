#!/usr/bin/env bash

##############################################################################
# created by : br0k3ngl255
# purpose	 : create template generation that will read variables
# from stdin and will generate script 
# date		 : 25/12/2018
# version	 : 0.0.1
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
shabang="/usr/bin/env"
script_name="template_script"
extension="sh"
comment="#"
Date="Date: $(date +%d/%m/%y)"
Ver="Version: 0.0.0"
Purp="Purpose: "
Auth="Create by : "
##Funcs /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/

####
#Main - _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _
####

printf "%s \n" $line
printf "%s \n" $msg_start
printf "%s \n" $line

	sleep $Time

printf "%s \n" $msg_create
printf "%s \n" $shabang > "$script_name\.$extension"
printf "%s \n" $line >> "$script_name\.$extension"
printf "%s \n" "$comment $Date" >> "$script_name\.$extension"
printf "%s \n" "$comment $Purp" >> "$script_name\.$extension"
printf "%s \n" "$comment $Ver" >> "$script_name\.$extension"
printf "%s \n" "$comment $Auth" >> "$script_name\.$extension"
printf "%s \n" $line >> "$script_name\.$extension"

	sleep $Time

printf "%s \n" $line
printf "%s \n" $msg_end
printf "%s \n" $line
