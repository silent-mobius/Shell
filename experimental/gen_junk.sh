#!/usr/bin/env bash
#set -ex
################################################################################
# created by pushtakio
# purpose: create junk data for showing how to use tar and alike tools.
# date: 21/09/2019
# vers: 1.0.0
###############################################################################

####Vars  :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
#messages
msg_root="Please do not use ROOT User for this script"
msg_permissions="You do not have sufficiant ppermissins to use this script in destination folder"
msg_variables_missing="either _file or _size or both variables are missing"

#misc
_time=1.5
line="#########################################################################"
####Functions /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
deco(){
  pre=$line
  post=$line

  print "\n$pre\n#%s \n$post" "$@"
}

geb_junk(){
  _file=$1
  _size=$2
  if [[ $_file == '' ]] && [[$_size == '' ]]
    deco "$msg_variables_missing"
    exit 1
  fi

  if [[ $_file == '' ]] || [[$_size == '' ]]
   deco "$msg_variables_missing"
    exit 1
  fi

  if [[ $_file != '' ]] && [[$_size != '' ]]
      dd if=/dev/zero of=$_file -bs=$_size count=1

  fi
}

#####
#Main - _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _-
#####


if [[ $EUID == 0 ]];then
    deco $msg_root
else
  while geto
fi
