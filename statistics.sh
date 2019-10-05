#!/usr/bin/env bash
 #set -xe
###############################################################################
#created by: pushtakio
#purpose: provide stats for CPU,MEM,STRGE
#date: 11/09/2019
#ver: 1.1.18
###############################################################################
#
####Variables   :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
#msgs:
msg_root="Please run script as root"
_time=5
_date=$(date +%H:%M:%S_%d/%m/%Y)
_end=$((SECONDS+360))
_cpu=$(top -bn1 | grep load | awk '{printf "%.2f%%\t\t\n", $(NF-2)}')
_mem=$(free -m | awk 'NR==2{printf "%.2f%%\t\t", $3*100/$2 }')
_disk=$(df -h | awk '$NF=="/"{printf "%s\t\t", $5}')
log_folder="/var/log/stats"

####Functions    /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/

deco(){
  printf "{%s:%s,%s:%s,%s:%s}\n" "$@"
}

test_log_folder(){
  if [[ -d $log_folder ]];then
    true
  else
    sudo mkdir -p $log_folder
fi
}

#####
#Main - _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _
#####

if [[ $EUID != 0 ]];then
  deco $msg_root
else
 test_log_folder
while [[ $SECONDS < $_end ]]
  do
    deco cpu $_cpu mem $_mem  hdd $_disk #>> $log_folder/stats.log
    sleep $_time
  done
fi
