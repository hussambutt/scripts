#!/bin/bash

NAME="MYLASTNAME"
FIRSTNAME="MYFIRSTNAME"
DIRECTORY=~/directory

# Create and populate the DIRECTORY path if it does not exist
# No change if it already exists
if [ ! -d "${DIRECTORY}" ]; then
    mkdir -p ${DIRECTORY}
    for i in {1..10}
    do
        touch ${DIRECTORY}/file-${i}
        mkdir -p ${DIRECTORY}/folder-${i}

        for j in {1..10}
        do
            touch ${DIRECTORY}/folder-${i}/file-${j}-folder-${i}
        done
        tar -cpf ${DIRECTORY}/folder-${i}.tar -P ${DIRECTORY}/folder-${i}
        rm -r ${DIRECTORY}/folder-${i}
    done
fi

while [ "${FIRST_SELECTION}" != "Q" ]; do
    echo -e "L - List contents of the directory\nS - Select a file\nQ - Quit"
    read FIRST_SELECTION
    if [ "${FIRST_SELECTION}" == "L" ]; then
        echo -e "\nDirectory contents:"
        ls ${DIRECTORY}
        echo ""
    elif [ "${FIRST_SELECTION}" == "Q" ]; then
        echo "Bye!"
        exit
    elif [ "${FIRST_SELECTION}" == "S" ]; then
        while :; do
            echo -e "\nFile list:"
            find ${DIRECTORY} -type f -not -name "*.tar" -printf "%f\n"
            echo -e "\nType a filename to select it"
            read SELECTED_FILE
            # Ensure user enters an existing file name
            while [ ! -f ${DIRECTORY}/${SELECTED_FILE} ] || [ "${SELECTED_FILE}" == "" ]; do
                echo -e "\nPlease use a valid filename!\nFile list:"
                # Find and print all files without the .tar extension
                find ${DIRECTORY} -type f -not -name "*.tar" -printf "%f\n"
                echo ""
                read SELECTED_FILE
            done
            echo "You have selected the following file:"
            ls -l ${DIRECTORY}/${SELECTED_FILE}
            echo -e "\nA - Add to existing archive\nB - Go back to previous menu\nC - Copy file\nD - Delete file\nM - Move file\nR - Rename file"
            read FILE_MANIPULATION
            # if elif statements to catch each scenario
            if [ "${FILE_MANIPULATION}" == "A" ]; then
                echo "Which archive should be updated?"
                find ${DIRECTORY} -type f -name "*.tar" -printf "%f\n"
                echo ""
                read ARCHIVE
                tar uf ${DIRECTORY}/${ARCHIVE} ${DIRECTORY}/${SELECTED_FILE}
            elif [ "${FILE_MANIPULATION}" == "D" ]; then
                echo "Are you sure you want to delete ${SELECTED_FILE}?(y/n)"
                read DELETE_ANSWER
                if [ "${DELETE_ANSWER}" == "y" ]; then
                    rm ${DIRECTORY}/${SELECTED_FILE}
                fi
            elif [ "${FILE_MANIPULATION}" == "M" ]; then
                echo "Please specify directory path to move file"
                read DIR_PATH
                mv ${DIRECTORY}/${SELECTED_FILE} ${DIR_PATH}/${SELECTED_FILE}
            elif [ "${FILE_MANIPULATION}" == "C" ]; then
                echo "Please specify directory path to move file(e.g /tmp)"
                read DIR_PATH
                cp ${DIRECTORY}/${SELECTED_FILE} ${DIR_PATH}/${SELECTED_FILE}
            elif [ "${FILE_MANIPULATION}" == "R" ]; then
                DATE=$(date '+%Y-%m-%d')
                mv ${DIRECTORY}/${SELECTED_FILE} ${DIRECTORY}/${SELECTED_FILE}_${NAME}_${FIRSTNAME}_${DATE}
            elif [ "${FILE_MANIPULATION}" == "B" ]; then
                echo -e "Going back to the previous menu ...\n"
                break
            fi
        done
    fi
done
