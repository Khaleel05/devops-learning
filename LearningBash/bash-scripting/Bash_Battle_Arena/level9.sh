#!/bin/bash 
#level 9: script to monitor Directory changes
#
#
#missoin
# Write a script that monitors a directory for any changes (file creation, modification, or deletion) and logs the changes with a timestamp.
#
#usage: ./level8.sh <directory> [logfile]
#


set -euo pipefail

# --------------------------- step 1: validation ------------------------------

# "${1:-}" is a parameter expansion. Meaning it uses the first command-line argument ($1)
#or uses an empty string if it wasnt provided or is unset. 
WATCH_DIR="${1:-}" 
LOG_FILE="theLog.txt"


if  [ ! -d $WATCH_DIR ];then
    echo "directory not found"
    exit 1 
fi 

fswatch -r "$WATCH_DIR" | while read event; do
    if [ -e "$event" ]; then
        echo "$(date +'%Y-%m-%d %H:%M:%S') File modified/created: $event" >> "$LOG_FILE"
    else
        echo "$(date +'%Y-%m-%d %H:%M:%S') File deleted: $event" >> "$LOG_FILE"
    fi
done


#fswatch is a tool you can download using 'brew install fswatch'
#if you don't have brew installed you can go to https://brew.sh

