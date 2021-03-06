#!/bin/bash
# This script installs Magento2 on Ubuntu1404 system
PASSWORD='septimo'
HOSTNAME='testmagento.org'
IP=`ip addr show | grep global | awk '{print $2}' | cut -d "/" -f1`
SPACE=" "
HOSTS=$IP$SPACE$HOSTNAME
echo $HOSTS >> /etc/hosts
echo "Installing nginx and installation dependencies"
apt-get install -y software-properties-common
echo "Installing PHP7"
echo "Adding php7 PPA"
apt-get install -y language-pack-en-base
LC_ALL=en_US.UTF-8 add-apt-repository ppa:ondrej/php
apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xcbcb082a1bb943db
echo "Installing php7"
apt-get install php7.0-fpm php7.0-mcrypt php7.0-curl php7.0-cli php7.0-mysql php7.0-gd php7.0-xsl php7.0-json php7.0-intl php-pear php7.0-dev php7.0-common php7.0-mbstring php7.0-zip php-soap libcurl3 curl -y
# Download and install magento2 
mkdir -p /var/www/
echo "Downloading composer"
curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/bin/composer
echo "Removing default nginx configuration"
rm /etc/nginx/sites-available/default
rm /etc/nginx/sites-enabled/default
echo "Install nginx magento config"
cp /home/magento.conf /etc/nginx/sites-available/
ln -s /etc/nginx/sites-available/magento.conf /etc/nginx/sites-enabled/
