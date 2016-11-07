#!/usr/bin/env bash

########################################################################
#Created by: br0k3ngl255
#Date: 7.11.2016
#Purpose: 
#
########################################################################


###Vars +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
USR="Student"
R_USR="root"
PASSWD="Password"
R_PASSWD="RedHat7"


###Funcs/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/

help(){
	
	echo "Please get ROOT Access"
	
	}
	
resetPassword(){
	echo "$USR:$PASSWD" | chpasswd
		echo "$R_USR:$R_PASSWD" | chpasswd
	}	

removeLvm(){
	cmd=`lvs|grep -v grep |grep -v centos|grep lv01 &> /dev/null ;echo $? `
	if [ "$cmd" == "0" ];then
		lvremove lv01
	fi
		cmd1=`vgs|grep -v grep |grep -v centos|grep myStorage &> /dev/null ;echo $? `
		if [ "$cmd1" == "0" ];then
			vgremove  myStorage
		fi
			cmd2=`pvs|grep -v grep |grep -v centos|grep myStorage &> /dev/null ;echo $? `
			if [ "$cmd2" == "0" ];then
				pvremove /dev/sdb 
				pvremove /dev/sdc
				pvremove /dev/sdd
			fi
	}
	
removePackage(){
	cmd=`rpm -qa |grep flash &> /dev/null ;echo $?`
		if [  "$cmd" == "0" ];then
			yum remove  -y  *flash*
		fi
	}
	
removeRepo(){
	#
	rm -rf /etc/yum.repos.d/private.repo &> /dev/null
	rm -rf /etc/yum.repos.d/myrepo.repo  &> /dev/null
	rm -rf /etc/yum.repos.d/myrepo.repo &> /dev/null
	
	}

main(){
		echo "Resetting Password"
		resetPassword; sleep 1;
		echo "Removing and formatting LVM"
		removeLvm;sleep 1
		echo "Removing Packages"
		removePackage;sleep 1
		echo "Removing Repo"
		removeRepo;sleep 1
	}

###
#Main - _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _ 
###
	if [ "$EUID" != "0" ];then
			help
	elif [ "$EUID" == "0" ];then
			main
	else
		echo "ERORR !!!!!";exit
	fi
