#!/usr/bin/env bash
###############################
#created by: Pushtakio
#purpose: print table and insert data in it.
#date: 20.02.2020
#version: 1.0.0
###############################


var="some string"

deco_table(){
local l="########"
data="$@"
printf "\n#%10s %10s %10s#\n" "$data"
}

echo "#######################"
deco_table "data1 data2  data3"
deco_table "$var" "$var"  "$var" $var
echo "#######################"
