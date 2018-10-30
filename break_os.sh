#!/usr/bin/env bash

###################################################################3
#created by: br0k3ngl255
#date: unknow
#version: 0.0.1
#
####################################################################3
#set -xe # debug

#vars :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
line="==============================================================="
warn_msg="This script will destroy your OS - Its your job to fix it!!!"
agree="Do you agree with terms?"
agree_ans="n"
exit_msg="Ok got it  - youre a Chiken, good luck with MCSA exams"
comm_msg="GREAT - Remember to try your best to research everything"

#Funcs /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/

help(){
printf "%s\n" "$line"
printf "%s\n" "Usage: break_os.sh -b -i -a -p"
printf "%s" "$line"
}

last_warning(){ #should run in case user does not undestands what is ahead of him
printf "%s\n" "$line"
for warn in ${warn_msg[@]}
	do
		printf "%s\t" "${warn}";sleep 0,5
	done

printf "%s\n" "$line"

for a in ${agree[@]}
	do
		printf "%s\t" "${a}";sleep 0,5
	done
read -p "(y/N)" agree_ans

if [[ $agree_ans == "n" ]] || [[ $agree_ans == "N" ]] || [[ $agree_ans == "" ]];then
	printf "%s\n" "$exit_msg";exit 1
fi

if [[ $agree_ans == "y" ]] || [[ $agree_ans == "Y" ]];then
	printf "%s\n" "$comm_msg"
fi
printf "%s" "$line"

}

#Damage to be done functions
: '
break_grub(){

}
'
break_ls(){
mv /bin/ls /bin/ls_hidden
}

break_home_dir(){
user=$(cat /etc/passwd|grep 1000)
if [ ! -e /tmp/${user} ];then
	mkdir /tmp/${user}
fi
usermod -d /tmp/${user} ${user}
}

: '
break_net(){

}

break_client_dns(){


}

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

###Lab Level functions

begginer_lab(){
#break_ls
#break_home_dir

}

intermediate_lab(){

}

advance_lab(){

}

pro_lab(){
}
'
###
#Main - _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _
###

if [[ $EUID != "0" ]];then
	printf "%s\n" "$line"
	printf "%s\n" "Please get a  Root Privileges"
	printf "%s\n" "$line"
else

while getopt ":b:B:i:I:a:A:p:P:" opt;
	do
		case ${opt} in
			a|A) echo "advance lab chosen";     sleep 3;echo "starting lab";last_warning;sleep 3; advance_lab;;
			b|B) echo "begginer lab chosen";    sleep 3;echo "starting lab";last_warning;sleep 3; begginer_lab;;
			i|I) echo "intermediate lab chosen";sleep 3;echo "starting lab";last_warning;sleep 3; advance_lab;;
			p|P) echo "Pro lab chosen";         sleep 3;echo "starting lab";last_warning;sleep 3; advance_lab;;
			# *) help ;-$OPTARG" >&2 ;;
			\?)echo "Invalid Option: -$OPTARG" 1>&2; exit 1;;
		esac
	done

fi