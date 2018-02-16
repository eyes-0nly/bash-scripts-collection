#!/bin/sh

mount /dev/sda6 /mnt/BACKUPS # change partition name to yours
FILES=$(find . -maxdepth 1 -type f | wc -l)
if [ "$FILES" -lt "30" ] # number of backup files
	then
		slug=$(date +"%T_%d_%m_%Y")
		sudo -u postgres psql -c '\l' > "/mnt/BACKUPS/dumpall_postgres/list_$slug" #list of all databases
		sudo -u postgres pg_dumpall | gzip > "/mnt/BACKUPS/dumpall_postgres/dumpall_$slug.gz" # change to your path
	else
		rm -rf $(find . -maxdepth 1 -type f -printf '%T+ %p\n' | sort | head -n 1) # remove oldest backup file if their number is exceeded
		slug=$(date +"%T_%d_%m_%Y")
		sudo -u postgres psql -c '\l' > "/mnt/BACKUPS/dumpall_postgres/list_$slug"
                sudo -u postgres pg_dumpall | gzip > "/mnt/BACKUPS/dumpall_postgres/dumpall_$slug.gz" # change to your path
fi
umount /dev/sda6 # change partition name to yours

# then add cron job for root "@midnight /path/to/backup-pg.sh"
