#!/bin/bash

#level 8: multi file searcher. 

#mission
#Create a script that searches for a specific word or phrase across all .log files in a directory and outputs the names of the files that contain the word or phrase.



if [ $# -eq 0 ];then
    echo "you've provided no arguments."
    echo "first argument is the location and the second argument is the phase you want to search."
elif [ $# -gt 0 ] && [ $# -lt 2 ]; then 
    echo "can you also provide a second argument - "a phase you wish to search.""
else
    location="$1"
    statement="$2"
    find  "$location" -type f -name  '*.log' -exec grep -l -- "$statement" {} +
fi


#to identify if argments have been given you can check them against the total
# $# checks the total number of arguments given. 

