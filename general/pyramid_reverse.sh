#!/usr/bin/env bash

# Author  :
# Date    :
# Purpose :
# Bugs    :
# Edited  :

read -p "enter number: " num

for((i=$num;i>0;i--));do
	for ((j=$i; $j>0;j--));do
		printf "* "
		done
		printf "\n"
	done
