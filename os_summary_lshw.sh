#!/usr/bin/env bash

##################################################################
#created by     : br0k3ngl255
#date 		: 22.10.2018
#purpose	: get constructed data from Linux/Unix systems and write them either stdout or to csv file.
#ver		: 1.4.32
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



#System variables
MD_version=$(env|grep MD_Ver|awk -F= '{print $2}')
MD_product=$(env|grep MD_Prod|awk -F= '{print $2}')
OS=$(cat /etc/*-release|grep ID|awk -F= '{print $2}'|head -n1|sed 's/"//g')
HostName_arr=($(hostnamectl status))

#installedApplications - here is  what's problmatic here

if [ $OS == "centos" ] || [ $OS == "redhat" ] || [ $OS == "fedora" ];then
	installedAppArray=$(rpm -qa |awk -F. '{print $1}'|uniq|sort)
else
		true
fi

if [ $OS == "debian" ] || [ $OS == "ubuntu" ];then
	installedAppsArray=$(dpkg -l|awk -F. '{print $1}'|uniq|sort)
else
		true
fi


#Functios /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/

hw_ls(){

if  $(which lshw);then
	printf "%s " $cpu_info
else
	printf "%s " "need to install lshw"

fi
}


LocalUsers(){
usersdb="/etc/passwd"
while IFS=: read -r i

do
cmd=$(echo $i|awk -F : '{print $3}')

	if [ $cmd -ge 1000 -a $cmd -le 2000 ];then
		LocalUsersArray+=($i)
	fi
done <"$usersdb"

}

hw_ls(){

if  $(which lshw) ;then
	true
else
	printf "%s " "need to install lshw"
fi

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
generic_arr=($(lshw -class generic -quiet$output_var))
memory_arr=($(lshw -class memory -quiet$output_var))
network_arr=($(lshw -class network -quiet $output_var))
processor_arr=($(lshw -class processor -quiet $output_var))
storage_arr=($(lshw -class storage -quiet $output_var))
system_arr=($(lshw -class system -quiet $output_var))
volume_arr=($(lshw -class volume -quiet$output_var))

printf "%s: %s\n" "${bridge_arr[@]}"
printf "%s: %s\n" "${bus_arr[@]}"
printf "%s: %s\n" "${communication_arr[@]}"
printf "%s: %s\n" "${display_arr[@]}"
printf "%s: %s\n" "${generic_arr[@]}"
printf "%s: %s\n" "${memory_arr[@]}"
printf "%s: %s\n" "${network_arr[@]}"
printf "%s: %s\n" "${processor_arr[@]}"
printf "%s: %s\n" "${storage_arr[@]}"
printf "%s: %s\n" "${system_arr[@]}"
printf "%s: %s\n" "${volume_arr[@]}"


fi