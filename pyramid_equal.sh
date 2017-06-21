#!/usr/bin/env bash

# Author  :
# Date    :
# Purpose :
# Bugs    :
# Edited  :

read -p "enter number: " num

for ((i=0;i<=$num;i++));do

     for((k = 0; k<=num-i; k++));do
         printf " ";
        done
      for ((k=0;k<$i;k++));do
	    printf "* " ; 
	    done
	    printf "\n";
done
