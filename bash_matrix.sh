#!/bin/bash
#set -xe
##############################################################################
# edited by: Pushtakio --> created by ### http://bruxy.regnet.cz/web/linux ###
#purpose: matrix printout
#date: 08/10/2019
#version : 1.1.0
##############################################################################
echo -e "\033[2J\033[?25l"
R=`tput lines` C=`tput cols`
 : $[R--]
  while true
    do ( e=echo\ -e s=sleep j=$[RANDOM%C] d=$[RANDOM%R];
      for i in `eval $e {1..$R}`;
        do c=`printf '\\\\0%o' $[RANDOM%57+33]`
          $e "\033[$[i-1];${j}H\033[32m$c\033[$i;${j}H\033[37m"$c;
           $s 0.01;
           if [ $i -ge $d ];then
            $e "\033[$[i-d];${j}H ";
          fi;
    done
      for i in `eval $e {$[i-d]..$R}`; #[mat!rix]
        do echo -e "\033[$i;${j}f "
        $s 0.01;done)& sleep 0.02
      done #(c) 2011 -- [ BruXy ]
