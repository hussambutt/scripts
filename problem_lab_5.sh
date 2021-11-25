#!/bin/bash

DATAFILE=book.dat
DATAMAX=40

echo ${DATAFILE}

if [ ! -f "${DATAFILE}" ]; then
    touch book.dat
fi

TOTALLINES=`wc -l < ${DATAFILE}`

# Entry State
while [ "${TOTALLINES}" -le "${DATAMAX}" ]
do
    echo -e "Enter the name of the book.\nTo stop entering, press enter at the beginning of a line"
    read BOOK_NAME
    if [ "${BOOK_NAME}" == "" ]; then
        break
    fi
    echo "Enter the author"
    read BOOK_AUTHOR
    echo "Enter the publisher"
    read BOOK_PUB
    echo "Enter the price"
    read BOOK_PRICE

    echo "${BOOK_NAME},${BOOK_AUTHOR},${BOOK_PUB},${BOOK_PRICE}" >> ${DATAFILE}
done

# Inquiry State
ANSWER=""
while [ "${ANSWER}" != "Q" ]
do
    echo "Enter Q to end, or T or A to search for title and author"
    read ANSWER
    if [ "${ANSWER}" == "Q" ]; then
        echo "Bye!"
        exit
    elif [ "${ANSWER}" == "T" ]; then
        echo "Enter the book title"
        read SEARCH_TITLE
        awk -v SRC_TITLE="${SEARCH_TITLE}" -F',' 'BEGIN { found=0 }{
        if ($1 == SRC_TITLE)
            {printf "Title: %s \nAuthor: %s \nPrice: %.2f\n", $1, $2, $4; found=1;}
        }END { if (!found) print "No such book." > "/dev/stderr" }' ${DATAFILE}

    elif [ "${ANSWER}" == "A" ]; then
        echo "Enter the book author"
        read SEARCH_AUTHOR
        awk -v SRC_AUTHOR="${SEARCH_AUTHOR}" -F',' 'BEGIN { found=0 }{
        if ($2 == SRC_AUTHOR)
            {printf "Title: %s \nAuthor: %s \nPrice: %.2f\n", $1, $2, $4; found=1;}
        }END { if (!found) print "No such book." > "/dev/stderr" }' ${DATAFILE}
    fi
done
