#!/bin/bash 
#level 9: script to monitor Directory changes
#
#
#missoin
# Write a script that monitors a directory for any changes (file creation, modification, or deletion) and logs the changes with a timestamp.
#
#usage: ./level8.sh <directory> [logfile][poll_intervals_seconds]
#


set -euo pipefail

# --------------------------- step 1: validation ------------------------------

# "${1:-}" is a parameter expansion. Meaning it uses the first command-line argument ($1)
#or uses an empty string if it wasnt provided or is unset. 
WATCH_DIR ="${1:-}" 
LOG_FILE ="${2:-}"
POLL_INTERVAL_SEC ="${3:-}"

