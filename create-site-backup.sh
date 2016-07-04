#!/usr/bin/env bash
# @author: Daniel Hand
# http://www.designsbytouch.co.uk
# Created:   04/07/16

DATE=`date +%Y-%m-%d`
SITESTORE=/home
SITELIST=($(ls -lh $SITESTORE | awk '{print $9}'))
BACKUPPATH=/backups

for SITE in ${SITELIST[@]};
do
mkdir -p $BACKUPPATH/$SITE/$DATE
cd /home/$SITE/public_html
wp db export $BACKUPPATH/$SITE/$DATE/$SITE-$DATE.sql --allow-root
tar -czf $BACKUPPATH/$SITE/$DATE/$SITE-$DATE.tar.gz $SITESTORE/$SITE
done

find $BACKUPPATH/$SITE/$DATE -type f -mtime +2 -exec rm {} \;
