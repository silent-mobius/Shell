#!/usr/bin/env bash

#############################################################################################33
#created by	: smobius
#purpose	: decorate output with function	
#date		: 21.05.2019
#version	:	0.0.1
##############################################################################################3


deco(){
	pre="###############################################################"
	post="###############################################################"
	printf "$pre\n%s\n$post\n" "$*"
	
	}


msg='this is message'


deco $msg
