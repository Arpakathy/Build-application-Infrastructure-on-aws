#!/bin/bash

yum update -y

yum install -y httpd.x86_64

systemctl start httpd.service

systemctl enable httpd.service

echo “Hello World from $(hostname -f)” > /var/www/html/index.html

curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"

unzip awscliv2.zip

sudo    ./aws/install

mkdir   ~/.aws/credentials 

scp -r  remoteuser@192.0.2.254:~/.aws/credentials ~/.aws/credentials

#write out current crontab

crontab -l > mycron

#echo new cron into cron file

echo "5 * * * *  $(which aws)  aws s3 cp  /var/log/httpd  s3://utc-bucket/ --recursive" >> mycron

#install new cron file

crontab mycron

rm mycron