#!/usr/bin/env bash

####################################################################33
#created by: smobius
#purpose : genersal script for installing k8s
#date	: 21.05.2019
#version: 0.0.1
#####################################################################33

chars="/-\|"

while :; do
  for (( i=0; i<${#chars}; i++ )); do
    sleep 0.5
    echo -en "${chars:$i:1}" "\r"
  done
done
