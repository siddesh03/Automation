#!/bin/bash
echo $1
s3name="$1"
check=`ps -ef |grep apache2 | grep -v grep | wc -l`
timestamp=$(date +%s)
if [ "$check" -gt 1 ]
then 
echo "apache is running"
else
sudo service apache2 restart
fi 
cd /var/log/apache2/
sudo tar -czvf siddeshm-httpd-logs-$timestamp.tar /var/log/apache2/*  && sudo mv siddeshm-httpd-logs-$timestamp.tar /tmp
cd /tmp
aws s3 cp siddeshm-httpd-logs-$timestamp.tar s3://$s3name/siddeshm-httpd-logs-$timestamp.tar
# till verison 1
