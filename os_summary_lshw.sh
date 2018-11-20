#!/usr/bin/env bash

##################################################################
#created by     : br0k3ngl255
#date 			: 22.10.2018
#purpose		: get constructed data from Linux/Unix systems and 
#					write them either stdout or to csv file.
#ver			: 0.2.15
##################################################################
##################################################################
#ToDo:
#	* orginze and filter data geberated by "lshw"
#	* need to manage data as associative array
#	* create a function to write data as csv file.
#	* create a function to formate data as database format
##################################################################
clear
#variables +++++++++++++++++++++++++++++++++++++++++++++++++++++++

line="============================================================"
DATA='data_file.csv'
DATA_FOLDER=$(pwd)
Data="$DATA_FOLDER/$DATA"
output_var="" # it can be : -json, -html,-xml

#messages
error_msg="Something went wrong - try running in debug mode"
note_msg="Notification "
start_msg="Start OF Script"
end_msg="End Of Script"
hw_msg="List Of HardWare"
sys_msg="List Of System Parameters"
users_msg="List Of System Users"
service_msg="List Of Services"
app_msg="List Of Installed Apps"
net_msg="List Of Interfaces With Attributes"
stor_msg="List Of Mount Points"
mod_msg="List of Kernel Modules"
permission_msg="Please Get Root Access"

###########################################################
: '
declare -n bridge_arr
declare -n bus_arr
declare -n communication_arr
declare -n display_arr
declare -n generic_arr
declare -n memory_arr
declare -n network_arr
declare -n processor_arr
declare -n storage_arr
declare -n system_arr
declare -n volume_arr
'
###########################################################

#System variables
md_version=$(env|grep MD_Ver|awk -F= '{print $2}')
md_product=$(env|grep MD_Prod|awk -F= '{print $2}')
os=$(cat /etc/*-release|grep ID|awk -F= '{print $2}'|head -n1|sed 's/"//g')
local_users_arr=$(while IFS= read -r i;do echo $i|awk -F : '{print $1}'; done < /etc/passwd )
host_name_arr=($(hostnamectl status))
net_addr_arr=($(ip addr show | grep inet|grep -v inet6|grep -v "127.0.0.1"))

#installedApplications - here is  what's problmatic here

if [ $os == "centos" ] || [ $os == "redhat" ] || [ $os == "fedora" ];then
	installed_App_arr=$(rpm -qa |awk -F. '{print $1}'|uniq|sort)
else
		true
fi

if [ $os == "debian" ] || [ $os == "ubuntu" ];then
	installed_apps_arr=$(dpkg -l|awk -F. '{print $1}'|uniq|sort)
else
		true
fi


#Functios /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/

hw_ls(){

if  $(which lshw) ;then
	true
else
	printf "%s " "need to install lshw"
fi

}

filter_func(){
	#declare -n
	 arr=$1
    for key in "${!arr[@]}"; do
       printf "%s\t%s" "$key ${arr[$key]}"
    done
	}

###
#Main - _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _
###

if [ $EUID != "0" ];then

	printf "%s \n"  $permission_msg
	exit 1

else
	while getopts ":dhjx" opt
		do
			case ${opt} in
					d) set -xe            ;;
					h) output_var="-html" ;;
					j) output_var="-json" ;;
					x) output_var="-xml"  ;;
			esac
		done

#HW list:
printf "%-20s" "$note_msg : Scanning the System"

bridge_arr=($(lshw -class bridge -quiet $output_var))
bus_arr=($(lshw -class bus -quiet $output_var))
communication_arr=($(lshw -class communication -quiet $output_var))
display_arr=($(lshw -class display -quiet $output_var))
generic_arr=($(lshw -class generic -quiet $output_var))
memory_arr=($(lshw -class memory -quiet $output_var))
network_arr=($(lshw -class network -quiet $output_var))
processor_arr=($(lshw -class processor -quiet $output_var))
storage_arr=($(lshw -class storage -quiet $output_var))
system_arr=($(lshw -class system -quiet $output_var))
volume_arr=$(lshw -class volume -quiet $output_var)

: '
printf "%s" "${bridge_arr[@]}"
printf "\n%s" "${bus_arr[@]}"
printf "\n%s" "${communication_arr[@]}"
printf "\n%s" "${display_arr[@]}"
printf "\n%s" "${generic_arr[@]}"
printf "\n%s" "${memory_arr[@]}"
printf "\n%s" "${network_arr[@]}"
printf "\n%s" "${processor_arr[@]}"
printf "\n%s" "${storage_arr[@]}"
printf "\n%s" "${system_arr[@]}"
printf "${volume_arr[@]}"
'
filter_func volume_arr

fi
