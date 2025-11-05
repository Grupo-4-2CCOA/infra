crontab -e << EOF
0 12 * * * sh /home/ubuntu/backup.sh > /var/log/backup_cron.log 2>&1
EOF