#!/bin/bash

SCRIPT=`basename "$0"`

# $PWD is the current working directory
# maxdepth to not recursively search into sub directories
# type to only search for files
# perm to only search for files with wrtie permission for user
find $PWD -maxdepth 1 -type f -perm -u=w
