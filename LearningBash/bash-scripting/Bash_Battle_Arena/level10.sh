#!/bin/bash 

#level 10
#mission 
#Write a script that:

#1. Creates a directory called Arena_Boss.
#2. Creates 5 text files inside the directory, named file1.txt to file5.txt.
#3. Generates a random number of lines (between 10 and 20) in each file.
#4. Sorts these files by their size and displays the list.
#5. Checks if any of the files contain the word 'Victory', and if found, moves the file to a directory called Victory_Archive.

mkdir LearningBash/Arena_Boss

DIR="LearningBash/Arena_Boss"

for i in {1..5};do 
    touch "LearningBash/Arena_Boss/file$i.txt"
    FILE="LearningBash/Arena_Boss/file$i.txt"
    LINES=$((RANDOM % 11 + 10))
    for j in $(seq 1 "$LINES");do
        echo "this is line $j \n" >> "$FILE"
    done
done

ls -s $DIR

echo "Files sorted by size:"
find Arena_Boss -type f -exec ls -lh {} + | sort -k 5,5 -h


mkdir -p Victory_Archive
for F in Arena_Boss/*.txt
do
    if grep -q "Victory" "$F"; then
        mv "$F" Victory_Archive/
        echo "$F contains 'Victory' and has been moved to Victory_Archive."
    fi
done