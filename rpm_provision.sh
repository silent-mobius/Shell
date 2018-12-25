#!/usr/bin/env bash

##############################################################################
# created by : br0k3ngl255
# purpose	 : to provision rpm based laptops for development
# date		 :  14/12/2018
# version	 : 0.2.6
##############################################################################

##vars ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

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

#arrays
gui_pkg_arr=(gitg,gitk,geany,guake,plank,
	     remmina,falkon,gimp,vlc,
	     sqlitebrowser,pgadmin3,
	     gnome-builder,owncloud-client,
	     terminator,epel-release,meld )
	     
>>>>>>> c0bf02b27ee5351a7043a290673584810d5e285e
group_pkg_arr=("Administration Tools", "Ansible node",\
			   "Authoring and Publishing Books and Guides",\
			   "C Development Tools and Libraries",\
			   "Cloud Management Tools", "Container Management",\
			   "Development Tools", "Editors", "Headless Management",\
			   "LibreOffice", "Network Servers", "Python Classroom",\
			   "Python Science", "RPM Development Tools", "Fonts",\
			   "Hardware Support", "System Tools" )

f_external_repo_arr=("https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm",
		     "https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm")
c_external_repo_arr=("https://download1.rpmfusion.org/free/el/rpmfusion-free-release-7.noarch.rpm",
		     "https://download1.rpmfusion.org/nonfree/el/rpmfusion-nonfree-release-7.noarch.rpm" )


##funcs /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
choose_installer(){
	cmd=$(cat /etc/*-release|grep ID|head -n1|awk -F= '{print $2}'|sed 's/\"//g')
	cmd_ver=$(cat /etc/*-release|grep VERSION_ID|head -n1|awk -F= '{print $2}'|sed 's/\"//g')
	if [ "$cmd" == "fedora" ];then
		if [ ! $cmd_ver -ge 22 ];then
			printf "%s \n" $line
				printf "%s \n" $msg_unsupported
			printf "%s \n" $line
			exit 1
		fi
		installer="dnf"
	fi

	if [ "$cmd" == "centos" ];then
		if [ ! $cmd_ver -ge "7" ];then
			printf "%s \n" $line
				printf "%s \n" $msg_unsupported
			printf "%s \n" $line
			exit 1
		fi
			installer="yum"
	fi

	if [ "$cmd" == "redhat" ];then
		if [ ! $cmd_ver -ge "7" ];then
			printf "%s \n" $line
				printf "%s \n" $msg_unsupported
			printf "%s \n" $line
			exit 1
		fi
		installer="yum"
	fi
	}

add_repo(){
	choose_installer;sleep $Time
	cmd=$(cat /etc/*-release|grep ID|head -n1|awk -F= '{print $2}'|sed 's/\"//g')
	if [ "$cmd" == "redhat" ] || [ $cmd == "centos" ];then
		printf "%s \n" $msg_add_repo
			for repo in ${c_external_repo_arr[@]}
				do
					$installer install $repo
					sleep $Time
				done
	fi

	if [ "$cmd" == "fedora" ];then
		printf "%s \n" $msg_add_repo

			for repo in ${c_external_repo_arr[@]}
				do
					$installer install $repo
					sleep $Time
				done

			for repo in ${f_external_repo_arr[@]}
				do
					$installer install -y $repo
					sleep $Time
				done
	fi

}

install_pkgs(){
	printf "%s \n" $line
		printf "%s \n" $msg_start_install
	printf "%s \n" $line
	IFS=","
	for pkg in ${gui_pkg_arr[@]}
		do
			$installer install -y $pkg; sleep $Time
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
			$installer install $repo
		done
	IFS=" "
}


####
#Main - _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _
####

if [ $EUID != 0 ];then
	printf "%s \n" $msg_permission;sleep $Time
	exit 1
else
	printf "%s \n" $line
		printf "%s \n" $msg_start
	printf "%s \n" $line
	sleep $Time

	printf "%s \n" $line
		printf "%s \n" $msg_note
	printf "%s \n" $line
			add_repo
			sleep $Time

	printf "%s \n" $line
		printf "%s \n" $msg_note
	printf "%s \n" $line

			install_pkgs
			sleep $Time
			
	printf "%s \n" $line
		printf "%s \n" $msg_note
	printf "%s \n" $line
	
			install_group_pkgs
			sleep $Time
			
			
	printf "%s \n" $line
		printf "%s \n" $msg_end
	printf "%s \n" $line

fi
