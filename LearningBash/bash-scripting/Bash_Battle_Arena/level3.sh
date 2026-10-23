#!/bin/bash


#exists=`find "Arena/warrior.txt"`
#echo 'the respnse '$exists

file="Arena/hero.txt"


if [ -e "$file" ]; then
    echo "The hero.txt file exists in the Arena directory."
else
    echo "The hero.txt file does not exist in the Arena directory."
fi

#when writing a if  statement, the syntax is important: 
#the condition for the if statement has to seperated from the square brackets by a space. 

#the -e flag is used to check if a file exists.
#the -f flag is used to check if a file exists and is a regular file.(and not a directory)

