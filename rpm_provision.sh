#!/usr/bin/env bash

##############################################################################
# created by : br0k3ngl255
# purpose	 : to provision rpm based laptops for development
# date		 :  14/12/2018
# version	 : 0.4.9
##############################################################################
#set -x	
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
	     
	     
group_pkg_arr=("Administration Tools" "Ansible node" \
			   "Authoring and Publishing Books and Guides" \
			   "C Development Tools and Libraries" \
			   "Cloud Management Tools" "Container Management" \
			   "Development Tools" "Editors" "Headless Management" \
			   "LibreOffice" "Network Servers" "Python Classroom" \
			   "Python Science" "RPM Development Tools" "Fonts" \
			   "Hardware Support" "System Tools" )

f_external_repo_arr=("https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm" \
		     "https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm")
c_external_repo_arr=("https://download1.rpmfusion.org/free/el/rpmfusion-free-release-7.noarch.rpm" \
		     "https://download1.rpmfusion.org/nonfree/el/rpmfusion-nonfree-release-7.noarch.rpm" )

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
	if [ "$cmd" == "fedora" ];then
		if [ ! $cmd_ver -ge 22 ];then
			printf '%s\n' "$line"
				printf '%s \n' "$msg_unsupported"
			printf '%s\n' "$line"
			exit 1
		fi
		installer="dnf"
	fi

	if [ "$cmd" == "centos" ];then
		if [ ! $cmd_ver -ge "7" ];then
			printf '%s\n' "$line"
				printf '%s \n' "$msg_unsupported"
			printf '%s\n' "$line"
			exit 1
		fi
			installer="yum"
	fi

	if [ "$cmd" == "redhat" ];then
		if [ ! $cmd_ver -ge "7" ];then
			printf '%s\n' "$line"
				printf '%s \n' "$msg_unsupported"
			printf '%s\n' "$line"
			exit 1
		fi
		installer="yum"
	fi
	}

add_repo(){
	choose_installer;sleep $Time
	cmd=$(cat /etc/*-release|grep ID|head -n1|awk -F= '{print $2}'|sed 's/\"//g')
	if [ "$cmd" == "redhat" ] || [ $cmd == "centos" ];then
		printf '%s \n' "$msg_add_repo"
			IFS=","
			for repo in ${c_external_repo_arr[@]}
				do
					$installer install $repo &>> $logf
					sleep $Time
				done
			IFS=" "
	fi

	if [ "$cmd" == "fedora" ];then
		printf '%s \n' "$msg_add_repo"
			IFS=","
			for repo in ${f_external_repo_arr[@]}
				do
					$installer install -y $repo &>> $logf
					sleep $Time
				done
			IFS=" "
	fi

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
		choose_installer
	else
		true
	fi
	IFS=","
	for repo in ${external_repo_arr[@]}
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
		for link in ${links[@]}
			do
				wget $link  &>> $logf;sleep 0.5
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
############################################################
#TODO - need to add getops variables to make it with modular
############################################################
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
		printf '%s\n' "$msg_note"
	printf '%s\n' "$line"

			install_pkgs
			sleep $Time
			
	printf '%s\n' "$line"
		printf '%s\n' "$msg_note"
	printf '%s\n' "$line"
	
			install_group_pkgs
			sleep $Time
			
	printf '%s\n' "$line"
		printf '%s\n' "$msg_note"
	printf '%s\n' "$line"
	
			manual_download
			sleep $Time	
				
	printf '%s\n' "$line"
		printf '%s\n' "$msg_end"
	printf '%s\n' "$line"

fi
