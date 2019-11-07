#!/usr/bin/env bash
#set -xe
###############################################################################
#
#
#
#
###############################################################################

#Vars :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
msg_root="Please do not use ROOT for this script"
msg_no_option="No Such Option Exists: "

#Funcs /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/

deco(){
  printf "Decompressing %s files" "$@"
}
unpack(){
  while [ x"$1" != x ];
   do
   case "$1" in
    *.tar.gz | *.tgz ) tar -xzf "$1" ;shift ;;
    *.tar.bz2 | *.tbz ) tar -xjf "$1" ;	shift ;;
    *.zip)unzip "$1" ; shift;;
    *.gz) gunzip "$1" ; shift ;;
    *.bz2) bunzip2 "$1" ; shift ;;
    *.Z) uncompress $1 ;;
    *)	echo $msg_no_option ;shift ;;
    esac
  done
}

#####
#Main - _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _
#####

if [[ $EUID == "0"]];then
  echo $msg_root
else
  while ":v:r:" options
    do
      case $options in
        v) vflag=1 ;;
        r) rflag=1 ;;
        \?) echo $msg_no_option $OPTARG;;

      esac
    done
