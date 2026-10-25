#!/bin/bash

# Back up all .txt files from the current directory.

read -r -p "Where would you like to store the backup? " BACKUP_DIR

if [[ -z "$BACKUP_DIR" ]]; then
    echo "No backup directory provided."
    exit 1
fi

mkdir -p "$BACKUP_DIR"

shopt -s nullglob
FILES=(./*.txt)

if (( ${#FILES[@]} == 0 )); then
    echo "No .txt files found in the current directory."
    exit 0
fi

TIMESTAMP=$(date '+%Y%m%d_%H%M%S')
TIMESTAMPED_BACKUP_DIR="$BACKUP_DIR/Backup_$TIMESTAMP"
mkdir -p "$TIMESTAMPED_BACKUP_DIR"

cp "${FILES[@]}" "$TIMESTAMPED_BACKUP_DIR/"
echo "Backed up ${#FILES[@]} .txt file(s) to $TIMESTAMPED_BACKUP_DIR"
