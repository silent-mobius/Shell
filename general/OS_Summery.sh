#!/usr/bin/env bash

##################################################################
#created by     : br0k3ngl255
#date 		: 22.10.2018
#purpose	: get constructed data from Linux/Unix systems and write them either stdout or to csv file.
#ver		: 1.5.19
##################################################################


clear
#variables +++++++++++++++++++++++++++++++++++++++++++++++++++++++

line="============================================================"
DATA='data_file.csv'
DATA_FOLDER=$(pwd)
Data="$DATA_FOLDER/$DATA"


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

#system variables
md_version=$(env|grep MD_Ver|awk -F= '{print $2}')
md_product=$(env|grep MD_Prod|awk -F= '{print $2}')


os=$(cat /etc/*-release|grep ID|awk -F= '{print $2}'|head -n1|sed 's/"//g')
host_name=$(hostname)
local_users_arr=""
installed_app_arr=""

local_users=$(while IFS= read -r i;do echo $i|awk -F : '{print $1}'; done < /etc/passwd )
kernel_version=$(uname -r)
system_arch=$(uname -m)
net_addr_array=($(ip addr show | grep inet|grep -v inet6|grep -v "127.0.0.1"))
listed_services=$(systemctl list-unit-files|grep service|awk '{print $1,$2}')

#HW info:
ram=$(free -g|awk '{print $2}'|head -n2|tail -n1)
disk=$( df -hT|grep -v tmpfs|awk '{print $1,$2,$3,$7}')
cpu_info=$(lshw  -quiet -C cpu|grep -v capabilities)
driver_list=$(lsmod|awk '{print $1}')

#installedApplications - here is  what's problmatic here

if [ $os == "centos" ] || [ $os == "redhat" ] || [ $os == "fedora" ];then
	installed_apps_arr=$(rpm -qa |awk -F. '{print $1}'|uniq|sort)
else
		true
fi

if [ $os == "debian" ] || [ $os == "ubuntu" ];then
	installed_apps_arr=$(dpkg -l|awk -F. '{print $1}'|uniq|sort)
else
		true
fi



#Functions --------------------------------------------------------------------------------------------

usage(){
	note="To use script type : $0 -x -f -h -o"
	opt_msg=" -x : print the debug the output"
	opt_msg2=" -f : print the system details to screen" 
	opt_msg3=" -o : write system details to file.csv file "
	opt_msg4=" -h : help message "
	printf "%s " $note
	printf "\n$opt_msg" 
	printf "\n$opt_msg2"
	printf "\n$opt_msg3"
	printf "\n$opt_msg4\n"

}

Local_users(){
usersdb="/etc/passwd"
while IFS=: read -r i

do
cmd=$(echo $i|awk -F : '{print $3}')
		
	if [ $cmd -ge 1000 -a $cmd -le 2000 ];then 
		local_users_arr+=($i) 
	fi 
done <"$usersdb"

}

hw_ls(){

if  $(which lshw);then
	printf "%s " $cpu_info
else
	printf "%s " "need to install lshw"

fi
}


print_out_to_csv(){
	printf "%s\n"  $line
	printf "%s "  $sys_msg
	printf "\n%s \n" $line
	printf "System's MD Ver  : %s\n"       $md_version
	printf "System's MD prod : %s %s\n "   $md_product
	printf "System Arch      : %s  \n"  $SystemArch
	printf "System Memory    : %s Gb\n" $ram

	printf "%s\n"  $line
	printf "%s " $hw_msg
	printf "\n%s\n"  $line
	printf "System Path      : %s \n" $PATH
	printf "Operation System : %s \n" $os
	printf "Hostname         : %s \n" $host_name 
	printf "Kernal Version   : %s \n" $kernel_version
	
	printf "%s\n"  $line
	printf "%s "  $stor_msg
	printf "\n%s \n" $line
	printf "	  %s  %s  %s  %s \n" $disk
	
	printf "%s\n"  $line
	printf "%s "  $net_msg
	printf "\n%s \n"  $line
	for i in ${net_addr_array[@]}
		do
				if [ "$i" == "inet" ];then 
					printf "\n"
				fi;
			printf "%-15s" $i
		done
	
	printf "\n"
	
	
	printf "%s\n"  $line
	printf "%s "  $mod_msg
	printf "\n%s \n" $line
	printf "%s \n" $driver_list
	
	
	printf "%s\n"  $line
	printf "%s " $users_msg
	printf "\n%s \n" $line
	printf "System Users\n" 
	printf "  %s \n" $local_users
	
	printf "%s\n"  $line
	printf "%s " $service_msg
	printf "\n%s\t %s \n" $line
	printf "  %-50s         %-5s \n" $listed_services
	
	printf "%s\n"  $line
	printf "%s " $app_msg
	printf "\n%s \n" $line
	printf "List of Apps     :"
	printf "  %s \n" $installed_apps_arr	


}



Local_users


#######
#Main Logic - _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _
#######

if [ $EUID != "0" ];then 

	printf "%s \n"  $permission_msg
	exit 1

else
	while getopts ":xohf" opt
		do 
			case ${opt} in
					x) set -xe;;
					o) print_out_to_csv > file.csv;;
					f) print_out_to_csv ;;
					h) usage;;
					\?) echo "invalid option"; usage;;
			esac
		done


fi
