#!/bin/bash 

#level 11 Automated Disk Space Report
#mission 
#Create a script that checks the disk space usage of a specified directory and sends an alert if the usage exceeds a given threshold.


DIRECTORY="./LearningBash/Arena_Boss"
THRESHOLD=1

USAGE=$(du -sm "$DIRECTORY" | awk '{print $1}')

if [ "$USAGE" -gt "$THRESHOLD" ]; then
    echo "Warning: Disk usage for $DIRECTORY is at $USAGE%!"
else
    echo "Disk usage for $DIRECTORY is at $USAGE%. All is well."
fi

