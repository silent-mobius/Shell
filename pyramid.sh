#!/usr/bin/env bash

# Author  :
# Date    :
# Purpose :
# Bugs    :
# Edited  :

read -p "enter number: " num

for((i=1; i<=$num; i++));do
	for((j=1;j<=$i;j++));do
		printf "* "
		done
	printf "\n"
	done
