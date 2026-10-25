#!/bin/bash 


#Create a script that checks if a file exists and displays its permissions.


FILENAME="$1"

[ $# -eq 0 ] && exit 1

if [ -e $FILENAME ];then
    echo "file exists"
else 
    echo "file does not exist"    
fi


if [[ -w "$FILENAME" && -r "$FILENAME" && -x "$FILENAME" ]];then
    echo "$1 is a file that can read write and execute"
else
    echo it doesnt have all permision. 
fi

echo "checking: $FILENAME" 