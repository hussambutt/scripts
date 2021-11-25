#!/bin/bash

# maxdepth to not recursively search into sub directories
# type to only search for files
# printf to only print filename and size
find . -maxdepth 1 -type f -printf '%f %s\n'

# If you are using OSX comment the above command and uncomment the below command
# awk to print column 9 and then 5 for name and size respectively
# find . -maxdepth 1 -type f -exec ls -l {} \; | awk '{print $9, $5}'