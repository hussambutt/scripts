#!/bin/bash

SCRIPT=`basename "$0"`

# $# are all arguments passed to the script
# Check to see if number of arguments is not equal to 2
# If not then exit the script
if [ "$#" -ne 2 ]; then
    echo "${SCRIPT}: needs two parameters"
    exit
fi

NUMBER1=$1
NUMBER2=$2

# Expression for addition $((NUM1 + NUM2))
echo $((NUMBER1+NUMBER2))

# Bash does not support floating point addition
# Relying on the tool bc it can still be achieved
# echo "2.2+3.3" | bc