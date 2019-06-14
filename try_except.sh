#!/usr/bin/env bash

#creator : br0k3ngl255 
#date    : 24.10.2017
#purpose : implementing  try and except in bash script 
#version : 0.0.4
# link : https://stackoverflow.com/questions/22009364/is-there-a-try-catch-command-in-bash

try(){
    [[ $- = *e* ]]; SAVED_OPT_E=$?
    set +e
}

throw(){
    exit $1
}

except(){
    export ex_code=$?
    (( $SAVED_OPT_E )) && set +e
    return $ex_code
}

throwErrors(){
    set -e
}

ignoreErrors(){
    set +e
}

#####
#Main  --------------------------------------------------------------
####

try /usr/bin/tests

except 1
