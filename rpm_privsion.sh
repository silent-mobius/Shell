#!/usr/bin/env bash
#set -xe
################################################################################
#created by:pushtakio
#purpose: provision my rpm based desktops
#date: 02/07/2019
#version: 1.0.0
###############################################################################

####Variables :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::


#arrays:
pkgs=(gitg gitk geany guake plank \
	     remmina falkon gimp vlc \
	     sqlitebrowser pgadmin3 \
	     gnome-builder owncloud-client \
	     terminator epel-release meld wget)
repo_pkgs=()
group_pkgs=()


####Functions /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/

deco(){
  pre="######################################################################"
  printf "\n$pre\n#%s\n$pre\n" $@
}

######
#Main - _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _
######

if [[ $EUID == "0" ]];then
  true
else
  false
fi
