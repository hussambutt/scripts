#!/bin/bash

echo "What is your name?"
read NAME
echo "Hello ${NAME}"
echo "How old are you?"
read AGE
echo "oh, you are $AGE years old"
echo "What is your login name?"
read LOGINNAME

if id ${LOGINNAME} &>/dev/null; then
    USERSHELL=`awk -F: -v user="${LOGINNAME}" '$1 == user {print $NF}' /etc/passwd`
    echo "Login shell for the user ${LOGINNAME}: ${USERSHELL}"
else
    echo 'User not found'
fi
