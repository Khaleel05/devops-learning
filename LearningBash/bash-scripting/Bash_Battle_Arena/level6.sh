#!/bin/bash 


#Level 6: parsing Arguments
#Mission: Write a script that accepts a filename as an argument and prints the number of lines in that file. If no filename is provided, display a message saying 'No file provided'.

if [ -z "$1"  ]; then 
    echo "no file provided"
else
    numberoflines=$(wc -l < "$1")
    echo "file $1 has: $numberoflines lines" 
fi




#To capture a command output and save it to a variable you neeed COMMAND SUBSTITUTION. line 10 
#wc -l file-name prints both the line count and the filename. redirecting th efile into wc 
#with < file-name makes it print just the count.  