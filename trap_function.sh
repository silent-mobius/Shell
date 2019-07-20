#!/usr/bin/env bash

###############################################################################
#created by: Fahmida Yesmin (https://linuxhint.com/bash_trap_command/)
#edited by : pushtakio
#purpose: Call func function on exit
#date : 20/07/2019
#version : 1.0.0
###############################################################################

#variables ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

#Functions  /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
trap func exit

dec() {

  echo "Task completed"
}

######
#Main - _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _
######

for i  in *
do
  echo "$i"
done
