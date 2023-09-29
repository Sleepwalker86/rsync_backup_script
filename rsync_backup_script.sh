#!/bin/bash
# define variable 
HOST="root@192.168.10.100"
SOURCE_PATH="/your/source/path/"
DESTINATION_PATH="/your/destination/path"
EMAIL="admin@your_email.de"
# save date in variable
d=$(date +%Y-%m-%d-%H)

# path for log file
FLOG="/root/logs/rsync_$d.log"

# start rsync and write log into file
rsync -av $HOST:$SOURCE_PATH $DESTINATION_PATH --exclude=".*" --exclude=logs --copy-links --stats --delete > "$FLOG"

# check exit-Code an send email with sendmail
if [ $? -eq 0 ]; then
    echo "Backup successful" | tee -a "$FLOG"
else
    echo -e "Subject: Error in Backup\n\nBackup failed! Error Code: $?" | sendmail -v $EMAIL | tee -a "$FLOG"
fi

