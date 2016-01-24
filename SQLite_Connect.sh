#!/usr/bin/env bash 

########################################################################
#Purpose : connect/create sqlite db for script data use.
########################################################################
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
# Defining my databse first table
: '
DISCLAIMER :  use this at your own risk
'
STRUCTURE="CREATE TABLE data (id INTEGER PRIMARY KEY,name TEXT,value TEXT);";
 
# Creating an Empty db file and filling it with my structure
cat /dev/null > dbname.db
echo $STRUCTURE > /tmp/tmpstructure
sqlite3 dbname.db < /tmp/tmpstructure;
rm -f /tmp/tmpstructure;
 
# Inserting some data into my structure
sqlite3 dbname.db "INSERT INTO data (name,value) VALUES ('MyName','MyValue')";
sqlite3 dbname.db "INSERT INTO data (name,value) VALUES ('MyOtherName','MyOtherValue')";
 
# Getting my data
LIST=`sqlite3 dbname.db "SELECT * FROM data WHERE 1"`;
 
# For each row
for ROW in $LIST; do
     # Parsing data (sqlite3 returns a pipe separated string)
      Id=`echo $ROW | awk '{split($0,a,"|"); print a[1]}'`
      Name=`echo $ROW | awk '{split($0,a,"|"); print a[2]}'`
      Value=`echo $ROW | awk '{split($0,a,"|"); print a[3]}'`
     
      # Printing my data
      echo -e "\e[4m$Id\e[m) "$Name" -> "$Value;
done
