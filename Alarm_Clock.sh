#!/usr/bun/env bash 
#set -x
#created by br0k3ngl255
#date updated 30.01.14
#Version 2 of alarm clock
######################################################################
# i started this script at one evening when my phone was stolen      #
# and there was nobody to wake me up, it took me some time to figure #
# out how i'd wish to make it, but after several hours i was done    #
# and script was working.                                            # 
#			hope you'll enjoy it and as much i did.                        #
######################################################################
##############################################################################
#Copyright (c) <2014-2016>, <LinuxSystems LTD>
#All rights reserved.
#Redistribution and use in source and binary forms, with or without
#modification, are permitted provided that the following conditions are met:
#    * Redistributions of source code must retain the above copyright
#      notice, this list of conditions and the following disclaimer.
#    * Redistributions in binary form must reproduce the above copyright
#      notice, this list of conditions and the following disclaimer in the
#      documentation and/or other materials provided with the distribution.
#    * Neither the name of the <LinuxSystems LTD> nor the
#      names of its contributors may be used to endorse or promote products
#      derived from this software without specific prior written permission.
#
#THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
#ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
#WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
#DISCLAIMED. IN NO EVENT SHALL <COPYRIGHT HOLDER> BE LIABLE FOR ANY
#DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
#(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
#LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
#ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
#(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
#SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
########################################################################
: '
DISCLAIMER :  use this at your own risk
'
: ' 
TODO --> most of thefunc need to be changed and need more options to be done.
'
##Vars ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
alarmRing='' 
alarmTime=''
currentTime="`date +%k:%M`"


##Funcs /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/

playerChoise(){ #  .
	alarmRing=`zenity --file-selection`
}

checkVLC(){ #checking player to play the alert/alarm.
status=0
	if [ ! $(whcih vlc) ];then
		status=1
	else
		zenity --notify --text="you do not have VLC player installed. Please choose other player."
		sleep 5
			playerChoise
	fi
echo $status
}

 checkInput(){ #cheking time input to be corret.
Status=0
	if [[ "$alarmTime" =~ ^[1-2]?[0-9]\:[0-5][0-9]$ ]];then
		Status=0
	else
		Status=1
	fi
echo $Status
}

getRing(){ # getting alarm/alert to wake you up.
	
	alarmRing=`zenity --file-selection `
}
 
 getAlarmTime(){ ##grabbing the time to awake you .

	alarmTime=`zenity --entry --text="please enter desired time to wake you up?"`
}


####
#Main - _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _
####

if [ `checkVLC` == 1 ];then 
	alarmPlay=/usr/bin/vlc
fi
	getAlarmTime 2> /dev/null
		
	if [ `checkInput` = 0 ];then
		zenity --notification --text=" ok will wake you up at $alarmTime" 2> /dev/null
	else
		zenity --error  --text=" wrong input check that you have inseted the time correctly " 2> /dev/null
			exit "1"
	fi
			getRing  2> /dev/null  

#************* this loop isn't perfect and within time it will be changed, until then -- keep tight over there*******************

while [ $currentTime != $alarmTime ];
	do
	 currentTime="`date +%k:%M`" #update the variable of time change
	 sleep 1 ##  DO NOT CHANGE THE VALUE - if must change not more then 15 - other wise it won't start the alarm.
	done

if [ $currentTime==$alarmTime ];then
	$alarmPlay $alarmRing > /dev/null 2> /dev/null & 
fi 
