#!/usr/bin/env bash
#set -x
#################################################3333
# Created by : Pushtakio
# Purpose: just to run some shit in parallel
# Date: 06/11/2019
# Version: 1.0.0
#################################################3333

### Variables :::::::::::::::::::::::::::::::::::::::
parallel_processes=$1
process_num=0
random_seconds=$(( ($RANDOM % 20) + 1 ))
success=0
fail=0
### Funcs ::::::::::::::::::::::::::::::::::::::::::::::

valid_parallel_process(){
    if [ -z $parallel_processes ];then
        read -p "Please enter amount parallel processes:" parallel_processes
    fi
}

valid_parallel_script_run(){
    cmd=$(ps aux|grep -v grep|grep $0 > /dev/null;echo $?)
    if [ $cmd == 0 ];then
        echo "the script is already running"
        sleep $random_seconds
        exit 1
        clear
    fi
}


parallel_process_run_time(){
    sleep $random_seconds
    echo "$(date)  $!"
}

summary(){
var1=$1
var2=$2
echo "success: " $var1
echo "fail: "    $var2
}
####
# Main - _ -
####
if [ $EUID == 0 ];then  
    echo "Please do not use user ROOT"
    exit 1
else
    #valid_parallel_script_run
    valid_parallel_process
    while [ $process_num -lt $parallel_processes ];
        do  
            parallel_process_run_time &
            if [ $? == 0 ];then
                let success++
            else 
                let fail++
            fi
            let process_num++
        done
    wait
    summary $success $fail
fi
