#!/bin/bash
# This script installs Magento2 on Ubuntu1404 system
PASSWORD='septimo'
HOSTNAME='testmagento.org'
IP=`ip addr show | grep global | awk '{print $2}' | cut -d "/" -f1`
SPACE=" "
HOSTS=$IP$SPACE$HOSTNAME
echo $HOSTS >> /etc/hosts
echo "Installing nginx and installation dependencies"
apt-get install -y nginx software-properties-common
echo "Installing PHP5.6"
echo "Adding php5.6 PPA"
apt-get install -y language-pack-en-base
LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/php
apt-get update
echo "Installing php5.6"
apt-get install php5.6 php5.6-fpm php5.6-mcrypt php5.6-soap php5.6-mbstring php5.6-curl php5.6-cli php5.6-mysql php5.6-gd php5.6-intl php5.6-xsl php5.6-zip curl -y
mkdir -p /var/www
cd /var/www/
echo "Downloading magento 1.9.3.2 archive"
wget -q https://github.com/OpenMage/magento-mirror/archive/1.9.3.2.tar.gz
tar -xzf 1.9.3.2.tar.gz
rm -rf 1.9.3.2.tar.gz
mv magento-mirror-1.9.3.2/ magento
cd /var/www/magento
echo "Removing default nginx configuration"
rm /etc/nginx/sites-available/default
rm /etc/nginx/sites-enabled/default
echo "Install nginx magento config"
cp /home/magento.conf /etc/nginx/sites-available/
ln -s /etc/nginx/sites-available/magento.conf /etc/nginx/sites-enabled/
echo "Configuring website permissions"
chmod 777 -R /var/www/magento
chown -R www-data:www-data /var/www/magento
