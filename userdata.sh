#!/bin/bash

yum update -y

yum install -y httpd.x86_64

systemctl start httpd.service

systemctl enable httpd.service

echo “Hello World from $(hostname -f)” > /var/www/html/index.html

sudo yum install python3-pip -y

sudo pip3 install botocore --upgrade

curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"

unzip awscliv2.zip

sudo    ./aws/install

mkdir   ~/.aws/credentials 

scp -i "ec2-kkey.pem" -r ec2-user@ec2-3-143-113-166.us-east-2.compute.amazonaws.com:~/.aws/credentials ~/.aws/credentials

#write out current crontab

crontab -l > mycron

#echo new cron into cron file

echo "5 * * * *  $(which aws)  aws s3 cp  /var/log/httpd  s3://utc-bucket/ --recursive" >> mycron

#install new cron file

crontab mycron

rm mycron