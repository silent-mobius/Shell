#!/usr/bin/env bash

#####################################################################################
#created by: smobius
#purpose : genersal script for installing k8s
#date	: 07.05.2019
#version: 1.0.0
#####################################################################################

###Vars ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
TRUE=0
FALSE=1
Time=1

#messages
msg_error="Something went wrong - try running in debug mode"
msg_note="Notification "
msg_start="Start OF Script"
msg_end="End Of Script"
msg_permission="Please Get Root Access"
msg_unsupported="This OS is NOT supported"
msg_start_install="starting installing packages and group packages"
msg_add_repo="adding repo"
msg_installer_set="finished setting up installer"
#misc
line="#############################################################################"


###Funcs /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/

deco(){
	clear
	pre="###############################################################"
	post="###############################################################"
	printf "$pre\n%s\n$post\n" "$*"
	}





####
#Main -  _-  _-  _-  _-  _-  _-  _-  _-  _-  _-  _-  _-  _-  _-  _-  _-  _-  _-  _-  _
####

if [[ "$EUID" != "0" ]];then
	
	deco $msg_permission
	sleep $Time
	exit $FALSE;
	
else
	true
fi
