#!/usr/bin/env bash

###################################################################3
#created by: br0k3ngl255
#date: unknow
#version: 0.0.1
#purpose: script that shall destroy system so that the pupil could practice debug skills
####################################################################3
#
#!!!   This piece of software is created and posted with GPLv2 lisence    !!!
#!!!   Please go over the lisence before you'll  start using the software !!!
#
####################################################################3
#set -xe # debug





#Vars ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

##command vars
os_check=$()


##msg vars
permission_msg="Please Get Root Permissions"
note_msg="Notification"




#Funcs /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/








#####
#Main
#####

if [[ $EUID != 0 ]];then

	printf "%s \n" $permission_msg

else




fi