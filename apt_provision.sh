#!/usr/bin/env bash
#set -xe
##############################################################################
# created by : br0k3ngl255
# purpose	 : to provision apt based laptops for development
# date		 :  18/03/2019
# version	 : 0.8.40
##############################################################################

##vars ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#folders
log_folder="/tmp"

#msgs
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
line="========================================================================"
Time=1
installer=""
log_file="provision.log"

#combo
logf="$log_folder/$log_file"

#arrays
gui_pkg_arr=(gitg gitk geany guake plank \
	     remmina falkon gimp vlc \
	     sqlitebrowser pgadmin3 \
	     gnome-builder owncloud-client \
	     terminator epel-release meld wget)
	     
	     

links=(\ 
	   "http://kdl.cc.ksosoft.com/wps-community/download/6757/wps-office-10.1.0.6757-1.x86_64.rpm" \
	   "https://atom.io/download/rpm",\
	   "https://downloads.slack-edge.com/linux_releases/slack-3.3.3-0.1.fc21.x86_64.rpm",\
	   "https://releases.hashicorp.com/terraform/0.11.11/terraform_0.11.11_linux_amd64.zip",\
	   "https://releases.hashicorp.com/vault/1.0.1/vault_1.0.1_linux_amd64.zip",\
	   "https://releases.hashicorp.com/nomad/0.8.6/nomad_0.8.6_linux_amd64.zip",\
	   "https://releases.hashicorp.com/consul/1.4.0/consul_1.4.0_linux_amd64.zip",\
	   "https://releases.hashicorp.com/vagrant/2.2.2/vagrant_2.2.2_x86_64.rpm",\
	   "https://releases.hashicorp.com/packer/1.3.3/packer_1.3.3_linux_amd64.zip"\
	   )
##funcs /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
choose_installer(){
	cmd=$(cat /etc/*-release|grep ID|head -n1|awk -F= '{print $2}'|sed 's/\"//g')
	cmd_ver=$(cat /etc/*-release|grep VERSION_ID|head -n1|awk -F= '{print $2}'|sed 's/\"//g')
case $cmd in

  debian|ubuntu|linuxmint) 
					printf '%s\n' "$line";
						installer="apt-get";
					printf '%s\n' "$msg_installer_set";
					printf '%s\n' "$line";
							;;
	
  *) 	printf '%s\n' "$line"; 
			printf '%s \n' "$msg_unsupported"
		printf '%s\n' "$line";
			exit 1;
			;;
esac


	}

add_repo(){
	choose_installer;sleep $Time
	cmd=$(cat /etc/*-release|grep ID|head -n1|awk -F= '{print $2}'|sed 's/\"//g')
	
	case $cmd in 
	
		debian) printf "%s \n" "##MAIN
deb http://http.debian.net/debian jessie main
deb-src http://http.debian.net/debian jessie main

deb http://http.debian.net/debian jessie-updates main
deb-src http://http.debian.net/debian jessie-updates main

deb http://security.debian.org/ jessie/updates main
deb-src http://security.debian.org/ jessie/updates main

deb ftp://ftp.debian.org/debian stable main contrib non-free
###BackPort
deb http://http.debian.net/debian jessie-backports main
deb http://ftp.debian.org/debian/ jessie-backports non-free contrib
" >> /etc/apt/source.list.d/jessie.repo.list
;;
		ubuntu) true;;
		linuxmint)true;;
		*) 	printf '%s\n' "$line"; 
			printf '%s \n' "$msg_unsupported"
			printf '%s\n' "$line";
			exit 1;
			;;
	
	#echo "deb http://download.virtualbox.org/virtualbox/debian jessie contrib" >> /etc/apt/sources.list


}

install_pkgs(){
	printf '%s\n' "$line"
		printf '%s \n' "$msg_start_install"
	printf '%s\n' "$line"
	IFS=","
	for pkg in ${gui_pkg_arr[@]}
		do
			$installer install -y $pkg &>> $logf; sleep $Time
		done
	IFS=" "
}


install_group_pkgs(){
	if [ -z $installer ];then
		choose_installer  # neesds to be tasksel
	else
		true
	fi
	IFS=","
	for repo in ${external_repo_arr[@]} ##added sgroups need checking.
		do
			$installer groupinstall $repo &>> $logf
		done
	IFS=" "
}

manual_download(){
	printf '%s\n' "$line"
		printf '%s \n' "$msg_note"
	printf '%s\n' "$line"
	if [[ -x /usr/bin/wget ]];then
	IFS="," 
		for link in ${links[@]} #need to validate that is runs and drops logs to appropriate location.
			do
				wget $link --backgraound -P /home/$USER/Downloads &>> $logf ;sleep 0.5
			done;
	IFS=" "
	fi
	}


####
#Main - _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _
####

if [[ $EUID != 0 ]];then
	printf '%s\n' "$line"
		printf '%s \n' "$msg_permission";sleep $Time
	printf '%s\n' "$line"
	exit 1

else

	printf '%s\n' "$line"
		printf '%s\n' "$msg_start"
	printf '%s\n' "$line"
			
			sleep $Time

	printf '%s\n' "$line"
		printf '%s\n' "$msg_note"
	printf '%s\n' "$line"
		
			add_repo
			sleep $Time

	printf '%s\n' "$line"
		printf '%s\n' "$msg_note: pkgs_arr install"
	printf '%s\n' "$line"

			install_pkgs
			sleep $Time
			
	printf '%s\n' "$line"
		printf '%s\n' "$msg_note: install_group_pkgs install"
	printf '%s\n' "$line"
	
			install_group_pkgs
			sleep $Time
			
	printf '%s\n' "$line"
		printf '%s\n' "$msg_note: starting manual download"
	printf '%s\n' "$line"
	
			manual_download 
			sleep $Time	
				
	printf '%s\n' "$line"
		printf '%s\n' "$msg_end"
	printf '%s\n' "$line"

fi
