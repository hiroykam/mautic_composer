#!/bin/sh

cd /var/www/html/mautic
composer update

service php-fpm start
service nginx start

while true
do
  :
done
