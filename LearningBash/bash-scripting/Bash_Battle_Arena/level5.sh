#!/bin/bash

#level 5: coombining the basic concepts. 

#Mission:
#1. Creates a directory names 'Battlefield'
#2. Inside Battlefield, create files named knight.txt, sorcerer.txt, and rogue.txt.
#3. Check if knight.txt exists; if it does, move it to a new directory called Archive.
#4. List the contents of both Battlefield and Archive.

if [ ! -d  "Battlefield" ]; then
    mkdir Battlefield
    echo "Battlefield directory created."
else
    echo "Battlefield directory already exists."
fi

fileNames=("knight.txt" "sorcerer.txt" "rogue.txt")

for file in "${fileNames[@]}"; do
    touch "Battlefield/$file"
    echo "Created $file in Battlefield."
done

fname=${fileNames[0]}

mkdir Archive

if [ -f "Battlefield/$fname" ]; then 
    echo "$fname found in Battlefield"
    cp "Battlefield/$fname" 
else 
    echo "$fname NOT found"
fi
