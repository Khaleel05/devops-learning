#!/bin/bash

#Level 7: file sorting

#Mission:
#Write a script that sorts all .txt files in a directory by their size, from smallest to largest, and displays the sorted list.

if [ ! -z "$1" ];then
    if [ -d "$1" ];then
        echo "directory $1 found" 
        ls -s "$1"
    else
        echo "directory $1 not found"
    fi
else
    echo "no directory was provided." 
fi




#To sort by size pass the -s flag to the ls command to sort the list of files by size. 
#-z is a test operator to check whether a string is empty.
#-d is a test operator that check if the path exist and is a directory. 