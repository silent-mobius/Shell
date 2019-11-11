#!/usr/bin/env bash
#set -xe
##################################################################
# Created by: Pushtakio
# Purpose: get details of server and notify whe it is up.
# Date: 11/11/2019
# Version: 1.0.0
##################################################################

## Vars ::::::::::::::::::::::::::::::::::::::::::::::::::::::::

# messages:
msg_root="Please Do Not Use Root Priveleges"


# misc:
line="########################################################"

## Funcs /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/

deco(){

    printf "$line\n# %s\n$line\n" "$@"
    sleep 3
    clear
}

get_server_ip(){
   # currnt_ip_list=$(ip a s|grep -E 'inet|ether'|grep -v ff:|awk '{print $NF,$2}'
   current_ip=$(nmcli device status |grep connected|grep -E 'wifi|ethernet')
)
}

######
#Main -_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
######

if [[ $EUID == 0 ]];then
    deco $msg_root
    exit 1
else
    true

fi