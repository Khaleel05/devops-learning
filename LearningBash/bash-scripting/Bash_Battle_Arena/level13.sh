#!/bin/bash 

#level 13 Backup Script with Rotation
#mission 
#Create a script that backs up a directory to a specified location and keeps only the last 5 backups.


SOURCE_DIR="Arena"
BACKUP_DIR="Backups"

mkdir -p "$BACKUP_DIR"

TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
BACKUP_NAME="backup_$TIMESTAMP.tar.gz"
tar -czf "$BACKUP_DIR/$BACKUP_NAME" "$SOURCE_DIR"
echo "Created backup: $BACKUP_NAME"

cd "$BACKUP_DIR" || exit
ls -t | sed -e '1,5d' | while IFS= read -r file; do
    rm -f "$file"
done


#tar -czf "$BACKUP_DIR/$BACKUP_NAME" "$SOURCE_DIR" creates a compressed backup. 
#
#
#
#ls -t | sed -e '1,5d': This lists the files in the backup directory, sorted by modification time, and removes the first 5 lines from the output, which are the most recent files.
#
#
#
#while IFS= read -r file; do rm -f "$file"; done: This loop safely reads each file name (handling spaces or newlines) and deletes the files.