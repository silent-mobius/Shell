#!/usr/bin/env bash

###################################################################3
#created by: br0k3ngl255
#date: unknow
#version: 0.0.1
#
####################################################################3
#set -xe # debug

#vars :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

agree="Do you agree with terms?"
agree_ans="n"
comm_msg="GREAT - Remember to try your best to research everything"
exit_msg="Ok got it  - youre a Chiken, good luck with MCSA exams"
grub_config="/etc/default/grub"
grub_bin_config="/boot/grub2/grub.cfg"
line="==============================================================="
NULL="/dev/null"
warn_msg="This script will destroy your OS - Its your job to fix it ! ! !"

#Funcs /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/

help(){
printf "%s\n" "$line"
printf "%s\n" "Usage: break_os.sh -b -i -a -p"
printf "%s\n" "$line"
}

last_warning(){ #should run in case user does not undestands what is ahead of him
printf "%s\n" "$line"
for warn in ${warn_msg[@]}
	do
		printf "%s " "${warn}";sleep 0.5
	done

printf "\n%s\n" "$line"

for a in ${agree[@]}
	do
		printf "%s " "${a}";sleep 0.5
	done
read -p "(y/N)" agree_ans

if [[ $agree_ans == "n" ]] || [[ $agree_ans == "N" ]] || [[ $agree_ans == "" ]];then
	printf "%s\n" "$exit_msg";exit 1
fi

if [[ $agree_ans == "y" ]] || [[ $agree_ans == "Y" ]];then
	for com in ${comm_msg[@]}
		do
			printf "%s " "$com"
			sleep 0.5
		done
fi
printf "\n%s\n" "$line"

}

os_check(){
	_os_check=$(cat /etc/*-release|grep -E '^ID'|awk -F= '{print $2}')
	if  [ "$_os_check" == "fedora"] || [ "$_os_check" == "redhat"] || [ "$_os_check" == "centos"];then
		network_path="/etc/sysconfig/network-scripts"
	fi
	if  [ "$_os_check" == "debian"] || [ "$_os_check" == "ubuntu"];then
		network_path="/etc/network/interfaces"
	fi

}

#"Damage to be done" functions

break_grub(){
sed -i 's/GRUB_CMDLINE/#GRUB_CMDLINE/g' $grub_config
grub2-mkconfig -o $grub_bin_config &> $NULL

}

break_ls(){
mv /bin/ls /bin/ls_hidden
chmod -x /bin/ls_hidden
}

break_home_dir(){
user=$(cat /etc/passwd|grep 1000)
if [ ! -e /tmp/${user} ];then
	mkdir /tmp/${user}
fi
usermod -d /tmp/${user} ${user}
}


break_net(){
	printf "%s " "starting to break client network"
	tar cvzf "$network_path.tgz" $network_path &> $NULL
}

break_client_dns(){
num=1000000
while [[ $num >= 0 ]]
	do
		echo " nameserver 0.0.0.$num" >> /etc/resolv.conf
		num=$(($num-1));
	done

}
: '
break_client_dhcp(){


}

break_ssh(){


}

break_editor(){

}

break_repo(){

}

break_sudo(){


}

break_dhcp_srv(){

}

break_dns_srv(){

}

break_nfs(){


}

break_samba(){


}

break_iscsi(){

}

break_httpd(){

}

break_httpd_ssl(){

}

break_proxy(){

}

break_nginx(){

}

break_db(){
}

break_php(){

}

break_php_again(){

}

break_php_again_n_again(){

}
'
###Lab Level functions

begginer_lab(){
#ooh you are in for a surprise
#break_ls
#break_home_dir
true
}

intermediate_lab(){
true
}

advance_lab(){
true
}

pro_lab(){
true
}

###
#Main - _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _
###

if [ $EUID != "0" ];then
	printf "%s\n" "$line"
	printf "%s\n" "Please get a  Root Privileges"
	printf "%s\n" "$line"
else

while getopts ":bBiIaApP" opt
	do
		case $opt in
			a|A) clear ; echo "advance lab chosen"
					sleep 3
					echo "starting lab"
					last_warning
					sleep 3
					advance_lab
					;;
			b|B) clear ; echo "begginer lab chosen"
					sleep 3
					echo "starting lab"
					last_warning
					sleep 3
					begginer_lab
					;;
			i|I) clear ; echo "intermediate lab chosen"
					sleep 3
					echo "starting lab"
					last_warning
					sleep 3
					intermediate_lab
					;;
			p|P) clear ; echo "Pro lab chosen"
					sleep 3
					echo "starting lab"
					last_warning
					sleep 3
					advance_lab
					;;
			# *) help ;-$OPTARG" >&2 ;;
			\?) clear ; echo "Invalid Option:"
					help
					exit 1
					;;
		esac
	done

fi
