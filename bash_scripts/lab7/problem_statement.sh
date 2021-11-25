#!/bin/bash

# Examples in the same dir:
# ./problem_statement.sh 1_sum_two_nums.sh 2_display_files_w_permission.sh
# ./problem_statement.sh 1_sum_two_nums.sh 1_sum_two_nums.sh

# $# are all arguments passed to the script
# Check to see if number of arguments is not equal to 2
# If not then exit the script
if [ "$#" -ne 2 ]; then
    echo "${SCRIPT}: needs 2 arguments"
    exit
fi

FILE1=$1
FILE2=$2

if [ -d "${FILE1}" ] || [ -d "${FILE2}" ]; then
  echo "No directories please"
  exit
fi

if [ ! -f "${FILE1}" ] && [ ! -f "${FILE2}" ]; then
  echo "${FILE1}: no such file"
  echo "${FILE2}: no such file"
  exit
elif [ ! -f "${FILE1}" ]; then
  echo "${FILE1}: no such file"
  exit
elif [ ! -f "${FILE2}" ]; then
  echo "${FILE2}: no such file"
  exit
fi

if diff "${FILE1}" "${FILE2}" 1>/dev/null; then
  echo "The two files are identical"
else
  echo "The two files are not identical"
fi