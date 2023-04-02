#!/bin/bash

#Checking if the log file path is provided or not
if [ $# -eq 0 ]; then 
    echo "** You didnt entered the log file path!! Please enter a log file directory path with the script. **"
    exit 1
fi

#Checking the provided log path is a valid/exists directory or not.
if [ ! -d "$1" ]; then
    echo "** The log file path you have entered, its not a valid path. **"
    exit 1
fi

log_path="$1"
logfile_duration=365
logfile_deletion_rate=20

#finding and deleting the log files.

#find "$log_path" -type f -mtime +$logfile_duration -print0 | head -z -n $logfile_deletion_rate | xargs -0 -I {} sh -c 'echo "Processing this file: {}"' 
find "$log_path" -type f -mtime +$logfile_duration -print0 | head -z -n $logfile_deletion_rate | xargs -0 -I {} sh -c 'echo "Deleting this file: {}" && rm -f {}'

#taking a record of log cleaning

echo "Cleaned the log file: $(date +%d/%m/%Y-%H:%M)" >> /home/ubuntu/logdelete-track.txt
