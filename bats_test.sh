#!/usr/bin/env bats
#set -xe
##############################################################################
# created by : br0k3ngl255
# purpose        : to provision rpm based laptops for development
# date           :  14/12/2018
# version        : 0.0.7
##############################################################################


###Variables:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::



###Functions /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/


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


#####
#Main
#####
