(crontab -l 2>/dev/null; echo "0 15 * * * sh /home/ubuntu/backup.sh > /home/ubuntu/backup_cron.log 2>&1") | crontab -
