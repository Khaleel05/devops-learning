#!/bin/bash


#level 15 User-Friendly Menu Script
#mission 
#Create an interactive

#1. Presents a menu to the user with the following options:
#
#- Check disk space
#- Show system uptime
#- Backup the Arena directory and keep the last 3 backups
#- Parse a configuration file settings.conf and display the values
#
#2. Execute the chosen task.


echo "Choose an option:"
echo "1. Check disk space"
echo "2. Show system uptime"
echo "3. Backup Arena directory"
echo "4. Parse configuration file"

read -rp "Enter your choice [1-4]: " choice

case $choice in
    1)
        df -h
        ;;
    2)
        uptime
        ;;
    3)
        SOURCE_DIR="LearningBash/Arena"
        BACKUP_DIR="LearningBash/Backups"

        mkdir -p "$BACKUP_DIR"

        TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
        BACKUP_NAME="backup_$TIMESTAMP.tar.gz"
        tar -czf "$BACKUP_DIR/$BACKUP_NAME" "$SOURCE_DIR"
        echo "Created backup: $BACKUP_NAME"

        cd "$BACKUP_DIR" || exit
        ls -t | sed -e '1,5d' | while IFS= read -r file; do
            rm -f "$file"
        done
        ;;
    4)
        CONFIG_FILE="settings.conf"
        if [ ! -f "$CONFIG_FILE" ]; then
            echo "Configuration file does not exist."
            exit 1
        fi
        while IFS='=' read -r key value; do
            echo "Key: $key, Value: $value"
        done < "$CONFIG_FILE"
        ;;
    *)
        echo "Invalid option"
        ;;
esac