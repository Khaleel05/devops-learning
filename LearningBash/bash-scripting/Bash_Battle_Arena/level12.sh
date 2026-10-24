#!/bin/bash 

#level 12 Simple Configuration File Parser
#mission 
#Write a script that reads a configuration file in the format KEY=VALUE and prints each key-value pair.

CONFIG_FILE="settings.conf"

if [ ! -f "$CONFIG_FILE" ]; then
    echo "Configuration file does not exist."
    exit 1
fi

while IFS='=' read -r key value; do
    echo "Key: $key, Value: $value"
done < "$CONFIG_FILE"

#IFS sets the internal field eperator = -splitting when it sees equals 
#bash uses it to determin how to split text.