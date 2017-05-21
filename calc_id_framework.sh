#!/usr/bin/env bash

#####################################################################
#created by br0k3ngl255
#date 20.05.2017
#
: '
Create, using any programming language or shell scripting language, 
a framework for parallelization of instances of the above CalcID program on a list of ids.
The framework receives 3 parameters:        
Folder_name (For example ‘/home/datashare/runs’)
Ids_file - location of a text file with a list of ids        
Num_of_processes – the number of processes to run in parallel    
The framework continuously runs num_of_processes instances of the
CalcID program each with the same Folder_name and an id from Ids_file.
On CalcID program success - the id should be removed from ids_file.
On CalcID program failure - the id should remain in ids_file in order 
to try running the CalcID program with the same id again until it finishes successfully.
The framework continues running in a loop on the ids in ids_file until the file is empty.
'	
#
#####################################################################

###Vars ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
source ./CalcID.sh


###Funcs /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/

help(){
	echo "Incorrect script use."
	echo "usage: CalcID.sh FOLDER_NAME ID's_file  NUMBER OF INSTANCES"
	
	}


###
#Main - _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _
###

if [ "$EUID" == "0" ];then
	echo "please run with regular user";exit 1
else
	if [ -z $1 ] && [ -z $2 ] && [ -z $3 ];then 
		help
	else
		while true; do  #should i use paralel?	
						
		
		
					done	
