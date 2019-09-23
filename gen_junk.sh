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
  _size=$1
  dd if=/dev/zero of=/tmp/junk_file.tmp -bs=$_size
}

#####
#Main - _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _-
#####


if [[ $EUID == 0 ]];then
    deco $msg_root
else
  true
fi
