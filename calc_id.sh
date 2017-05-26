#!/usr/bin/env bash

#####################################################################
#created by br0k3ngl255
#date 20.05.2017
#
: 'Create, using any programming language or shell scripting language, a program 
which simulates a calculation that fails 20% of the time. We’ll name this 
program CalcID.CalcID receives 2 parameters as command line input:
Folder_name (For example ‘/home/datashare/runs’) Id (A long number)
The program sleeps for a random amount of time between 1 and 30 seconds 
(This simulates a calculation) and then generates another random number. 
Using the second random number it does one of the following:
80% of runs - Success mode => Creates a folder with name Id under Folder_name. 
20% of runs - Failure mode => Finishes with non zero exit code.'
#
#####################################################################

###VARs ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::


###Funcs /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
help(){
	echo "Incorrect script use."
	echo "usage: CalcID.sh FOLDER_NAME ID (LONG NUMBER)"
	
	}


calc_simulate(){ # generates random "calculation" time between 1-30 sec
	sleep $(( ( RANDOM % 30 )  + 1 ))
	}
	
rate_chk(){ #provides random number of 10 and if 8 or higher fails
	cmd="$(( (RANDOM %10) +1 ))"
		if [ "$cmd" -le 7 ];then
			echo "success"
		elif [ "$cmd" -ge 8 ];then
			echo "fail"
		fi
	}
###
#Main - _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _
###

if [ "$EUID" == "0" ];then  # verifying that root is not runnig this
	echo "It is forbidden to run this program as root" ; exit
else
	if [ -z $1 ] && [ -z $2 ];then 
		help
	else
		if  [ $2 -ge 9999 ];then
			echo "calculating";calc_simulate;
			if [[ "$(rate_chk)" == "success" ]];then
				mkdir -p $1; touch $1/$2
			elif [[ "$(rate_chk)" == "fail" ]];then
				echo "fail error";
			fi
		else
			if (($2<=999999));then
			echo "2nd argument not long enough"
			fi
			if [ "$2" <= " " ];then
				echo "2nd argument not provided" 
			fi	
		fi		
	fi
fi
