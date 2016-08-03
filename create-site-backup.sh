#!/usr/bin/env bash
# @author: Daniel Hand
# http://www.designsbytouch.co.uk
# Created:   04/07/16

DATE=`date +%d-%m-%Y`
SITESTORE=/home
SITELIST=($(ls -lh $SITESTORE | awk '{print $9}'))
BACKUPPATH=/backups

for SITE in ${SITELIST[@]};
do
mkdir -p $BACKUPPATH/$SITE/$DATE
cd /home/$SITE/public_html
sudo wp db export $BACKUPPATH/$SITE/$DATE/$SITE-$DATE.sql --allow-root
tar -czf $BACKUPPATH/$SITE/$DATE/$SITE-$DATE.tar.gz $SITESTORE/$SITE
find $BACKUPPATH/$SITE -mindepth 1 -maxdepth 1 -type d -cmin +120 | xargs rm -rf
echo "find $BACKUPPATH/$SITE -mindepth 1 -maxdepth 1 -type d -cmin +120 | xargs$
done