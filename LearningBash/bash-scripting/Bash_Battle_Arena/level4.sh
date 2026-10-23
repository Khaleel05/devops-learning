#!/bin/bash

#Level 4: file manipulation
#Mission: Create a script that copies all .txt files from the Arena directory to a new directory called Backup.

if [ ! -d "Backup" ]; then
    mkdir Backup
    echo "Backup directory created."
else
    echo "Backup directory already exists."
fi

for file in Arena/*.txt; do
    cp "$file" Backup/
    echo "Copied $file to Backup."
done

#the -d tag is used to check if a directory exists. 
